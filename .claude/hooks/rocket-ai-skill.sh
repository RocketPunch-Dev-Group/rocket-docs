#!/bin/bash
# 공통 스킬(rocket-ai-skill) 부트스트랩 — 각 레포 .claude/settings.json의 SessionStart 훅이 부른다.
# 설치돼 있으면 ~/rocket-ai-skill/hooks/session-start.sh로 최신화하고, 없으면 설치한다.
# 원본은 rocket-ai-skill/hooks/repo-bootstrap.sh — 레포에는 .claude/hooks/rocket-ai-skill.sh로 복사해 둔다.
# 실패해도 세션을 막지 않는다(항상 exit 0). 실패하면 다음 세션에서 다시 시도한다.

DIR="$HOME/rocket-ai-skill"
REPO_URL="https://github.com/RocketPunch-Dev-Group/rocket-ai-skill.git"

notice() { printf '{"systemMessage":"%s"}\n' "$1"; }

if [ -x "$DIR/hooks/session-start.sh" ]; then
  exec "$DIR/hooks/session-start.sh"
fi
if [ -e "$DIR" ]; then
  notice "공통 스킬: ~/rocket-ai-skill이 설치본이 아닙니다. 확인 후 지우면 다음 세션에서 자동 설치됩니다."
  exit 0
fi

# 세션 여러 개가 동시에 열려도 한 세션만 설치한다. 강제 종료로 남은 잠금은 2분 뒤 무시한다.
lock="$DIR.lock"
tmp="$DIR.installing.$$"
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
  printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","reloadSkills":true}}\n'
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

if "$DIR/install.sh" >/dev/null 2>&1; then
  printf '{"systemMessage":"%s","hookSpecificOutput":{"hookEventName":"SessionStart","reloadSkills":true}}\n' \
    "공통 스킬을 ~/rocket-ai-skill에 설치했습니다(common 묶음). 분야 묶음 추가: ~/rocket-ai-skill/install.sh --packs backend"
else
  notice "공통 스킬: 받았지만 스킬 연결에 실패했습니다. ~/rocket-ai-skill/install.sh를 직접 실행해 보세요."
fi
exit 0
