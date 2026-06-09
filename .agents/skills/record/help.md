# /record help

Use this when the learner asks how to start, says "내 notes 만들어줘", just cloned the repo, or does not know which workflow to use.

## Goal

Give a friendly Korean first-run guide and route the learner to the smallest useful next action.

`/record help` is not a schema lecture and not a command catalog. It should make the learner feel they can start with imperfect material.

## Tone

- Write in Korean by default.
- Be warm, calm, and concrete.
- Avoid jargon such as ontology, schema, manifest, frontmatter, graph, and agent harness unless the learner asks about internals.
- Do not overuse English words. Folder names and commands can remain as literal names.
- Emphasize that one lecture PDF is enough to begin.

## Context Loading

Read only this workflow first.

Do not read the whole notes unless the learner chooses a routed workflow. Do not mutate `notes/` from help alone.

If the learner chooses a route that needs a workflow, then load the matching workflow:

- PDF, note, or pasted material -> `/record study`
- full course migration -> `/record course backfill <slug> --plan`
- existing notes question -> `/record query`
- prior AI conversation -> read `docs/session-extractor.md`, then route to `/record study --conversation`

## First Response Shape

Explain the system in this order:

1. Reassure the learner that the notes do not need to be perfect from the start.
2. Explain that this is a learning record space where lecture material, notes, AI conversations, questions, and review points become reusable context for later study.
3. Explain the simple folder model:
   - `raw/` is where unorganized material goes.
   - `notes/` is where organized learning records accumulate.
   - `docs/` is where usage guides live.
4. Explain the learning loop:
   - put material in
   - internalize it into the notes
   - ask the notes later
   - leave review points and questions
   - use those records in the next study session
5. Ask the learner to choose one of five routes:

```text
지금 가지고 있는 자료가 어떤 쪽에 가까운가요?

1. 강의자료 PDF가 있어요.
2. 예전에 AI와 공부했던 대화가 있어요.
3. 필기나 시험 정리 노트가 있어요.
4. 과목 전체를 천천히 옮기고 싶어요.
5. 이미 쌓인 기록에 질문하고 싶어요.
```

## Route Responses

### 1. 강의자료 PDF가 있어요

Tell the learner:

- Put the PDF under `raw/inbox/`.
- If it is one lecture, chapter, or small bundle, use `/record study --pdf`.
- If it belongs to a whole course, use `/record course backfill <course-slug> --plan` first.
- The first goal is not a perfect course notes. The first goal is enough context for the next question to improve.

If the learner gives a course name, propose a lowercase kebab-case slug and ask for confirmation.

Example:

```text
과목 이름이 "머신러닝"이라면 추천 이름은 `machine-learning`입니다.
이 이름으로 과목 정리 계획을 만들어볼까요?
```

### 2. 예전에 AI와 공부했던 대화가 있어요

Tell the learner:

- Open the old ChatGPT, Codex, Gemini, or other AI conversation.
- Paste the prompt from `docs/session-extractor.md` into that conversation.
- Copy the result into a new file under `raw/inbox/`, or paste it back into this session.
- Then use `/record study --conversation`.

If helpful, include the extractor prompt from `docs/session-extractor.md` directly in the reply.

### 3. 필기나 시험 정리 노트가 있어요

Tell the learner:

- Put the note under `raw/inbox/`.
- PDF, markdown, text, copied notes, and exam summaries are all acceptable.
- If there is also lecture material, mention both together so the notes can connect the official content with the learner's own understanding.
- Use `/record study --note` for one note or `/record course backfill <course-slug> --plan` for a course bundle.

### 4. 과목 전체를 천천히 옮기고 싶어요

Tell the learner:

- Do not try to move the whole course at once.
- Collect the available materials first: lecture PDFs, notes, exam summaries, and extracted AI conversations.
- Use `/record course backfill <course-slug> --plan`.
- The plan should split work by week, chapter, exam range, or source bundle and consider token usage.

If the learner gives only a Korean course name, suggest a slug and confirm it.

### 5. 이미 쌓인 기록에 질문하고 싶어요

Tell the learner:

- Use `/record query <question>`.
- Good questions can ask what they already studied, what to review, what a new topic connects to, or what remains unclear.
- Query is read-only by default. If a new insight should be saved, ask before mutating the notes.

## Slug Guidance

Course slugs use lowercase kebab-case.

Examples:

- `선형대수학` -> `linear-algebra`
- `응용통계학` -> `applied-statistics`
- `머신러닝` -> `machine-learning`

If a translation is obvious, propose it. If it is not obvious, propose a simple romanized or descriptive slug and ask for confirmation.

## What This Command Never Does

- It does not create or edit notes pages by itself.
- It does not ask for the learner's whole profile up front.
- It does not require Obsidian setup before explaining the next step.
- It does not make the learner understand internal schema before first use.
