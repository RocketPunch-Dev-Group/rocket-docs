# rocket-web 메시지 번들 추가 후보

문서 영문화 과정에서 `messages/{ko,en}` 번들에 없어 직접 번역한 용어입니다.
제품 UI 에도 쓰이는 말이라면 번들에 넣어 문서·제품 표기를 일치시킬 수 있습니다.

- 번역 중 보고된 미수록: 227건 → 고유 196건
- 그중 실제로 번들에 이미 있던 것: 7건 (에이전트가 못 찾았을 뿐)
- **검토 대상: 189건** (제품 UI 후보 175 · 문서 전용 산문 14)

문서 전용 산문(문장 형태)은 번들에 넣을 필요가 없어 마지막에 따로 뒀습니다.


## ⚠ 먼저: 스펙에 정본이 있는 용어

아래는 OpenAPI 스펙의 enum 카탈로그에 이미 영문 라벨이 정의된 용어입니다.
`/api/v1/codes/*` 응답과 API 레퍼런스 문서에 그대로 나가므로 **여기를 따라야 하고,
문서에서 임의로 다르게 옮기면 같은 사이트 안에서 표기가 갈립니다.**

실제로 `미들` 을 문서에서 `Middle` 로 통일했다가 스펙의 `Mid-level` 과 어긋난 것을 발견해 되돌렸습니다.

| 한국어 | 스펙 정본 (openapi.en.json) |
| --- | --- |
| C레벨 | C-level |
| 계약직 | Fixed-term |
| 네트워킹 | Networking |
| 대회 | Competition |
| 라이프스타일 | Lifestyle |
| 미들 | Mid-level |
| 비즈니스 | Business |
| 시니어 | Senior |
| 신입 | Entry level |
| 위촉직 | Commissioned |
| 인문 | Humanities |
| 인턴/수습 | Intern / probationary |
| 자영업/개인사업 | Self-employed / sole proprietor |
| 정규직 | Full-time |
| 주니어 | Junior |
| 컨퍼런스 | Conference |
| 컬쳐 | Culture |
| 테크 | Technology |
| 파이낸스 | Finance |
| 팝업스토어 | Pop-up store |
| 페어 | Fair |
| 프로덕트 | Product |
| 프리랜서 | Freelance |

이 용어들은 번들 추가 대상이 아니라 **스펙이 이미 소유**하고 있습니다.

## 직무 카테고리 (28)

| 한국어 | 사용한 영문 |
| --- | --- |
| HR/인사 | HR/People |
| HW 개발 | Hardware Development |
| SW 개발 | Software Development |
| 건설/부동산 | Construction/Real Estate |
| 경영/운영 | Management/Operations |
| 교육/복지 | Education/Social Welfare |
| 금융/투자 | Banking/Investment |
| 기업용 서비스 | enterprise service |
| 기획/전략 | Planning/Strategy |
| 데이터/AI | Data/AI |
| 디자인/UX | Design/UX |
| 마케팅/PR | Marketing/PR |
| 미디어/출판 | Media/Publishing |
| 버티컬 서비스 | vertical services |
| 법률/법무 | Legal |
| 상담/영업 | Customer Service/Sales |
| 상담사 | agent |
| 서비스 | Service |
| 숙박/레저 | Hospitality/Leisure |
| 식품/조리 | Food/Culinary |
| 연구/R&D | Research/R&D |
| 운전/물류 | Driving/Logistics |
| 운전면허증 | driver's license |
| 의료/바이오 | Healthcare/Bio |
| 제조/생산 | Manufacturing/Production |
| 종교 · 단체 가입 등 교육 외 활동 권유 | Pressure to join a religion or group, or take part in activities unrelated to the course |
| 종교인 | Clergy |
| 회계/재무 | Accounting/Finance |

## 숙련도·등급 (10)

| 한국어 | 사용한 영문 |
| --- | --- |
| C레벨 | C-level |
| 고급 | Advanced (communicates freely) |
| 미들 | Mid-level (스펙 정본 · 번들 추가 대상 아님) |
| 상급 | Upper-intermediate (communicates smoothly at work) |
| 시니어 | Senior |
| 신입 | Entry level |
| 원어민 | Native |
| 주니어 | Junior |
| 중급 | Intermediate (can communicate at work) |
| 초급 | Beginner |

## 계정·인증 (17)

| 한국어 | 사용한 영문 |
| --- | --- |
| 계정 설정 | Account settings |
| 계정 인증 및 보호 정책 | Account Verification and Protection Policy |
| 계정 인증하기 | Verify your account |
| 도용 계정 | impersonation account |
| 만 15세 미만의 사용자로 보이는 계정 | An account that appears to belong to a user under 15 |
| 인증 레이블 | verification label |
| 재직증명서 / 경력증명서 | proof of employment / proof of career |
| 재학증명서 / 졸업증명서 | certificate of enrollment / certificate of graduation |
| 점유 인증 방식 | possession-based verification |
| 주민등록번호 | resident registration number (Korea's national ID number) |
| 주민등록번호 뒷자리 | the second half of your Resident Registration Number |
| 크리에이터 / 비즈니스 인증 배지 신청폼 | creator / business verification badge application form |
| 타인의 이름, 사진, 경력을 도용한 계정 | An account that uses someone else's name, photo, or career history |
| 통신서비스 이용증명원 | certificate of telecom service use |
| 핸들 | handle |
| 핸들 · 커리어 설정하기 | Set your handle and career |
| 핸들 주소 | handle address |

## 월렛 (6)

| 한국어 | 사용한 영문 |
| --- | --- |
| RP 포인트 | RP points |
| 대체불가토큰 | non-fungible token |
| 상품권 구매하기 | Purchase a gift card |
| 송금 요구나 피싱 링크 유도 등 | Requests for money transfers, phishing links, and the like |
| 스캠(사기) 토큰 | scam token |
| 프로필 주소 | profile URL |

## 채용·활동 (8)

| 한국어 | 사용한 영문 |
| --- | --- |
| 내 활동 | My activity |
| 입사지원 시 금전 요구 또는 입금 유도 | Requests for money or payments when you apply |
| 지원 내역 삭제 | Delete application history |
| 지원 언어 / 지원 통화 / 지원 시간대 | Supported languages / Supported currencies / Supported timezones |
| 채용 외 목적의 상업적 게시물 | A commercial posting unrelated to hiring |
| 채용 제안 | offers from companies |
| 채용 채팅 | Hiring chat |
| 채용공고 · 교육 신고하기 | Reporting job postings and courses |

## 피드·콘텐츠 (10)

| 한국어 | 사용한 영문 |
| --- | --- |
| 게시물 만들기 | Create a post |
| 교육 외 목적의 상업적 게시물 | A commercial posting unrelated to education |
| 동의 없이 타인의 저작물 게시 | Posting someone else's work without consent |
| 링크 미리보기 | Link preview |
| 불쾌하거나 선정적인 언어나 이미지 포함 | Offensive or sexually explicit language or images |
| 불쾌하거나 선정적인 표현 · 이미지 포함 | Contains offensive or explicit language or images |
| 선택지 | Option |
| 숨긴 게시물 | hidden posts |
| 썸네일 | Thumbnail |
| 출처 | Source |

## 이벤트 (4)

| 한국어 | 사용한 영문 |
| --- | --- |
| 무료 티켓 | Free ticket |
| 유료 티켓 | Paid ticket |
| 이벤트 티켓 등록 | Event Ticket Registration |
| 참가 상태 | Attendance status |

## 신고·정책 (9)

| 한국어 | 사용한 영문 |
| --- | --- |
| 도용 프로필 신고 | Report an impersonated profile |
| 디스커버 신고 | Report Discover |
| 디스커버 신고하기 | Reporting Discover content |
| 로켓펀치 추천 투명성 약관 | Rocketpunch recommendation transparency terms |
| 신고 · 차단 | Report · Block |
| 신고 사유 | Reason |
| 차단 내역 | Blocked |
| 프로필 신고 · 차단하기 | Report or block a profile |
| 환불 정책 | refund policy |

## 기타 (83)

| 한국어 | 사용한 영문 |
| --- | --- |
| (광고) 표시 | (Ad) label |
| 4대보험 가입내역 확인서 | national insurance enrollment certificate |
| QR 코드로 공유하기 | Share with a QR code |
| 간편결제 | easy payment service |
| 개방 행사 | Open Event |
| 검색 노출 | search visibility |
| 결제 취소 | Canceled |
| 계좌이체 | bank transfer |
| 공통 / 구직자 / 재직자 / 학생 | anyone / job seekers / employed workers / students |
| 과도한 신상 정보 요구 | Excessive requests for personal information (resident registration number and the like) |
| 광고성 정보 | marketing information |
| 국내 / 해외 | Domestic (Korea) / International |
| 근무 기간 | Work Period |
| 글자 수 | Character limit |
| 기명식 카드 / 무기명 법인카드 | named card / unnamed corporate card |
| 기프트카드 | gift voucher |
| 기프티콘 | gifticon |
| 날짜 | Date |
| 내러티브 라운지 | Narrative Lounge |
| 내용 | Details |
| 다이렉트 메시지 | Direct message (1:1) |
| 대량 발송이나 무관한 광고 메시지 | Bulk or irrelevant advertising messages |
| 더보기 버튼 ☰ | More button ☰ |
| 등록 행사 | Registered Event |
| 로켓펀치 프리미엄 | Rocketpunch Premium |
| 면접 합격 | Passed interview |
| 무신사 | Musinsa |
| 민팅 | minting |
| 박당 요금 | price per night |
| 번역 버튼 | translate button |
| 범죄 계획 공유나 테러 미화 | Sharing criminal plans or glorifying terrorism |
| 새 대화 버튼 | new chat button |
| 서류 접수 | Application received |
| 서류 접수 / 서류 합격 / 면접 합격 | Application received / Passed document screening / Passed interview |
| 서류 합격 | Passed document screening |
| 서식 | Formatting |
| 서울, 도쿄, 런던, 파리, 시드니 | Seoul, Tokyo, London, Paris, Sydney |
| 성급 | star rating |
| 성별, 연령 등 부적절한 조건 명시 | Inappropriate requirements such as gender or age |
| 셀프구직 | self-directed job search |
| 속보 | Breaking news |
| 수수료 | fee |
| 수신거부 | Unsubscribe |
| 숙소 유형 | property type |
| 스왑 | swap |
| 스팸함 | spam folder |
| 슬리피지 | slippage |
| 승인 필요 | Approval required |
| 실제 내용과 다른 제목이나 요약 | A title or summary that differs from the actual content |
| 실제 존재하지 않는 직무나 기업 정보 | A role or company that does not actually exist |
| 실제와 다른 교육 정보 기재 | Course information that differs from reality |
| 안내된 수강료 외 금전 요구 | Requests for money beyond the stated tuition |
| 에어드랍 | airdrop |
| 연결 신청 | connection request |
| 운영팀 | our operations team |
| 위치 / 방법 | Where / How |
| 자기 소개 등에서 차별적 언행 포함 | Discriminatory language in the bio or elsewhere |
| 자동 승인 | Automatic approval |
| 자산 목록 | asset list |
| 자유 입력 | Free text (up to 500 characters) |
| 자해, 자살 권유나 관련 묘사 | Encouragement or depiction of self-harm or suicide |
| 장기 일정 행사 선택 가능 | long-term events supported (용어집 '장기 일정 행사' = Long-term event 기반) |
| 재학 기간 | Enrollment Period |
| 저작권 등 권리를 침해한 소식 | News that infringes copyright or other rights |
| 정렬 | Sort |
| 제출 | Submit |
| 주요 명소까지의 거리 | distance to major attractions |
| 줄 바꿈 | Line breaks |
| 청구서 | invoice |
| 체크아웃 | check-out |
| 최저가 보장 | lowest price guarantee |
| 캐시백 | cashback |
| 타인에 대한 모욕적 표현 | Insulting language toward another person |
| 투숙객 | guest |
| 편의시설 | amenities |
| 프로필 단축 URL | short profile URL |
| 필터 | Filter |
| 할인율 높은 순 | biggest discount |
| 항목 | Field |
| 항목 / 내용 | Item / Description |
| 허위 사실이나 왜곡된 정보 포함 | Contains false or distorted information |
| 호텔 평점 | hotel review score |
| 홍보를 목적으로 한 광고성 소식 | Promotional news posted as advertising |

## 문서 전용 산문 (14)

문장 형태라 UI 라벨이 아닙니다. 참고용으로만 둡니다.

| 한국어 | 사용한 영문 |
| --- | --- |
| K-디지털 트레이닝 / K-디지털 기초역량훈련 / 고용노동부 | K-Digital Training / K-Digital Credit / Ministry of Employment and Labor |
| New 로켓펀치 / 로켓펀치 2.0 / 3.0 | New Rocketpunch / Rocketpunch 2.0 / 3.0 |
| SW 개발, 데이터/AI, 기획/전략, 디자인/UX | Software development, data/AI, planning/strategy, design/UX |
| 당사자 동의 없이 신상이나 위치 등 개인정보 노출 | Exposing personal information such as identity or location without consent |
| 매우 작은 규모(30명 미만) 등 기업 규모 옵션 | Very small (under 30 employees), Small (30-100 employees), Medium (100-400 employees), Large (400-2,000 employees), Very large (over 2,000 employees) |
| 비대면 과정 / 오프라인 출석 과정 / 비대면·대면 혼합 과정 | remote courses / in-person courses / courses that mix the two |
| 상시 출근 / 출근 · 재택 혼합 / 상시 재택 | Always on-site (no remote work) / Hybrid (1-4 remote days a week) / Fully remote (occasional on-site work included) |
| 신입 / 주니어 / 미들 / 시니어 / C레벨 | Entry level / Junior / Mid-level / Senior / C-level |
| 신한카드 · 삼성카드 · 현대카드 · KB국민카드 · 롯데카드 · 우리카드 · 하나카드 · NH농협카드 · BC카드 | Shinhan Card · Samsung Card · Hyundai Card · KB Kookmin Card · Lotte Card · Woori Card · Hana Card · NH Nonghyup Card · BC Card |
| 인종, 성별, 종교 등에 대한 편견이나 혐오 발언 | Prejudice or hate speech about race, gender, religion, and so on |
| 학력, 경력, 자격 등 사실과 다른 정보 기재 | False information about education, work experience, or credentials |
| 한국어, 영어, 스페인어, 중국어(번체·간체), 일본어, 베트남어, 태국어, 독일어, 프랑스어, 포르투갈어 | Korean, English, Spanish, Chinese (Traditional and Simplified), Japanese, Vietnamese, Thai, German, French, Portuguese |
| 핸들 주소 / `핸들.rockets.app` | Handle address / `handle.rockets.app` |
| 핸들.rockets.app | handle.rockets.app |

## 엔터프라이즈 콘솔 (28)

PR #21 의 콘솔 문서를 영문화하며 직접 옮긴 UI 라벨입니다. 콘솔은 English 를 지원하므로
(`console/start-language.mdx`) 제품에 이미 정본 라벨이 있을 수 있습니다. **번들이 아니라
콘솔 실제 표기를 먼저 확인해야 합니다.** 확인되면 문서를 그쪽에 맞춥니다.

`기업 서비스` 는 www.rocketpunch.com 영문 화면의 `Enterprise Services` 를 그대로 따랐습니다.

| 한국어 | 사용한 영문 | 확인 |
| --- | --- | --- |
| 기업 서비스 | Enterprise Services | 웹 확인됨 |
| 결제 관리 | Billing | 미확인 |
| 게스트 및 대기열 | Guests and queue | 미확인 |
| 공고 리뷰어 | Posting reviewer | 미확인 |
| 공지 발송 | Announcements | 미확인 |
| 광고 | Advertising | 미확인 |
| 권한 관리 | Permissions | 미확인 |
| 권한 및 설정 | Permissions and settings | 미확인 |
| 구성원 | Member | 미확인 |
| 기본 정보 | Basic information | 미확인 |
| 기업 상세 정보 | Company details | 미확인 |
| 기업 정보 | Company information | 미확인 |
| 등록 행사 / 개방 행사 | Registered Event / Open Event | 용어집 기존 항목 |
| 메시지함 | Messages | 미확인 |
| 모집 중 / 모집 종료 | Enrolling / Enrollment closed | 미확인 |
| 상점 | Store | 미확인 |
| 소유자 / 주소유자 | Owner / Primary owner | 미확인 |
| 세션 및 연사 | Sessions and speakers | 미확인 |
| 임시 저장 | Draft / Save draft | 미확인 |
| 재직자(관련 사람) | People | 미확인 |
| 접수 대기 / 주문 승인 / 배송 완료 / 주문 취소 | Pending / Order approved / Delivered / Order canceled | 미확인 |
| 추가 결제 요청 | Request additional payment | 미확인 |
| 추가 관리자 | Additional admin | 미확인 |
| 판매 상품 관리 | Manage products | 미확인 |
| 한정 수량 | Limited quantity | 미확인 |
| 호스트 승인 필요 | Host approval required | 미확인 |
| 환불 및 취소 | Refund and cancel | 미확인 |
| 개별 항목 액세스 권한 | Item-level access | 미확인 |
