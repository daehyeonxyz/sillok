# Sillok

**내 경험을 지식으로 남기는 인공지능.**

Sillok is an open-source agent harness for turning real study, project, conversation, and decision traces into durable Markdown knowledge that can be reused in the next context.

> 경험은 지나가도, 지식은 남아야 합니다.

## Why Sillok

요즘 우리는 이미 인공지능 위에서 공부하고 일합니다.

강의자료는 `NotebookLM`에 넣고, 과목별로 `ChatGPT Projects`나 `Claude Projects`를 만들고, 프로젝트를 하면서는 `Codex`, `Claude Code`, `Cursor` 같은 도구와 계속 대화합니다. 이 방식은 실제로 좋습니다. 공부하는 순간, 만드는 순간에는 더 깊게 질문하고 더 높은 수준의 결과물을 만들 수 있습니다.

문제는 그 경험이 끝난 뒤입니다.

채팅 기록은 남아 있고, 발표자료도 저장되어 있고, 코드는 GitHub에 있고, 필기도 노트 앱에 있습니다. 겉으로 보면 전부 저장되어 있습니다. 하지만 나중에 다시 쓰려고 하면 무엇이 어디에 있는지 모르고, 알아도 다음 질문과 다음 프로젝트의 맥락으로 바로 이어지지 않습니다.

Sillok이 다루는 문제는 "기록이 없다"가 아닙니다.

**저장되어 있다는 것과 쌓였다는 것은 다릅니다.**

Sillok은 강의자료, 필기, 인공지능 대화, 프로젝트 기록, 결정, 시행착오를 다음에 다시 쓸 수 있는 Markdown 기록으로 정리하고, 그 기록 사이의 연결을 만들어줍니다.

## What Sillok Is

Sillok은 새로운 채팅 앱이 아닙니다.

Sillok은 `Obsidian`, `Codex`, `Claude Code`, `Git` 같은 이미 쓰는 도구 위에서 동작하는 기록 운영 하네스입니다. 사용자의 로컬 Markdown 기록을 인공지능이 읽고, 정리하고, 연결하고, 다시 질문에 활용할 수 있도록 돕습니다.

Sillok의 목표는 예쁜 노트를 만드는 것이 아닙니다.

목표는 다음에 다시 쓸 수 있는 맥락을 남기는 것입니다. 예전에 무엇을 이해했는지, 어디서 막혔는지, 어떤 결정을 했는지, 어떤 피드백을 받고 고쳤는지가 연결되어 있으면 다음 학습과 다음 프로젝트의 출발점이 달라집니다.

## Quick Start

Claude Code, Codex, Cursor 같은 로컬 파일을 읽고 쓸 수 있는 인공지능 도구에서 이 저장소를 열고 이렇게 말하면 됩니다.

```text
/record help
```

`/record help`는 처음부터 분류체계나 폴더 구조를 설명하지 않습니다. 먼저 지금 가진 자료가 무엇인지 묻고, 가장 작은 시작점을 안내합니다.

```text
지금 가진 자료가 어떤 쪽에 가까운가요?

1. 강의자료 PDF가 있어요.
2. 예전에 AI와 공부했던 대화가 있어요.
3. 필기나 시험 정리 노트가 있어요.
4. 과목 전체를 천천히 옮기고 싶어요.
5. 이미 쌓인 기록에 질문하고 싶어요.
```

처음부터 모든 경험을 정리할 필요는 없습니다. 강의자료 하나, 대화 하나, 프로젝트 회고 하나만 있어도 시작할 수 있습니다.

## Core Workflow

```text
자료 넣기 -> 기록으로 정리하기 -> 질문과 복습 지점 남기기 -> 연결 만들기 -> 다음 경험에서 다시 쓰기
```

예를 들어 2학년 때 선형대수와 통계를 공부했고, 3학년 때 머신러닝을 공부한다고 해보겠습니다.

일반적인 인공지능에게 물어보면 선수지식을 넓게 다시 설명합니다. 그 설명은 틀리지 않지만, 내가 이미 아는 내용과 아직 헷갈리는 내용은 구분하지 못합니다.

Sillok은 내가 실제로 배운 기록을 바탕으로 이미 아는 것은 짧게 연결하고, 다시 볼 지점은 자세히 짚고, 다음에 참고할 기록을 함께 제시하는 것을 목표로 합니다.

## Commands

처음에는 아래 명령만 알면 됩니다.

```text
/record help
/record study
/record course
/record query
```

| Command | When to use |
|---|---|
| `/record help` | 처음 시작할 때, 어떤 자료부터 넣을지 모르겠을 때 사용합니다. |
| `/record study` | 한 번의 공부, 대화, 회고, 자료 묶음을 기록으로 정리할 때 사용합니다. |
| `/record course` | 과목, 챕터, 강의 시리즈처럼 이어지는 학습을 관리할 때 사용합니다. |
| `/record query` | 이미 쌓인 기록을 바탕으로 질문할 때 사용합니다. |

과목 전체를 천천히 옮기고 싶다면 먼저 계획부터 세웁니다.

```text
/record course backfill <course-slug> --plan
```

예시:

```text
/record course backfill machine-learning --plan
```

## Import Existing AI Sessions

예전에 `ChatGPT`, `Claude`, `Gemini`, `NotebookLM`에서 공부하거나 작업한 대화도 버릴 필요가 없습니다.

[docs/session-extractor.md](docs/session-extractor.md)의 프롬프트를 기존 대화창에 붙여넣으면, 그 세션에서 실제로 배운 내용, 남은 질문, 결정, 다시 볼 자료를 추출할 수 있습니다.

추출한 결과는 `raw/inbox/`에 넣고 `/record study`나 `/record ingest`로 기록에 반영합니다.

## Repository Structure

```text
sillok/
  README.md              # 시작 문서
  CLAUDE.md              # Claude Code bootloader
  AGENTS.md              # Codex bootloader
  CONTEXT.md             # context loading rules
  CONVENTIONS.md         # record conventions

  raw/
    inbox/               # 아직 정리하지 않은 원본 자료
    archive/             # 처리한 원본 자료

  notes/
    index.md             # 기록의 첫 화면
    questions.md         # 남은 질문
    review.md            # 다시 볼 것
    _stubs.md            # 나중에 만들 기록 후보
    log.md               # 변경 기록

  docs/
    record-help.md       # 처음 시작 안내
    session-extractor.md # AI 대화에서 기록 재료 추출
    course-transfer.md   # 과목을 천천히 옮기는 방법
    workflows.md         # 주요 workflow
    philosophy.md        # 프로젝트 철학
    obsidian-setup.md    # Obsidian으로 여는 방법

  ontology/
    schema.md
    subjects.md
    topics.md

  .claude/skills/record/ # Claude Code workflow
  .agents/skills/record/ # Codex workflow mirror
  scripts/               # map build and mirror sync scripts
  examples/              # first study session example
```

## Positioning

Sillok은 `NotebookLM` 대체품이 아닙니다.

Sillok은 `ChatGPT`나 `Claude`보다 더 똑똑한 답변 도구가 되려는 프로젝트도 아닙니다.

Sillok은 `Obsidian`을 직접 잘 쓰는 사람만을 위한 템플릿도 아닙니다.

Sillok은 기존 도구를 쓴 결과를 내가 소유하는 기록으로 다시 가져오고, 그 기록을 다음 질문과 다음 선택에 재사용하게 만드는 하네스입니다.

## Documentation

- [docs/record-help.md](docs/record-help.md): 처음 시작하기
- [docs/session-extractor.md](docs/session-extractor.md): AI 대화에서 기록 재료 추출하기
- [docs/course-transfer.md](docs/course-transfer.md): 과목을 천천히 옮기기
- [docs/workflows.md](docs/workflows.md): workflow 개요
- [docs/philosophy.md](docs/philosophy.md): 프로젝트 철학
- [docs/obsidian-setup.md](docs/obsidian-setup.md): Obsidian 설정

## Status

Sillok은 공개 오픈소스 wiki 키트입니다. 사용자가 직접 저장소를 받아 설치하고, 자기 자료를 넣고, 첫 기록을 만들어 다음 학습과 다음 작업에 다시 쓰는 것을 목표로 합니다.
