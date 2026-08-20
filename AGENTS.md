# rocket-docs 작업 지침

[Mintlify](https://mintlify.com) 기반 문서 사이트입니다. 페이지는 YAML frontmatter 를 가진 MDX 이고 설정은 `docs.json` 에 있습니다.

## 저작 경로가 둘입니다

| 경로 | 대상 | 반영 |
| --- | --- | --- |
| Mintlify 콘솔(웹 에디터) | 기획팀이 한국어 문서를 작성 | `main` 에 직접 커밋 |
| git PR | 영문판 · 설정 · 스크립트 · 워크플로 | 리뷰 후 머지 |

`main` push 는 Mintlify GitHub App 이 **즉시 발행**합니다. 저장이 곧 공개이므로 되돌리기가 어렵습니다.

콘솔 편집은 막지 않습니다(기획팀의 의도된 저작 방식). CI 는 PR 경로에만 차단 검사를 겁니다.

## 언어 구조

한국어가 원문이고 루트에, 영문은 `en/` 아래에 같은 파일명으로 둡니다.

```
start-history.mdx      →  /start-history        (ko)
en/start-history.mdx   →  /en/start-history     (en)
```

한국어 경로는 옮기지 마세요. 과거에 두 번 옮기면서 공개 URL 이 전부 404 가 된 적이 있어 `docs.json` 의 `redirects` 로 복구해 두었습니다.

`docs.json` 의 `navigation.languages` 는 언어별로 전체 내비게이션을 따로 적어야 합니다. 폴백이 없어 한쪽에만 있는 페이지는 그 언어에서 404 입니다.

## 번역

**UI 용어는 지어내지 말고 실제 제품 표기를 따릅니다.** `rocket-web` 의 `messages/ko/*.json` 과 `messages/en/*.json` 을 키로 짝지으면 그대로 용어집이 됩니다.

한국어 원문이 바뀌면 영문도 갱신하고 기록합니다.

```bash
# 영문을 고친 뒤
./scripts/check-translation-sync.sh --update
```

`translation-sync` 워크플로가 원문 blob 해시로 드리프트를 추적합니다. 콘솔 편집으로 원문만 바뀌면 추적 이슈가 자동으로 열리고, 영문을 맞추면 자동으로 닫힙니다.

## API 레퍼런스는 생성물입니다

`openapi/openapi.json` 과 `openapi/openapi.en.json` 은 `rocket-open-api` 가 코드에서 만들어내는 산출물입니다. **직접 편집하지 마세요** — `sync-openapi-spec` 워크플로가 매시 덮어씁니다. 내용을 고치려면 `rocket-open-api` 에서 고칩니다.

엔드포인트 페이지는 스펙에서 자동 생성되므로 엔드포인트가 늘어도 `docs.json` 을 건드릴 필요가 없습니다.

## 문체

- 한국어는 존댓말 도움말체. 영문은 2인칭(you), 간결하게.
- 제목은 sentence case.
- 화면 요소는 백틱: `설정` \> `활동`
- 한 문장에 한 가지만.

## 검사

PR 에서 자동으로 돕니다. 로컬에서도 같은 것을 돌릴 수 있습니다.

```bash
npx mint@latest validate            # 빌드 검증
npx mint@latest broken-links        # 내부 링크
./scripts/check-rocketpunch-hosts.sh   # *.rocketpunch.com 호스트 오타
./scripts/check-translation-sync.sh    # 영문 드리프트
```

`mint broken-links` 는 내부 상대 링크만 봅니다. 외부 절대 URL 의 호스트 오타는 `check-rocketpunch-hosts.sh` 가 잡습니다.

## 콘솔 커밋의 작성자 귀속

Mintlify 콘솔 편집은 작성자의 GitHub 계정이 연결돼 있지 않으면 `mintlify[bot]` 이름으로 커밋됩니다.
실제로 문서를 쓴 사람의 기여가 GitHub 기여 그래프에 남지 않습니다.

**근본 해결은 Mintlify 대시보드에서 작성자의 GitHub 계정을 연결하는 것입니다.** 연결되면 커밋 author 가
처음부터 본인이 됩니다(예: `Seunguk <62605811+aware-in@users.noreply.github.com>` 으로 남은 커밋들).

연결 전에 쌓인 커밋은 `Co-authored-by:` 트레일러로 뒤늦게 메울 수 있습니다.

```bash
./scripts/add-mintlify-coauthor.sh origin/main..edit-console
git push --force-with-lease origin edit-console
```

기본 브랜치를 되쓰면 열려 있는 PR 이 `base_ref_force_pushed` 로 **자동으로 닫히고 재열기가 되지 않습니다**
(실제로 #21 이 이렇게 닫혀 #22 로 옮겼습니다). 되쓰기는 작업 브랜치에서 머지 전에 끝내세요.
