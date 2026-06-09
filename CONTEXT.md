# CONTEXT.md - naite context routing

This file defines what an agent should load first, what it should load only on demand, and when source-heavy study work should be split into Reader / Writer / Verifier phases.

It is an operating contract. It is not the beginner mental model, schema policy (`CONVENTIONS.md`), or a workflow body (`.claude/skills/record/*.md` and `.agents/skills/record/*.md`).

## Purpose

naite should feel simple to the learner, but predictable to the agent.

The learner should think in three actions:

1. study,
2. course,
3. query.

The agent should route context in five layers:

1. **Authority**: rules that decide what is allowed.
2. **Procedure**: the active workflow contract.
3. **Map**: compact generated indexes that find relevant pages fast.
4. **Evidence**: the specific source files and notes pages needed for this task.
5. **Verification**: deterministic checks and dependency review after edits.

Do not make the user think about generated maps, ontology internals, or dependency propagation. Those are agent responsibilities.

## Foundation Documents

| Role | File |
|---|---|
| Claude bootloader | `CLAUDE.md` |
| Codex bootloader | `AGENTS.md` |
| Context routing | `CONTEXT.md` |
| Mutation invariants | `CONVENTIONS.md` |
| Schema reference | `ontology/schema.md` |
| Subject hints | `ontology/subjects.md` |
| Topic hints | `ontology/topics.md` |
| Agent page map | `ontology/page-manifest.json` |
| Agent dependency map | `ontology/page-dependencies.json` |
| Claude workflow contracts | `.claude/skills/record/*.md` |
| Codex workflow contracts | `.agents/skills/record/*.md` |
| Human landing page | `notes/index.md` |
| Review queue | `notes/review.md` |
| Question queue | `notes/questions.md` |
| Missing page register | `notes/_stubs.md` |
| Audit trail | `notes/log.md` |

`ontology/page-manifest.json` and `ontology/page-dependencies.json` are compact generated operating maps. They are tracked because agents need them as fast-path context, but they are never hand-edited. Regenerate them with the scripts in `scripts/`.

## Default Loading Order

1. **Bootloader**: read `CLAUDE.md` or `AGENTS.md` for the active surface.
2. **Route intent**: classify the user request into `study`, `course`, `query`, `lint`, `curate`, or a non-notes answer.
3. **Context contract**: read this file when the task involves notes mutation, notes query, context selection, routing, dependency propagation, lint, or curate.
4. **Mutation authority**: for any notes mutation, read `CONVENTIONS.md`.
5. **Workflow procedure**: read the exact workflow file under the active surface, such as `.claude/skills/record/study.md` or `.agents/skills/record/query.md`.
6. **Generated maps**: read `ontology/page-manifest.json` before searching for target pages; read `ontology/page-dependencies.json` before changing an existing page or reviewing semantic dependents.
7. **Local evidence**: read only the source files, notes pages, ontology sections, and recent log entries required by the task.
8. **Verification**: after edits, run the relevant deterministic scripts and rebuild generated maps when page coordinates or links changed.

Do not use `notes/index.md` as an exhaustive search index. It is a curated human landing page. Use `ontology/page-manifest.json` as the agent fast path, then read the specific notes pages it identifies.

## Workflow Context Matrix

| Workflow | Always load | Load when needed |
|---|---|---|
| `/record study` | bootloader, `CONTEXT.md`, `CONVENTIONS.md`, active `study.md`, `ontology/page-manifest.json`, `notes/index.md`, `notes/questions.md`, `notes/review.md` | `ontology/schema.md`, `ontology/subjects.md`, `ontology/topics.md`, `ontology/page-dependencies.json`, files under `raw/inbox/`, source notes, prior pages |
| `/record course` | bootloader, `CONTEXT.md`, `CONVENTIONS.md`, active `course.md`, `ontology/page-manifest.json`, `notes/index.md`, recent `notes/log.md` | `ontology/page-dependencies.json`, `ontology/schema.md`, course source files, prior course pages |
| `/record query` | bootloader, `CONTEXT.md`, active `query.md`, `ontology/page-manifest.json` | `ontology/page-dependencies.json`, target pages, `notes/questions.md`, `notes/review.md`, `notes/log.md` for timeline questions |
| `/record lint` | bootloader, `CONTEXT.md`, `CONVENTIONS.md`, active `lint.md`, generated maps | scripts, ontology files, `notes/log.md`, starter pages |
| `/record curate` | bootloader, `CONTEXT.md`, `CONVENTIONS.md`, active `curate.md`, generated maps | target pages, inbound dependents, producer workflow files when defects repeat |
| Schema or workflow redesign | bootloader, `CONTEXT.md`, `CONVENTIONS.md`, relevant workflow files | `ontology/schema.md`, validator scripts, mirror sync script |

## Reader / Writer / Verifier Split

Use separate physical agents when the tool surface supports them and the user has authorized agent delegation. If physical subagents are unavailable, keep the same roles as explicit sequential phases in one session.

### Use The Split When Any Condition Is True

- The source is long, dense, or multi-file.
- A PDF, transcript, lecture bundle, or directory of notes is involved.
- The workflow has a strict output contract, especially `/record study` and `/record course`.
- Five or more notes pages may be touched.
- Ontology selection is ambiguous.
- Existing pages with inbound dependents may be changed.

### Reader Role

The Reader receives the source material and minimal task framing. It extracts claims, concepts, examples, equations, diagrams, terms, possible Obsidian links, and uncertainty.

The Reader does not write `notes/*.md`, does not choose final frontmatter, and does not mutate `ontology/`.

Reader output should be a compact raw chunk with:

- source unit identity,
- key claims,
- reusable concept candidates,
- examples and formulas,
- terms and aliases,
- learner questions or ambiguities,
- suggested existing note links if obvious.

### Writer Role

The Writer receives the Reader chunk, `CONVENTIONS.md`, the active workflow file, generated maps, and relevant ontology files. It writes or updates notes pages according to the workflow contract.

The Writer should avoid loading the full source again unless the Reader chunk is insufficient or the workflow requires exact verification.

### Verifier Role

The Verifier checks touched pages against:

- frontmatter contract,
- output quality contract,
- link usefulness,
- source block placement,
- `notes/log.md` rules,
- generated manifest freshness,
- dependency map inbound candidates.

The Verifier surfaces semantic dependents for review. It does not automatically rewrite dependent pages unless the active workflow and user request authorize repair.

## Generated Map Policy

### `ontology/page-manifest.json`

Build command:

```powershell
python scripts/build-page-manifest.py
```

Purpose:

- direct slug lookup,
- page coordinate lookup by `kind`, `form`, `topics`, `subject`, `source-types`, and `domains`,
- fast candidate narrowing before reading full notes pages,
- index drift and hub candidate support.

This map is intentionally compact. It stores page coordinates, titles, and aliases, not page bodies.

Regenerate when:

- a notes page is created, deleted, or renamed,
- frontmatter changes,
- a title or alias section changes,
- a workflow needs a fresh search map.

### `ontology/page-dependencies.json`

Build command:

```powershell
python scripts/build-page-dependencies.py
```

Purpose:

- inbound Obsidian-link lookup,
- outbound dependency lookup,
- soft relation idiom lookup,
- semantic dependent candidate surfacing after edits,
- high-degree page and orphan support.

This map is intentionally slug-level. It stores which pages point to which slugs and which soft relation idioms appear, not full line text.

Regenerate when:

- a notes page body changes,
- Obsidian links change,
- soft ontology idioms change,
- a workflow needs dependency propagation review.

## Dependency Propagation Policy

Not every dependency should trigger automatic edits. Use three levels:

| Level | Examples | Action |
|---|---|---|
| Hard dependency | `CLAUDE.md` to `AGENTS.md`, `.claude/skills/record/*` to `.agents/skills/record/*` | sync with `scripts/sync-agents.ps1` |
| Contract dependency | `CONVENTIONS.md` change affecting workflow files or lint scripts | update the affected contracts and validators in the same change |
| Semantic dependency | concept, question, decision, or source-record content change affecting linked pages | surface candidates from `ontology/page-dependencies.json`, then repair through `/record curate` only when requested |

Python finds candidates. The LLM judges meaning. Do not auto-propagate semantic edits just because an inbound edge exists.

## Verification Checklist

For changes to operating docs or workflow files:

1. Update canonical `.claude/` and root shared files first.
2. Run `scripts/sync-agents.ps1` after `.claude/` or `CLAUDE.md` changes.
3. Rebuild generated maps if notes page coordinates or links changed.
4. Run the relevant deterministic scripts.
5. Review `git diff` before staging.

For changes to notes pages:

1. Run the content guard from `/record lint` or `/record curate`.
2. Run `python scripts/build-page-manifest.py` if page coordinates changed.
3. Run `python scripts/build-page-dependencies.py` if Obsidian links or body relations changed.
4. Inspect inbound dependents for touched slugs.
5. Run the relevant lint command before claiming completion.
