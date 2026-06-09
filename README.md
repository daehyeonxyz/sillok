# naite

LLM이 관리하는 개인 지식 시스템입니다. 사용자가 자료를 넣고 질문하면, 에이전트(`Claude Code` 또는 `Codex`)가 자료를 읽고 사용자가 소유하는 Markdown 페이지를 쓰고 서로 연결합니다.

> naite is a personal knowledge system maintained by an LLM. You add sources and ask questions; an agent (Claude Code or Codex) reads them and writes connected Markdown pages you own. The conventions and structure are reusable.

## 개요

naite의 기록은 일반 백과사전이나 노트 모음이 아니라 사용자가 아는 것을 담습니다. 그 앎은 두 갈래입니다.

- 사용자가 스스로 알아낸 것. 내린 결정, 진행한 프로젝트, 정리된 통찰, 아직 풀지 못한 질문.
- 밖에서 배운 것. 강의 노트, 논문 요약, 아티클, 공식 문서.

두 갈래는 같은 그래프에 함께 있으면서 서로 링크됩니다. 결정 페이지가 강의에서 배운 개념을 인용하고, 그 개념이 다른 페이지에서 다시 쓰입니다. 두 레이어를 한 그래프에 두는 것이 핵심이며, 분리하면 둘 사이의 링크가 사라집니다.

페이지를 쓰는 일은 LLM이 맡습니다. 사용자는 자료를 고르고 질문하고 중요한 것을 짚으며, LLM은 같은 규칙으로 페이지를 작성하고 링크를 유지합니다. 사용자가 페이지를 직접 손으로 고치는 것을 전제하지 않습니다.

## 동작 방식

1. `raw/inbox/`에 자료를 넣습니다. PDF, 대화 기록, 강의 노트 등.
2. 에이전트 CLI에서 `/record` 슬래시 명령을 입력합니다.
3. 에이전트가 `CONTEXT.md`, `CONVENTIONS.md`, 해당 워크플로 파일을 읽습니다.
4. 에이전트가 `notes/`에 페이지를 작성하거나 갱신하고, 중요한 편집은 사용자 확인을 거칩니다.
5. 에이전트가 `notes/log.md`에 한 줄을 덧붙입니다.
6. 주기적으로 `/record lint`로 기계적 점검을, `/record curate`로 질적 점검을 실행합니다.

슬래시 명령은 워크플로 명세 파일(스킬 파일)을 실행시킵니다. 에이전트는 워크플로를 즉흥적으로 만들지 않고 스킬 파일을 계약으로 따릅니다.

## 요구 사항

- 에이전트 CLI. `Claude Code` 또는 `Codex` 중 하나. 두 표면이 같은 기록을 다룹니다.
- `git`.
- (선택) `Obsidian`. 그래프 뷰와 전문 검색으로 기록을 읽을 때 사용합니다. 설정은 [docs/obsidian-setup.md](docs/obsidian-setup.md).
- (선택) `Python 3`. `ontology/`의 라우팅 맵을 재생성할 때 사용합니다.
- (선택) `PowerShell`. Codex 미러를 재생성하는 `scripts/sync-agents.ps1`를 실행할 때 사용합니다.

## 시작하기

1. 이 저장소를 클론하거나 템플릿으로 복제합니다.
2. `Claude Code` 또는 `Codex`에서 저장소 루트를 엽니다.
3. 다음을 입력합니다.

```text
/record help
```

`/record help`는 분류체계부터 설명하지 않습니다. 먼저 지금 가진 자료가 무엇인지 묻고 가장 작은 시작점을 안내합니다. 자료 하나만 있어도 시작할 수 있습니다.

## 명령어

| Command | When to use |
|---|---|
| `/record help` | 처음 시작할 때, 어떤 자료부터 넣을지 정할 때. |
| `/record study` | 한 번의 공부, 대화, 회고, 자료 묶음을 기록으로 정리할 때. |
| `/record course` | 과목, 챕터, 강의 시리즈처럼 이어지는 학습을 관리할 때. |
| `/record query` | 이미 쌓인 기록을 바탕으로 질문할 때. |
| `/record lint` | 스키마, 링크, 출력 가드, 비밀정보를 기계적으로 점검할 때. |
| `/record curate` | 기록을 질적으로 리뷰하거나 수리하고 반복 규칙을 학습시킬 때. |

이미 완료했거나 진행 중인 과목 전체를 점진적으로 옮길 때는 먼저 계획을 세웁니다.

```text
/record course backfill <course-slug> --plan
```

예전에 `ChatGPT`, `Claude`, `Gemini`, `NotebookLM`에서 나눈 대화는 [docs/session-extractor.md](docs/session-extractor.md)의 프롬프트로 학습 내용, 남은 질문, 결정, 다시 볼 자료를 추출한 뒤 `raw/inbox/`에 넣고 `/record study`로 반영합니다.

## 저장소 구조

```text
naite/
  README.md
  CLAUDE.md              # Claude Code 진입점 (bootloader)
  AGENTS.md              # Codex 진입점 (생성된 미러)
  CONTEXT.md             # 컨텍스트 로딩 규칙
  CONVENTIONS.md         # 기록 규칙
  LICENSE

  raw/
    inbox/               # 아직 정리하지 않은 원본 자료
    archive/             # 처리한 원본 자료

  notes/
    index.md             # 기록의 진입점
    questions.md         # 남은 질문
    review.md            # 다시 볼 것
    _stubs.md            # 앞으로 만들 페이지 후보
    log.md               # 추가 전용 변경 기록

  docs/                  # 안내와 설계 문서
  ontology/              # 스키마, 어휘, 생성된 라우팅 맵

  .claude/skills/record/ # Claude Code 워크플로 (정본)
  .agents/skills/record/ # Codex 워크플로 (미러)
  scripts/               # 맵 생성과 미러 동기화 스크립트
  examples/              # 첫 study 세션 예시
```

## 데이터 모델

모든 페이지는 동일한 frontmatter 형태로 시작합니다. 운영 규칙은 [CONVENTIONS.md](CONVENTIONS.md), 전체 스키마는 [ontology/schema.md](ontology/schema.md)에 있습니다.

```yaml
---
kind: concept          # 페이지의 본질
form: prose            # 본문의 형태
topics: []             # 재사용 키워드 0-5개
subject: []            # 주제 경로
source-types: []       # 출처 종류
domains: []            # subject에서 파생된 캐시
created: 2026-06-09
updated: 2026-06-09
---
```

- `kind`: `concept`, `source-record`, `session`, `course`, `question`, `decision`, `insight`, `index`.
- `form`: `prose`, `index`.
- 페이지 사이의 관계는 frontmatter가 아니라 본문에 평문으로 적습니다. 예: `builds on [[x]]`, `decided [[x]] over [[y]]`.
- `notes/`는 하위 폴더 없이 평평합니다. 파일명은 `lowercase-kebab-case.md`, 한 파일에 한 개념입니다.
- `ontology/page-manifest.json`과 `ontology/page-dependencies.json`은 생성물입니다. 손으로 고치지 않고 `scripts/`로 재생성합니다.

이 구조는 나무에 빗대 이해할 수 있습니다.

```text
씨앗   _stubs              앞으로 채울 페이지 후보
뿌리   raw/                자료가 들어오는 곳
줄기   notes/index.md      기록의 구조
잎     concept, source-record, insight   지식 페이지
열매   decision            다시 쓰는 결과물
나이테 notes/log.md        시간에 따라 쌓이는 변경 기록
```

## 두 표면

naite는 두 CLI 위에서 같은 기록을 다룹니다.

- `Claude Code`는 `.claude/skills/record/`와 `CLAUDE.md`를 읽습니다.
- `Codex`는 `.agents/skills/record/`와 `AGENTS.md`를 읽습니다.

`.claude/`와 `CLAUDE.md`가 정본이고, Codex 쪽은 `scripts/sync-agents.ps1`로 생성되는 미러입니다. `CONTEXT.md`, `CONVENTIONS.md`, `docs/`, `ontology/`는 미러링하지 않고 두 도구가 함께 읽습니다.

## 문서

- [docs/record-help.md](docs/record-help.md): 처음 시작하기
- [docs/workflows.md](docs/workflows.md): 워크플로 개요
- [docs/philosophy.md](docs/philosophy.md): 설계 철학
- [docs/session-extractor.md](docs/session-extractor.md): AI 대화에서 기록 재료 추출
- [docs/course-transfer.md](docs/course-transfer.md): 과목을 점진적으로 옮기기
- [docs/obsidian-setup.md](docs/obsidian-setup.md): Obsidian 설정

## 기여

이슈와 풀 리퀘스트를 환영합니다.

- 워크플로와 진입점을 고칠 때는 `.claude/`와 `CLAUDE.md`를 정본으로 수정한 뒤, 같은 커밋에서 `scripts/sync-agents.ps1`로 `.agents/`와 `AGENTS.md` 미러를 재생성합니다.
- `CONTEXT.md`, `CONVENTIONS.md`, `docs/`, `ontology/`는 공유 파일이라 미러링하지 않습니다.
- 변경 후 `/record lint`를 실행해 스키마와 링크를 점검합니다.
- 스키마 필드는 명시적 합의 없이 늘리지 않습니다.

## 라이선스

[MIT](LICENSE).
