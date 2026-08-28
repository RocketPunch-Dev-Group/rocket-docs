#!/usr/bin/env bash
#
# check-rocketpunch-hosts.sh
# ──────────────────────────
# 문서에 등장하는 *.rocketpunch.com 호스트가 실재하는 것뿐인지 확인한다.
#
# 배경:
#   `mint broken-links` 는 내부 상대 링크만 검사하고 외부 절대 URL 은 통과시킨다.
#   실제로 /developer → /openapi 일괄 치환이 `https://developers.rocketpunch.com` 의
#   `//developer` 까지 잡아 `openapis.rocketpunch.com`(존재하지 않는 호스트)으로 바꿔 놓았고,
#   링크 검사와 빌드 검증을 모두 통과해 리뷰에서야 발견됐다.
#
#   호스트가 셋뿐이고 역할이 명확하므로(문서·콘솔·API) 허용 목록으로 막는 편이
#   외부 링크를 실제로 호출하는 검사보다 빠르고 flaky 하지 않다.
#
# 사용:
#   ./scripts/check-rocketpunch-hosts.sh
#   ALLOW_EXTRA='beta\.rocketpunch\.com' ./scripts/check-rocketpunch-hosts.sh
#
# 종료 코드: 알 수 없는 호스트가 있으면 1, 없으면 0.
#
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

# 실재하는 호스트. 2026-08-05 기준 DNS·HTTP 응답으로 확인했다.
# 새 호스트가 생기면 실재 여부를 확인한 뒤 여기에 추가한다.
#   www 서비스 · docs 문서 · developers 개발자 콘솔 · openapi API 서버
#   enterprise 기업용 · image 이미지 CDN · partner/support 폼 · travel 트래블
ALLOWED='^(www|docs|developers|openapi|enterprise|image|partner|support|travel|ads)$'
ALLOW_EXTRA="${ALLOW_EXTRA:-}"

echo "── rocketpunch.com 호스트 검사 ─────────────────────────"

# mdx·json·yml 에서 <sub>.rocketpunch.com 형태를 모두 수집
found=$(grep -rhoE '[A-Za-z0-9-]+\.rocketpunch\.com' \
          --include='*.mdx' --include='*.json' --include='*.yml' --include='*.yaml' . \
          2>/dev/null | sort -u || true)

if [ -z "$found" ]; then
  echo "  참조된 rocketpunch.com 호스트가 없습니다."
  echo "────────────────────────────────────────────────────────"
  exit 0
fi

bad=""
for host in $found; do
  sub="${host%%.rocketpunch.com}"
  if echo "$sub" | grep -qE "$ALLOWED"; then continue; fi
  if [ -n "$ALLOW_EXTRA" ] && echo "$host" | grep -qE "$ALLOW_EXTRA"; then continue; fi
  bad="$bad $host"
done

echo "  참조된 호스트: $(echo "$found" | tr '\n' ' ')"
echo

if [ -n "$bad" ]; then
  for host in $bad; do
    echo "  ✗ 알 수 없는 호스트: $host"
    grep -rn "$host" --include='*.mdx' --include='*.json' --include='*.yml' . 2>/dev/null \
      | sed 's|^\./||' | cut -c1-160 | sed 's/^/      /' | head -20
  done
  echo
  echo "    └ 오타라면 고치고, 실제로 새로 생긴 호스트라면 이 스크립트의 ALLOWED 에 추가하세요."
  echo "────────────────────────────────────────────────────────"
  exit 1
fi

echo "  ✓ 모두 실재하는 호스트입니다."
echo "────────────────────────────────────────────────────────"
