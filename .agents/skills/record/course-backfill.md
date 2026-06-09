# /record course backfill

Use this when the learner wants to bring an already-studied course, book, lecture series, or exam range into the notes.

Backfill exists to lower the starting burden. The learner should be able to begin with only lecture PDFs. Notes, exam summaries, and extracted AI conversations improve the result but are not required.

## Invocation

Preferred first command:

```text
/record course backfill <course-slug> --plan
```

Supported lightweight source hints:

```text
/record course backfill <course-slug> --pdf
/record course backfill <course-slug> --note
/record course backfill <course-slug> --conversation
```

If the learner gives a course name instead of a slug, propose a lowercase kebab-case slug and ask for confirmation.

## Context Loading

1. Read `CONTEXT.md`.
2. Read `CONVENTIONS.md`.
3. Read `.agents/skills/record/course.md`.
4. Read this workflow file.
5. Read `ontology/page-manifest.json`, `notes/index.md`, `notes/questions.md`, and `notes/review.md` only after the learner confirms the course slug or route.

## Modes

### `--plan`

Plan first. Do not ingest a whole course in one pass.

Steps:

1. Identify the course slug and course title.
2. Inspect the learner-provided source list or `raw/inbox/` if the learner asks you to.
3. Classify available material:
   - lecture PDFs
   - notes or exam summaries
   - extracted AI conversations
   - links or pasted text
4. Propose a backfill sequence:
   - week by week
   - chapter by chapter
   - exam range by exam range
   - source bundle by source bundle
5. Keep the first batch small enough for one reliable study pass.
6. Ask which batch to start with.

Output shape:

```md
# Backfill Plan: <course title>

## 시작 기준
- baseline source:
- optional boosters:

## 추천 순서
1. ...
2. ...
3. ...

## 첫 작업
- suggested command:
- expected notes updates:

## 주의할 점
- token/load considerations:
- missing materials:
```

### `--pdf`

Use when the learner already knows the PDF or bundle to start with.

Steps:

1. Confirm whether this is a single study event or part of a course backfill.
2. If it is part of a course, ensure a backfill plan exists or create a short one inline.
3. Process only the selected PDF or small bundle.
4. Use `/record study --pdf` behavior for the actual internalization.

### `--note`

Use when the learner has notes, exam summaries, or copied study material.

Steps:

1. Treat notes as personal context boosters.
2. Pair them with lecture material when available.
3. Use `/record study --note` behavior for a small note.
4. For many notes, return to `--plan`.

### `--conversation`

Use when the learner has an extracted AI study session.

Steps:

1. If the conversation has not been extracted yet, direct the learner to `docs/session-extractor.md`.
2. Treat the extracted conversation as a personal context booster.
3. Use `/record study --conversation` behavior.
4. Preserve what changes future study: understood content, remaining review points, useful explanations, and follow-up questions.

## Backfill Quality

A good backfill plan should answer:

- What is enough to get the notes started?
- Which material is required and which material is optional?
- What should be processed first?
- What can wait?
- How can the learner avoid spending a whole day trying to import everything?

## What This Command Never Does

- It never demands complete historical material before starting.
- It never processes an entire course silently.
- It never turns course backfill into a generic file conversion job.
- It never creates deep folder hierarchies for each course.
- It never commits to git.
