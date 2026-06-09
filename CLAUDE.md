# CLAUDE.md - Sillok Bootloader for Claude Code

You are maintaining a Sillok learning context.

Sillok turns study experience into durable Markdown learning context. The user studies with books, lectures, notes, PDFs, and AI conversations; you keep the learning context coherent.

This file is the Claude Code entrypoint. It carries routing, triggers, and hard safety rules. Context-loading rules live in `CONTEXT.md`. Detailed operating rules live in `CONVENTIONS.md`. Workflow bodies live in `.claude/skills/record/`.

## Layers

- `raw/` - source material. Users can drop PDFs, notes, transcripts, and rough files into `raw/inbox/`.
- `notes/` - agent-maintained Markdown learning context. Flat by default. Special files: `index.md`, `log.md`, `_stubs.md`, `review.md`, `questions.md`.
- `ontology/` - tiny schema, optional vocabularies, and generated routing maps for agents.
- `docs/` - philosophy and workflow docs.
- `CONTEXT.md` - context-routing contract for agents.
- `.claude/skills/record/` - canonical Claude Code workflow bodies.
- `.agents/skills/record/` - Codex mirror generated from the Claude surface.

## Workflow Router

Beginner-facing workflows:

| User intent | Workflow | Body |
|---|---|---|
| First-run guidance or "how do I start?" | `/record help` | `.claude/skills/record/help.md` |
| A single study event, including an AI conversation | `/record study` | `.claude/skills/record/study.md` |
| A course, book, lecture series, or multi-chapter learning track | `/record course` | `.claude/skills/record/course.md` |
| Backfill a completed or partly completed course gradually | `/record course backfill <slug> --plan` | `.claude/skills/record/course-backfill.md` |
| A question against the accumulated notes | `/record query` | `.claude/skills/record/query.md` |

Maintenance workflows:

| User intent | Workflow | Body |
|---|---|---|
| Deterministic health check: schema, links, output guard, secrets | `/record lint` | `.claude/skills/record/lint.md` |
| Qualitative review, repair, or recurring-rule learning | `/record curate` | `.claude/skills/record/curate.md` |

Do not expose `capture` as a separate beginner workflow. AI conversations are study material and are handled by `/record study`.

## Before Any Notes Mutation

Read `CONTEXT.md`, `CONVENTIONS.md`, and the relevant workflow file. Use `ontology/page-manifest.json` before searching for target pages, and use `ontology/page-dependencies.json` before changing existing pages with possible semantic dependents.

Make the smallest coherent notes update. Do not invent new schema fields unless the user explicitly asks.

## Surface Mirror Discipline

This project keeps two markdown surfaces in sync: `.claude/` + `CLAUDE.md` for Claude Code, and `.agents/` + `AGENTS.md` for Codex.

- **Canonical edit target**: `.claude/` and `CLAUDE.md`. Regenerate the Codex mirror with `scripts/sync-agents.ps1` when the canonical side changes.
- **Mirror review**: after sync, review `AGENTS.md` and `.agents/skills/record/` for tool-specific wording before staging.
- **Run sync in the same commit** that edits the canonical side. Both surfaces stage together.
- **Shared (NOT mirrored)**: `CONTEXT.md`, `CONVENTIONS.md`, `docs/`, `ontology/`, `raw/`, and `notes/`.

## Operating Principle

The `notes/` layer is not a generic encyclopedia. It represents what the learner has studied, understood, questioned, misunderstood, decided, and needs to review.

Prefer source-grounded pages, learner-specific questions, compact review prompts, plain Obsidian links, and small updates that compound over time.

Avoid dumping full chat transcripts into `notes/`, creating a complex taxonomy before there is content pressure, or turning every source into too many pages.

## Safety

Never write API keys, passwords, private identifiers, or confidential material into `notes/`. If a source contains sensitive content, ask before ingesting it or keep it under `raw/private/`.
