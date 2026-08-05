#!/usr/bin/env bash
#
# check-translation-sync.sh
# ─────────────────────────
# 한국어 원문이 바뀌었는데 영문판이 따라오지 않은 페이지를 찾는다.
#
# 배경:
#   한국어는 Mintlify 콘솔에서 작성되어 main 에 직접 커밋되고, 영문은 우리가 손으로 관리한다.
#   원문이 바뀌어도 영문은 그대로 남는데, 빌드도 링크 검사도 통과하므로 아무도 모른 채
#   낡은 번역이 계속 발행된다. 이 스크립트가 그 드리프트를 드러낸다.
#
# 원리:
#   번역을 마친 시점의 한국어 파일 blob 해시를 기록해 두고, 현재 해시와 비교한다.
#   내용이 1바이트라도 바뀌면 해시가 달라지므로 놓치지 않는다.
#
# 사용:
#   ./scripts/check-translation-sync.sh            # 검사 (낡은 번역이 있으면 exit 1)
#   ./scripts/check-translation-sync.sh --update   # 번역을 마친 뒤 현재 상태를 기록
#
# 종료 코드: 낡은 번역·누락이 있으면 1, 깨끗하면 0.
#
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

STATE="scripts/translation-state.json"
MODE="${1:-check}"

command -v python3 >/dev/null 2>&1 || { echo "✗ python3 가 필요합니다." >&2; exit 2; }

python3 - "$STATE" "$MODE" <<'PY'
import glob
import json
import os
import subprocess
import sys

state_path, mode = sys.argv[1], sys.argv[2]

def blob(path):
    """git 이 그 파일 내용에 매기는 해시. 커밋 여부와 무관하게 내용만 반영한다."""
    return subprocess.run(['git', 'hash-object', path],
                          capture_output=True, text=True, check=True).stdout.strip()

# ko 원문 = en/ 을 제외한 모든 mdx. 재귀로 훑어야 새 하위 폴더가 생겨도 누락되지 않는다.
sources = sorted(
    f for f in glob.glob('**/*.mdx', recursive=True)
    if not f.startswith('en/')
)

recorded = {}
if os.path.exists(state_path):
    with open(state_path, encoding='utf-8') as f:
        recorded = json.load(f).get('sources', {})

stale, untracked, missing_en, orphan_en = [], [], [], []

for src in sources:
    en = f'en/{src}'
    if not os.path.exists(en):
        missing_en.append(src)
        continue
    current = blob(src)
    if src not in recorded:
        untracked.append(src)
    elif recorded[src] != current:
        stale.append(src)

# 원문이 사라졌는데 영문만 남은 경우
for en in sorted(glob.glob('en/**/*.mdx', recursive=True)):
    src = en[len('en/'):]
    if not os.path.exists(src):
        orphan_en.append(en)

if mode == '--update':
    payload = {
        'note': '번역을 마친 시점의 한국어 원문 blob 해시. scripts/check-translation-sync.sh 가 관리한다.',
        'sources': {src: blob(src) for src in sources if os.path.exists(f'en/{src}')},
    }
    with open(state_path, 'w', encoding='utf-8') as out:
        json.dump(payload, out, ensure_ascii=False, indent=2, sort_keys=True)
        out.write('\n')
    print(f"기록 완료: {len(payload['sources'])}개 페이지")
    sys.exit(0)

print('── 번역 동기화 검사 ────────────────────────────────────')
print(f'  원문 {len(sources)}개 / 기록 {len(recorded)}개')
print()

def section(title, items, hint):
    if not items:
        return False
    print(f'  ✗ {title} ({len(items)})')
    print(f'    └ {hint}')
    for i in items[:30]:
        print(f'      - {i}')
    if len(items) > 30:
        print(f'      … 외 {len(items) - 30}건')
    print()
    return True

failed = False
failed |= section('STALE: 한국어가 바뀌었는데 영문이 그대로', stale,
                  'en/<파일> 을 갱신한 뒤 ./scripts/check-translation-sync.sh --update 로 기록하세요')
failed |= section('MISSING-EN: 영문판이 없는 페이지', missing_en,
                  'en/<파일> 을 만들고 docs.json 의 en 탭에 등록하세요')
failed |= section('ORPHAN-EN: 원문이 사라진 영문판', orphan_en,
                  '원문이 삭제됐다면 영문도 지우고 docs.json 에서 제거하세요')
section('UNTRACKED: 기록에 없는 페이지(경고)', untracked,
        '새로 추가된 페이지입니다. 번역 후 --update 로 기록하세요')

if not failed:
    print('  ✓ 영문판이 한국어 원문과 동기화되어 있습니다.'
          + ('' if not untracked else ' (UNTRACKED 경고는 종료 코드에 영향 없음)'))
print('────────────────────────────────────────────────────────')
sys.exit(1 if failed else 0)
PY
