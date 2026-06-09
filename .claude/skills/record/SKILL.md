---
name: record
description: Maintain a Sillok learning context with help, study, course, query, lint, and curate workflows.
---

# Sillok Skill

The user invokes `/record <subcommand> [args]`. Parse the first token of `args` as the subcommand.

## Beginner Workflows

| Subcommand | Use | Load |
|---|---|---|
| `help` | First-run guide. Explains Sillok in friendly Korean and routes the learner by material type. | `<SKILL_DIR>/help.md` |
| `study [path?]` | A single study event, including an AI conversation, note, PDF, lecture, article, or problem-solving session. | `<SKILL_DIR>/study.md` |
| `course [args?]` | A course, book, lecture series, or other multi-session learning track. Includes `course backfill <slug> --plan`. | `<SKILL_DIR>/course.md` |
| `query <question>` | Ask the accumulated notes. Read-only by default. | `<SKILL_DIR>/query.md` |

## Maintenance Workflows

| Subcommand | Use | Load |
|---|---|---|
| `lint` | Deterministic guardrail checks: schema, links, output quality guard, secrets, binary creep. | `<SKILL_DIR>/lint.md` |
| `curate [scope?]` | Qualitative review, repair, sweep, or recurring-rule learning. | `<SKILL_DIR>/curate.md` |

`capture` is not a beginner workflow. AI conversations are study material and belong inside `/record study`.

`<SKILL_DIR>` means the record skill directory on the active tool surface.

## Before Reading Or Writing

For `help`, read `<SKILL_DIR>/help.md` first. Do not mutate the notes from help unless the learner explicitly asks to start one of the routed workflows.

For `study`, `course`, `query`, `lint`, or `curate`, read `CONTEXT.md` before selecting evidence files.

For any notes mutation, read `CONVENTIONS.md` and the selected workflow file.

Read `ontology/page-manifest.json` before searching for candidate pages. Read `ontology/page-dependencies.json` before changing an existing page when semantic dependents may need review.

Make the smallest coherent update to `notes/`. Keep beginner experience simple, and keep generated maps invisible to the learner unless they ask about system internals.
