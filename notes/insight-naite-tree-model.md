---
kind: insight
form: prose
topics: []
subject: []
source-types: [conversation]
domains: []
created: 2026-06-10
updated: 2026-06-10
---

# naite 나무 구조 모델

naite(나이테, 시간에 따라 자라는 나이테)라는 이름과 "나무는 살아서 자라는 지식 구조"라는 은유가 정확히 맞물린다. 실제 스키마와 대보면 거의 1:1로 떨어진다.

## 스키마 매핑

현재 `kind`: `concept`, `source-record`, `session`, `course`, `question`, `decision`, `insight`, `index`.

| 나무 | 의미 | 실제 레이어/kind | 평가 |
|---|---|---|---|
| 씨앗 seed | 앞으로 만들 페이지 후보 | `_stubs` | 추가하면 완성도가 올라간다 |
| 뿌리 root | 자료 유입 | `raw/` + `source-record`/`session` | 정확히 맞는다 |
| 줄기 trunk | 구조 | `index` (notes/index.md) | 정확히 맞는다 |
| 잎 leaf | 이해가 일어나는 지식 페이지 | `concept` + `insight` (prose) | 광합성, 곧 이해가 일어나는 곳 |
| 열매 fruit | 다시 쓰는 결과물 | `decision` (+`insight`) | 맞는다. 단 entity는 미스매치 |
| 나이테 rings | 시간 성장 기록 | `log` + `session` | 이것이 곧 이름의 뜻이다 |

## 완전한 나무로

원래 아이디어에 두 가지를 더하면 레이어 전체가 한 그루 나무로 떨어진다.

- 씨앗 = `_stubs`. 아직 자라지 않은, 앞으로 페이지가 될 후보.
- 나이테 = `log`. "내가 직접 쌓아가는" 시간의 켜. 이름값을 구조가 증명한다.
- (보너스) 꽃봉오리 = `questions`. 아직 풀리지 않아 더 자랄 여지. `review`는 물주기와 가지치기, 곧 되돌아보기에 해당한다.

흐름으로 보면 이렇다. 씨앗이 뿌리로 흡수되고, 줄기로 구조화되고, 잎에서 이해가 되고, 열매로 수확해 다음에 다시 쓰며, 그 과정이 나이테로 누적된다. "내가 쌓아가는"이 그대로 그림이 된다.

## 주의점 (오버엔지니어링 경계)

`entity`는 지금 `kind`에 없다. Karpathy LLM-wiki식 "인물/대상 페이지"를 열매로 넣고 싶다면 두 길이 있다. (a) `entity` kind를 신설한다. (b) 열매를 `decision`+`insight`(수확물)로 두고 entity는 잎(`concept`)에 흡수한다. v0.0.0에서는 kind를 늘리지 않는 (b)를 택한다.

폴더명은 관습대로 `raw/`, `notes/`로 둔다. `raw`를 roots로, `notes`를 leaves로 실제 디렉터리를 바꾸면 개발자 관습에서 벗어나고, naite의 운영 원칙(콘텐츠 압력이 생기기 전에는 복잡한 분류를 만들지 않는다, 스키마를 함부로 늘리지 않는다)과도 어긋난다. 나무 은유는 README와 온보딩의 서사 및 다이어그램으로 쓰고, 구현은 단순하게 유지한다.

## 적용

이 모델은 README 데이터 모델 섹션의 나무 다이어그램으로 반영되었다. 이름(naite), 철학(내가 쌓아가는), 구조(나무)가 한 장에 연결되면 첫인상이 선명해진다.
