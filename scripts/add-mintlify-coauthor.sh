#!/usr/bin/env bash
#
# add-mintlify-coauthor.sh
# ────────────────────────
# Mintlify 콘솔(대시보드 에디터) 커밋에 실제 작성자를 co-author 로 붙인다.
#
# 배경:
#   콘솔 편집은 작성자의 GitHub 계정이 연결돼 있지 않으면 `mintlify[bot]` 이름으로 커밋된다.
#   실제로 문서를 쓴 사람의 기여가 GitHub 기여 그래프에 하나도 남지 않는다.
#   `Co-authored-by:` 트레일러를 붙이면 기본 브랜치 기준으로 그 사람의 그래프에 잡힌다.
#
# 근본 해결은 Mintlify 대시보드에서 작성자의 GitHub 계정을 연결하는 것이다.
# 그렇게 하면 이후 커밋은 처음부터 본인 이름으로 남고 이 스크립트가 필요 없다.
# 아직 연결되지 않은 동안 새로 쌓인 커밋을 뒤늦게 메우는 용도로만 쓴다.
#
# 사용:
#   ./scripts/add-mintlify-coauthor.sh <base>..<branch>   # 되쓸 구간
#   ./scripts/add-mintlify-coauthor.sh origin/main..edit-console
#
#   되쓴 뒤 force-push 가 필요하다. 기본 브랜치를 되쓰면 열려 있는 PR 이
#   base_ref_force_pushed 로 자동으로 닫히고 재열기가 불가능하다. 브랜치에만 쓰는 것을 권장한다.
#
# 되돌리기:
#   되쓰기 전에 원본을 남겨 둔다. 예) git push origin <branch>:refs/heads/backup/<branch>
#
set -euo pipefail

BOT_EMAIL="109931778+mintlify[bot]@users.noreply.github.com"
COAUTHOR="${MINTLIFY_COAUTHOR:-gnuoyeseel <306409418+gnuoyeseel@users.noreply.github.com>}"

RANGE="${1:-}"
if [ -z "$RANGE" ]; then
  echo "사용법: $0 <base>..<branch>   (예: origin/main..edit-console)" >&2
  exit 2
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "── Mintlify 커밋 co-author 부착 ────────────────────────"
echo "  구간   : $RANGE"
echo "  대상   : author == $BOT_EMAIL"
echo "  붙일 값: Co-authored-by: $COAUTHOR"
target=$(git log "$RANGE" --author="$(printf '%s' "$BOT_EMAIL" | sed 's/\[/\\[/g')" --format=%H | wc -l | tr -d ' ')
echo "  해당 커밋: ${target}건"
echo

rm -rf .git/refs/original
FILTER_BRANCH_SQUELCH_WARNING=1 BOT_EMAIL="$BOT_EMAIL" COAUTHOR="$COAUTHOR" \
git filter-branch -f --msg-filter '
  if [ "$(git log -1 --format=%ae "$GIT_COMMIT")" = "$BOT_EMAIL" ]; then
    git interpret-trailers --if-exists addIfDifferent --trailer "Co-authored-by: $COAUTHOR"
  else
    cat
  fi
' -- "$RANGE"

echo
echo "  ✓ 되쓰기 완료. 파일 내용은 바뀌지 않습니다(트리 해시 동일)."
echo "    확인 후 force-push 하세요:  git push --force-with-lease origin <branch>"
echo "────────────────────────────────────────────────────────"
