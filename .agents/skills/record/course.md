# /record course

Use this when learning has a lifecycle: a course, book, lecture series, textbook, certification path, or multi-chapter study track.

## Goal

Maintain the long-running structure while individual learning still flows through `/record study`.

## Context Loading

1. Read `CONTEXT.md`.
2. Read `CONVENTIONS.md`.
3. Read this workflow file.
4. Read `ontology/page-manifest.json` before searching for course or concept pages.
5. Read `notes/index.md` and recent `notes/log.md`.
6. Read `ontology/page-dependencies.json` before changing an existing course page or linked concept page.

## Common Intents

- start a course
- backfill a course already studied
- add a syllabus or table of contents
- finish a chapter
- move to the next unit
- summarize progress
- close or archive a course

## Steps

1. Determine the lifecycle action:
   - `start`
   - `backfill`
   - `chapter` or `unit`
   - `progress`
   - `finish`
2. If the action is `backfill`, load `<SKILL_DIR>/course-backfill.md` and follow that workflow. Prefer `--plan` before any heavy processing.
3. Maintain one course page:
   - title
   - purpose
   - source material
   - chapters or units
   - current status
   - important concept links
   - open questions
4. For a chapter or unit, use `/record study` behavior to internalize the actual learning.
5. Use the Reader / Writer / Verifier split from `CONTEXT.md` for syllabus files, lecture bundles, long transcripts, PDFs, or multi-file chapters.
6. Update `notes/index.md` only if this is a new course or major course page.
7. Run the content guard from `CONVENTIONS.md` on touched page bodies before any trailing `## Source`.
8. Regenerate `ontology/page-manifest.json` if page coordinates changed.
9. Regenerate `ontology/page-dependencies.json` if Obsidian links or body relations changed.
10. Append one line to `notes/log.md`.

## Reader / Writer / Verifier

Reader extracts the course source structure and chapter-level learning material without writing notes pages.

Writer receives the Reader chunk, the course page context, `CONVENTIONS.md`, this workflow, and generated maps. Writer updates the course page and uses study-like behavior for chapter knowledge.

Verifier checks the course page, new or changed concept pages, queue pages, generated maps, and the log entry. Verifier surfaces inbound dependent pages from `ontology/page-dependencies.json` when existing pages changed.

## Course Page Shape

```md
---
kind: course
form: prose
topics: []
subject: []
source-types: [lecture]
domains: []
created: YYYY-MM-DD
updated: YYYY-MM-DD
---

# Course Name

## Purpose

## Source Material

## Chapters

## Current Questions

## Review

## Related
```

## Keep It Simple

Do not create a deep folder hierarchy for a course.

Prefer:

- one course page
- concept pages as they become reusable
- `questions.md` and `review.md` for cross-course continuity

## Backfill Principle

Backfill is for material the learner has already studied. It should lower the starting burden, not demand a perfect archive.

Baseline input can be only the full lecture PDFs. Personal notes, exam summaries, and extracted AI conversations are optional boosters.

When the course is large, do not process everything at once. Start with `/record course backfill <slug> --plan`, split by week, chapter, exam range, or source bundle, and confirm the first small batch with the learner.
