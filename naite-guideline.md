# naite — 프로젝트 아이디어 가이드라인 (인계용)

이 문서는 naite를 오픈소스로 패키징하기 위해 지금까지 확정된 정보를 한곳에 모은 인계 문서다. daehyeon-wiki 위에서 패키징 에이전트를 돌릴 때 입력으로 쓴다.

---

## 1. naite가 무엇인가

naite는 LLM이 관리하는 개인 지식 시스템이다. 사용자가 자료를 넣고 질문하면, 에이전트(Claude Code 또는 Codex)가 자료를 읽고 사용자가 소유하는 Markdown 페이지를 쓰고 서로 연결한다. 구조와 규칙은 재사용 가능하다.

naite는 daehyeon-wiki(개인 위키, 1208 페이지)의 하네스를 콘텐츠 없이 추출해 제품화한 공개 패키지다. daehyeon-wiki README의 문장 "A public copy of my personal wiki. The contents are mine; the structure and conventions are reusable."를 정식 릴리스 프로세스로 승격한 것이다.

## 2. 철학

기록은 일반 백과사전이나 노트 모음이 아니라 사용자가 아는 것을 담는다. 그 앎은 두 갈래다.

- 사용자가 스스로 알아낸 것. 결정, 프로젝트, 통찰, 아직 풀지 못한 질문.
- 밖에서 배운 것. 강의 노트, 논문 요약, 아티클, 공식 문서.

두 갈래는 같은 그래프에 함께 있으며 서로 링크된다. 결정 페이지가 강의에서 배운 개념을 인용하고, 그 개념이 다른 페이지에서 다시 쓰인다. 두 레이어를 한 그래프에 두는 것이 핵심이며, 분리하면 둘 사이의 링크가 사라진다.

페이지를 쓰는 일은 LLM이 맡는다. 사용자는 자료를 고르고 질문하고 중요한 것을 짚으며, LLM은 같은 규칙으로 페이지를 작성하고 링크를 유지한다. 사용자가 페이지를 손으로 고치는 것을 전제하지 않는다. 위키는 쌓일수록 더 쓸모 있어진다.

## 3. 이름과 브랜드

- 이름: naite. 나이테(나무가 해마다 안에서부터 더하는 성장 테)에서 왔다.
- 핵심 의미: 누가 물려주는 기록이 아니라 내가 직접 쌓아가는 기록. 1인칭 자기 축적.
- 표기: 소문자 `naite`.
- 계보: Karpathy의 LLM Wiki 패턴, second-brain 계열. 사실관계로만 적고 마케팅 표현은 쓰지 않는다.
- 라이선스: MIT.

## 4. 레포와 description

- 전용 공개 레포 이름: `naite-personal-memory`.
- GitHub About (영문):
  > naite is a personal knowledge system maintained by an LLM. You add sources and ask questions; an agent (Claude Code or Codex) reads them and writes connected Markdown pages you own. The conventions and structure are reusable.
- GitHub About (국문):
  > naite는 LLM이 관리하는 개인 지식 시스템입니다. 사용자가 자료를 넣고 질문하면, 에이전트(Claude Code 또는 Codex)가 자료를 읽고 사용자가 소유하는 Markdown 페이지를 쓰고 서로 연결합니다. 구조와 규칙은 재사용 가능합니다.

## 5. 나무 구조 모델

naite는 살아서 자라는 나무로 이해한다. 자료가 뿌리로 들어와, 줄기로 구조화되고, 잎에서 이해가 되고, 열매로 수확해 다음에 다시 쓰며, 그 과정이 나이테로 누적된다.

| 나무 | 의미 | 레이어/kind |
|---|---|---|
| 씨앗 seed | 앞으로 만들 페이지 후보 | `_stubs` |
| 뿌리 root | 자료 유입 | `raw/` + source-record/session |
| 줄기 trunk | 구조 | `index` |
| 잎 leaf | 이해가 일어나는 지식 페이지 | concept, source-record, insight |
| 열매 fruit | 다시 쓰는 결과물 | decision (+insight) |
| 나이테 rings | 시간 성장 기록 | `log` |
| (보너스) 꽃봉오리 | 아직 풀리지 않아 더 자랄 여지 | questions, review |

오버엔지니어링 경계:
- `entity` kind는 신설하지 않는다. 인물/대상은 잎(concept)에 흡수하고, 열매는 decision+insight로 둔다.
- 폴더명은 관습대로 둔다. `raw`를 roots로, `notes/wiki`를 leaves로 실제 디렉터리를 바꾸지 않는다.
- 나무 은유는 README와 온보딩의 서사 및 다이어그램으로만 쓰고, 구현은 단순하게 유지한다. naite 운영 원칙: 콘텐츠 압력이 생기기 전에는 복잡한 분류를 만들지 않는다, 스키마를 함부로 늘리지 않는다.

## 6. 패키징 방식 (daehyeon-wiki에서 에이전트로 추출)

방향은 daehyeon-wiki -> naite 한 방향. daehyeon-wiki가 진실의 원천이고, naite는 거기서 하네스만 추출·세니타이즈한 다운스트림 공개 패키지다. 콘텐츠는 항상 인스턴스 고유다.

불변 규칙:
1. 콘텐츠 복사 금지: 실제 wiki 페이지, raw 자료, log 히스토리.
2. 비밀/PII 유출 금지: secret scan 통과 전 커밋 금지.
3. 원본 비파괴: daehyeon-wiki는 읽기만, 출력은 별도 경로.
4. 역방향 쓰기 금지.

추출 화이트리스트 (하네스만, 있는 그대로):
- `CLAUDE.md`, `AGENTS.md`, `CONTEXT.md`, `CONVENTIONS.md`, `ARCHITECTURE.md`
- `.claude/skills/wiki/*`, `.agents/skills/wiki/*`
- `scripts/` 중 범용만 (sync, lint). 일회성 마이그레이션 제외.
- `docs/` 중 설계 rationale만 (개인 런로그·식별 정보 제외)
- `.gitignore`, `.gitattributes`, `LICENSE`(MIT), naite용 새 `README.md`

seed로 비워서 넣을 것:
- `wiki/index.md`(stub), `wiki/log.md`(헤더만), `wiki/_stubs.md`(빈)
- `raw/*/.gitkeep`
- `ontology/subject-tree.md`·`topics.md`: 구조·설명 유지, 실제 도메인 vocab은 중립 예시로 치환
- `ontology/*.json`: 빈 seed에서 재생성

절대 제외 (블랙리스트):
- 실제 wiki 페이지 전부(특수파일 제외), raw 실파일 전부, `_transcripts/`, `_archive/`, `.git/hooks/`, `gotchas.md`, `tmp/`, `exports/`, `deliverables/`, 개인 vocab 실값

세니타이즈 패스 (순서대로):
1. Secret scan (lint secrets 규칙) 전 추출물. 히트 시 중단.
2. 개인정보 일반화: 이름·고용주·개인 도메인·식별자를 중립 표현으로.
3. 경로 누출 검사: 추출물에 raw 실경로·개인 슬러그 참조 0.
4. 링크 무결성: seed가 없는 페이지를 가리키지 않게.
5. 미러 일관성: sync-agents 재실행해 `.agents == .claude`.

브랜딩 치환:
- `daehyeon-wiki` -> `naite`, 1인칭 개인 서술 -> 범용 2인칭/중립.
- 명령 surface는 v1에서 원본과 동일하게 유지(`/wiki`). 그래야 daehyeon-wiki에서 재설치 없이 그대로 돈다. `/naite`로 바꾸려면 원본도 같이 바꿔야 하므로 v1은 유지.

출력·검증·커밋:
- 출력 경로에서 lint 풀패스 + content_page_count == 0 확인.
- naite 전용 레포에 단일 시드 커밋으로 push. semver 태그 v0.0.0.

릴리스 프로세스로 승격:
- 이 런북을 daehyeon-wiki의 워크플로 스킬로 박는다: `.claude/skills/wiki/package.md` + `/wiki package`. 하네스가 진화하면 `/wiki package`로 재추출해 naite 새 릴리스를 만든다.

## 7. 메모

- 컨벤션 피벗은 (A) daehyeon-wiki 하네스 기준으로 확정. `/wiki`, `wiki/`, 5-facet rich schema를 그대로 쓴다.
- 기존 sillok 계열 키트(`/record`, `notes/`, 단순 schema)는 공개 시드로는 폐기. 단 거기서 만든 README(철학·나무 모델·이중표면 설명)와 LICENSE는 추출본에 재사용한다.
- 기존 `daehyeonxyz/sillok` 레포는 삭제 또는 비공개로 둔다. 과거 히스토리에 전략 문서가 남아 있다.
