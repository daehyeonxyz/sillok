# /record query

Use this when the learner asks what the notes already knows.

## Goal

Answer from the accumulated learning context, not from generic model memory alone.

## Context Loading

1. Read `CONTEXT.md`.
2. Read this workflow file.
3. Read `ontology/page-manifest.json` as the fast path for candidate pages.
4. Read `ontology/page-dependencies.json` when the question asks about connections, prerequisites, or what depends on a page.
5. Read `notes/questions.md`, `notes/review.md`, and `notes/_stubs.md` when the question asks what is missing or what to study next.
6. Read `notes/log.md` for timeline questions.

## Steps

1. Start with `ontology/page-manifest.json`, not a blind scan.
2. Select likely pages by title, slug, `kind`, `topics`, `subject`, `source-types`, and `domains`.
3. Read only the relevant notes pages, then expand through useful Obsidian links if needed.
4. Answer with Obsidian links to the pages used.
5. Say what the notes already contains, what is missing, and which pages to review.
6. If the answer reveals a durable new insight, ask before saving it.

## Query Style

Good answers should say:

- what the notes already contains
- what is missing or still unclear
- which pages to review
- how the new question connects to prior study

Do not mutate `notes/` by default.
