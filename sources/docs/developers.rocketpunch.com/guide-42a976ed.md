# Source: https://developers.rocketpunch.com/guide?lang=ko

# 시작 가이드

App Key 발급부터 첫 API 호출까지, 3단계로 시작하세요.

🚧

가이드 상세는 추후 보강될 예정입니다

현재는 초청받은 빌더 대상 베타 단계로, 핵심 흐름만 안내합니다.

## 1\. App 등록 및 Key 발급

로켓펀치 계정으로 로그인 후 App 을 등록하면 용도에 맞는 인증 정보가 즉시 발급됩니다.

[App Key 발급받기](https://developers.rocketpunch.com/apps/new)

## 2\. 인증 헤더 구성

모든 요청에 발급받은 App Key 를 헤더로 포함합니다.

`X-RP-API-Key: rp_app_********`

## 3\. 첫 API 호출

API 문서에서 엔드포인트 목록과 샘플 요청을 확인할 수 있습니다.

[API 문서 보기 ↗](https://developers.rocketpunch.com/docs/index.html?lang=ko '새 탭에서 열립니다')