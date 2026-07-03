# Source: https://developers.rocketpunch.com/?lang=ko

초청 빌더 베타

# 빌더를 위한 
로켓펀치 Open API

채용·이벤트·기업 데이터를 손쉽게 연결하세요. App Key 한 번 발급으로 로켓펀치의 데이터 위에 다음 세대의 빌더 제품을 만들 수 있습니다.

[App Key 발급받기](https://developers.rocketpunch.com/apps/new) [API 문서 보기 ↗](https://developers.rocketpunch.com/docs/index.html?lang=ko '새 탭에서 열립니다')

**11개** 지원 언어

**17만+** 기업 프로필 인덱스

**99.95%** 가용성 SLA

example.js

// 발급받은 App Key로 AI 채용공고 검색
const res = await fetch(
 "https://openapi.rocketpunch.com/api/v1/jobs?keyword=AI",
 { headers: { "X-RP-API-Key": "rp\_app\_\*\*\*\*\*\*\*\*" } },
);

const { items } = await res.json();

Why Rocketpunch Open API

## 빌더가 좋아하는 인터페이스

설계부터 빌더 친화적입니다. 발급, 호출, 모니터링을 한 콘솔에서.

⚡

### 1분이면 발급 완료

앱 이름과 용도를 고르면 필요한 인증 정보가 즉시 발급됩니다. 별도 승인 절차 없음.

🔑

### OAuth 2.0 호환

리다이렉트 URI 등록만 하면 사용자 동의 기반 데이터 접근까지 한 번에.

🌐

### 다국어 지원

한국어 포함 11개 언어의 프로필·공고 데이터를 일관된 스키마로 제공합니다.

How it works

## 3단계로 시작하기

가장 빠른 빌더를 위한 가장 빠른 온보딩.

1

### 앱 등록하기

앱 이름, 설명, 콜백 URI를 입력하고 등록하면 즉시 키 페어가 발급됩니다.

2

### API 문서 확인하기

발급된 키로 인증 헤더를 구성하고 샘플 코드와 함께 즉시 호출해 볼 수 있습니다.

3

### 제품 배포하기

실시간 사용량 모니터링과 함께 빌더 제품을 로켓펀치 커뮤니티에 공유하세요.

[지금 App Key 발급받기 →](https://developers.rocketpunch.com/apps/new)