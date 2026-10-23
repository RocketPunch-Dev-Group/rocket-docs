#!/bin/bash
# 공통 스킬(rocket-ai-skill) 부트스트랩 — 각 레포의 SessionStart 훅이 부른다.
#   Claude Code: .claude/settings.json → .claude/hooks/rocket-ai-skill.sh
#   Codex:       .codex/hooks.json     → .claude/hooks/rocket-ai-skill.sh codex
# 설치돼 있으면 그 설치본의 hooks/session-start.sh로 최신화하고, 없으면 설치한다.
# 원본은 rocket-ai-skill/hooks/repo-bootstrap.sh — 레포에는 .claude/hooks/rocket-ai-skill.sh로 복사해 둔다.
# 실패해도 세션을 막지 않는다(항상 exit 0). 실패하면 다음 세션에서 다시 시도한다.
#
# 설치 위치는 이 순서로 찾는다.
#   1. ROCKET_AI_SKILL_HOME — 직접 정한 위치
#   2. ~/.claude/skills·~/.agents/skills의 rp-* 링크가 가리키는 설치본 — install.sh로 다른 곳에 설치한 경우
#   3. ~/rocket-ai-skill — 기본값
# 어디에도 없으면 1(없으면 3)에 설치한다. ROCKET_AI_SKILL_AUTO_INSTALL=0이면 설치하지 않고 안내만 한다.

REPO_URL="https://github.com/RocketPunch-Dev-Group/rocket-ai-skill.git"
CLIENT="${1:-claude}"

find_install() {
  local link target root
  if [ -n "${ROCKET_AI_SKILL_HOME:-}" ]; then
    echo "${ROCKET_AI_SKILL_HOME%/}"
    return
  fi
  for link in "$HOME"/.claude/skills/rp-* "$HOME"/.agents/skills/rp-*; do
    [ -L "$link" ] || continue
    target="$(readlink "$link")"
    root="${target%/skills/*}"
    if [ "$root" != "$target" ] && [ -x "$root/hooks/session-start.sh" ]; then
      echo "$root"
      return
    fi
  done
  echo "$HOME/rocket-ai-skill"
}
DIR="$(find_install)"
SHOWN="${DIR/#$HOME/~}"

# 훅 응답을 낸다. Claude Code 형식(JSON)으로 받아, Codex면 Codex가 아는 systemMessage만 남긴다.
# Codex에는 reloadSkills가 없어 Claude 전용 필드는 넘기지 않는다.
emit() {
  [ -n "$1" ] || return 0
  if [ "$CLIENT" = codex ]; then
    local msg
    msg="$(printf '%s' "$1" | sed -n 's/.*"systemMessage":"\([^"]*\)".*/\1/p' | sed "s/'! /'/g")"
    [ -n "$msg" ] && printf '{"systemMessage":"%s"}\n' "$msg"
  else
    printf '%s\n' "$1"
  fi
  return 0
}
notice() { emit "$(printf '{"systemMessage":"%s"}' "$1")"; }

if [ -x "$DIR/hooks/session-start.sh" ]; then
  emit "$("$DIR/hooks/session-start.sh")"
  exit 0
fi
if [ -e "$DIR" ]; then
  notice "공통 스킬: ${SHOWN}이 설치본이 아닙니다. 확인 후 지우거나 ROCKET_AI_SKILL_HOME으로 다른 위치를 정하세요."
  exit 0
fi
if [ "${ROCKET_AI_SKILL_AUTO_INSTALL:-1}" = 0 ]; then
  notice "공통 스킬이 설치돼 있지 않습니다(자동 설치 꺼짐). 원하는 위치에 clone한 뒤 install.sh를 실행하세요: $REPO_URL"
  exit 0
fi

# 세션 여러 개가 동시에 열려도 한 세션만 설치한다. 강제 종료로 남은 잠금은 2분 뒤 무시한다.
lock="$DIR.lock"
tmp="$DIR.installing.$$"
if ! mkdir -p "$(dirname "$DIR")" 2>/dev/null; then
  notice "공통 스킬: ${SHOWN}의 상위 폴더를 만들 수 없습니다. ROCKET_AI_SKILL_HOME을 확인하세요."
  exit 0
fi
if [ -n "$(find "$lock" -maxdepth 0 -mmin +2 2>/dev/null)" ]; then
  rmdir "$lock" 2>/dev/null
fi
if ! mkdir "$lock" 2>/dev/null; then
  notice "공통 스킬: 다른 세션이 설치하는 중입니다. 다음 세션부터 보입니다."
  exit 0
fi
trap 'rm -rf "$tmp"; rmdir "$lock" 2>/dev/null' EXIT

if [ -e "$DIR" ]; then
  # 잠금을 기다리는 사이 다른 세션이 설치를 마쳤다
  emit '{"hookSpecificOutput":{"hookEventName":"SessionStart","reloadSkills":true}}'
  exit 0
fi

# 받는 도중에는 설치본으로 보이지 않도록 임시 폴더에 받은 뒤 옮긴다
err="$(GIT_TERMINAL_PROMPT=0 git clone -q "$REPO_URL" "$tmp" 2>&1)"
if [ $? -ne 0 ]; then
  case "$err" in
    *"Could not resolve host"*|*"timed out"*|*"Failed to connect"*|*"Network is unreachable"*)
      notice "공통 스킬: 오프라인이라 설치하지 못했습니다. 다음 세션에서 다시 시도합니다." ;;
    *)
      notice "공통 스킬 자동 설치에 실패했습니다. '! gh auth login'과 '! gh auth setup-git'을 실행한 뒤 새 세션을 여세요." ;;
  esac
  exit 0
fi
mv "$tmp" "$DIR"

if ! "$DIR/install.sh" >/dev/null 2>&1; then
  notice "공통 스킬: 받았지만 스킬 연결에 실패했습니다. ${SHOWN}/install.sh를 직접 실행해 보세요."
elif [ "$CLIENT" = codex ]; then
  notice "공통 스킬을 ${SHOWN}에 설치했습니다(common 묶음). 스킬이 보이지 않으면 Codex를 다시 시작하세요."
else
  emit "$(printf '{"systemMessage":"%s","hookSpecificOutput":{"hookEventName":"SessionStart","reloadSkills":true}}' \
    "공통 스킬을 ${SHOWN}에 설치했습니다(common 묶음). 위치를 바꾸려면 ROCKET_AI_SKILL_HOME, 분야 묶음 추가는 ${SHOWN}/install.sh --packs backend")"
fi
exit 0
