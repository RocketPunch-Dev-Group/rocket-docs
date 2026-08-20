# Mintlify 지원 문의문 (영문, 그대로 붙여넣기용)

> 대상: Mintlify support. 두 건 모두 다국어 사이트의 SEO 에 직접 영향이 있고 `docs.json` 으로는 해결할 수 없어 문의합니다.
> 사이트: `docs.rocketpunch.com` (subdomain `rocketpunch`, Starter plan)

---

**Subject:** Multi-language site: missing hreflang annotations and incorrect `<html lang>` on non-default language

Hi,

We run a two-language documentation site (Korean default at the root, English under `/en/`) configured with `navigation.languages` in `docs.json`. Two SEO-related issues appear in the rendered output that we cannot address from our configuration.

## 1. No `hreflang` alternate annotations anywhere

Neither the generated sitemap nor the page `<head>` declares alternates between the language versions.

```
$ curl -s https://docs.rocketpunch.com/sitemap.xml | grep -c 'xhtml:link'
0

$ curl -s https://docs.rocketpunch.com/start-history | grep -c 'hreflang'
0
$ curl -s https://docs.rocketpunch.com/en/start-history | grep -c 'hreflang'
0
```

The sitemap does include both language trees (227 URLs: 111 Korean, 116 English), and each page has a correct self-referencing canonical. But without `rel="alternate" hreflang="…"` search engines cannot associate `/start-history` with `/en/start-history` as translations of the same page.

We could not find a way to add these ourselves — `seo.metatags` in `docs.json` injects `<meta>` tags, whereas hreflang requires `<link rel="alternate">`.

**Question:** Is hreflang emission supported or planned for `navigation.languages` sites? If there is a configuration we have missed, we would be glad to apply it.

## 2. Korean pages are served with `<html lang="en">`

Both language versions declare English.

```
$ curl -s https://docs.rocketpunch.com/start-history | grep -o '<html[^>]*lang="[^"]*"'
<html lang="en"

$ curl -s https://docs.rocketpunch.com/en/start-history | grep -o '<html[^>]*lang="[^"]*"'
<html lang="en"
```

The first page is entirely Korean — its `<title>` and `<meta name="description">` are Korean and render correctly. Only the `lang` attribute is wrong.

Our configuration follows your internationalization guide: the default language lives at the repository root and other languages use prefixed directories, and `ko` is the first entry in `navigation.languages`, which the guide states makes it the default.

```json
{
  "navigation": {
    "languages": [
      { "language": "ko", "tabs": [ … ] },
      { "language": "en", "tabs": [ … ] }
    ]
  }
}
```

**Question:** Should `<html lang>` reflect the page's language on a multi-language site? If this is expected to follow `navigation.languages`, it appears not to be applied for the default (root) language.

Both issues affect how our Korean and English pages are indexed and which version is served to users. Any guidance — including a workaround we can apply on our side — would be appreciated.

Thanks,
Rocketpunch

---

## 붙여넣기 전 확인할 것

- 위 `curl` 결과는 2026-08-05 실측입니다. 문의 시점에 다시 돌려 값이 같은지 확인하세요.
- 플랜 표기(Starter)가 실제와 다르면 고쳐 주세요.
- 1번은 답이 "지원 안 함" 으로 와도 우리 쪽에서 할 수 있는 게 없습니다. 다국어 SEO 를 중시한다면 그 답변 자체가 플랜 상향이나 다른 호스팅을 검토할 근거가 됩니다.
