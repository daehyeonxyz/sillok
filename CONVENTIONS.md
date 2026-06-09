# CONVENTIONS.md - naite Operating Rules

These rules apply whenever an agent changes `notes/`.

naite should stay simple enough for a new learner to use, while still preserving enough structure for LLM agents to maintain the notes over time.

This file is shared by both tool surfaces. Keep it tool-neutral: workflow rules live here, while tool-specific paths and entrypoint wording live in `CLAUDE.md`, `AGENTS.md`, and the mirrored workflow skill directories.

## User Mental Model

The user only needs three ideas:

- Put study material in `raw/`.
- Let the agent internalize study through `/record study` or `/record course`.
- Ask the accumulated notes through `/record query`.

Do not make the user think about ontology first.

## Maintenance Model

naite has two maintenance tracks:

- `/record lint` is deterministic guardrail work: schema shape, broken links, output-quality regex checks, secrets, binary creep, and other machine-checkable hygiene.
- `/record curate` is qualitative judgement and repair: page/course review, direct content cleanup, and recurring-rule learning that should strengthen producer contracts or lint checks.

Daily use is still `study / course / query`. Treat `lint / curate` as maintenance commands, not the beginner mental model.

`CONTEXT.md` defines context-loading order and generated map use. Keep it invisible to the learner during normal study, but use it before selecting evidence files.

## Directory Rules

- `raw/inbox/` holds unprocessed or current source material.
- `raw/archive/` holds processed source material.
- `raw/private/` is gitignored and may contain sensitive material.
- `notes/` is agent-maintained Markdown.
- `notes/_stubs.md` tracks useful pages that should exist later, without forcing premature page creation.
- `ontology/` is a small consistency layer for agents, not a burden for users.
- `ontology/page-manifest.json` and `ontology/page-dependencies.json` are generated agent maps. They are tracked, but never hand-edited.

## Naming

- Page files use lowercase kebab case: `process-scheduling.md`.
- Obsidian links use plain Obsidian links: `[[process-scheduling]]` or `[[process-scheduling|Process scheduling]]`.
- Prefer one durable concept, question, course, or source record per page.

## Minimal Frontmatter

Most notes pages should use this shape:

```yaml
---
kind: concept
form: prose
topics: []
subject: []
source-types: []
domains: []
created: 2026-05-19
updated: 2026-05-19
---
```

Allowed `kind` values:

- `concept` - reusable idea, method, theory, pattern, or term
- `source-record` - a studied source or session record
- `session` - a study session summary
- `course` - long-running course, book, or lecture track
- `question` - recurring or unresolved learner question
- `decision` - study/project decision with reasoning
- `insight` - learner-specific realization or connection
- `index` - navigation page

Allowed `form` values:

- `prose`
- `index`

Allowed `source-types` values:

- `lecture`
- `book`
- `paper`
- `article`
- `docs`
- `conversation`
- `note`
- `external`

`domains` is a cache derived from `subject`. If unsure, leave `subject` and `domains` empty rather than inventing a taxonomy.

## What Belongs In The Notes

The `notes/` layer is about the learner's accumulated study context, not a generic encyclopedia.

Good pages capture:

- what was studied
- what the learner understood
- what stayed confusing
- important examples or explanations
- repeated questions
- links to prior study
- things to review next

Avoid:

- raw transcript dumps
- full source copies
- overlong summaries that will never be reused
- broad generic textbook pages with no learner-specific value

## Output Quality Contract

This is a producer contract first and a lint/curate rule second. Page-writing workflows should prevent violations before maintenance sees them.

Required:

- The page body must carry the meaning directly. Raw files, PDFs, transcripts, screenshots, and staging artifacts are evidence used during writing; they are not the reader-facing object.
- Use the learner's working language by default. Technical terms, formulas, model names, quoted titles, and course-native headings may stay in their original language when they carry precision.
- Study notes, highlights, diagrams, and AI explanations should be absorbed into explanatory prose. Do not write as if the page is a processing report.
- Links should be load-bearing: prose should say why the linked page matters here.
- Raw paths and provenance belong in a trailing `## Source` block or a source-record page, not in the main explanatory body.

Forbidden in the body before `## Source`:

- raw/source-process voice: `raw/`, staging, source bundle, PDF page, page range, extraction, render, image-read, backfill, run-log
- Korean source voice: `필기에는`, `필기에서`, `강의 노트`, `노트에서는`, `원문에서는`, `자료에서는`, `이 페이지에서는`, `이 자료`
- generic production headings such as `Source Staging`, `Concept Extraction`, `Maps to`, `Overview`, `Related`, unless they are explicitly part of a page template and useful to the reader
- mojibake markers: `???`, `�`, `Ã`, `Â`

False positives are possible. Preserve legitimate technical English, formulas, commands, file paths inside `## Source`, and quoted titles.

## Relation Style

Use normal prose and Obsidian links. Do not create a typed relation system.

Preferred phrases:

- `builds on [[x]]`
- `contrasts with [[y]]`
- `example of [[z]]`
- `still unclear: [[question-page]]`
- `review before [[next-topic]]`
- `used in [[course-page]]`

## Core Pages

`notes/index.md` is the entrypoint. Keep it short.

`notes/log.md` is append-only. Record one line per meaningful notes operation.

`notes/_stubs.md` lists pages to create later.

`notes/review.md` lists things the learner should revisit.

`notes/questions.md` lists unresolved or recurring questions.

## Generated Maps

Regenerate `ontology/page-manifest.json` when a notes page is created, deleted, renamed, or has frontmatter, title, or alias changes.

Regenerate `ontology/page-dependencies.json` when Obsidian links or body relation phrases change.

Build commands:

```powershell
python scripts/build-page-manifest.py
python scripts/build-page-dependencies.py
```

Use the manifest before searching for target pages. Use the dependency map before changing existing pages with possible semantic dependents.

## Mutation Discipline

When running `/record study`:

- create or update only the pages needed for this study event
- prefer 1-3 durable concept/question/session updates
- update `notes/review.md` and `notes/questions.md` when useful
- run the content guard on touched pages before finishing
- append to `notes/log.md`

When running `/record course`:

- maintain a course page
- keep chapters or units visible from the course page
- use `/record study` behavior for individual study events inside the course

When running `/record query`:

- do not mutate by default
- cite relevant notes pages by link
- ask before saving a new insight or study note

When running `/record lint`:

- report deterministic findings only
- do not make large repairs unless the user asks
- secrets are blockers; stop and report

When running `/record curate`:

- use judgement: review, repair, sweep, or system learning depending on user intent
- preserve the beginner mental model
- strengthen producer contracts before adding complicated taxonomy or workflows

## Safety

Never write secrets, API keys, passwords, ID numbers, private addresses, or confidential third-party material into `notes/`.

If source material is sensitive, keep it in `raw/private/` and ask before summarizing it.
