# /record curate

Qualitative maintenance for a naite learning context.

`/record lint` and `/record curate` are the two maintenance tracks:

- `/record lint` is deterministic guardrail work: schema, broken links, output guard, secrets, and machine-checkable hygiene.
- `/record curate` is contextual judgement: whether pages read like self-contained learning context, whether links carry meaning, and whether repeated defects should become producer rules.

## When To Use

Use this when the user asks to:

- review notes quality
- clean up rough pages
- check whether a course or study thread reads coherently
- repair source/process voice that lint surfaced
- learn from repeated defects and strengthen workflow files

## Context Loading

1. Read `CONTEXT.md`.
2. Read `CONVENTIONS.md`.
3. Read this workflow file.
4. Read `ontology/page-manifest.json` before selecting pages.
5. Read `ontology/page-dependencies.json` before reviewing or changing existing pages.

## Scope

Supported scopes:

- `/record curate {slug}` - one page plus immediate graph context
- `/record curate course-{slug}` - one course page and related concept/question/review pages
- `/record curate --all` - whole starter notes
- `/record curate --system` - update producer contracts, lint criteria, or workflow docs from recurring failures

For large scopes, write durable reports under `docs/` only if the result should be kept. Use temporary scratch outside the repo or under gitignored paths for disposable notes.

## Generated Maps

Use `ontology/page-manifest.json` to find pages by slug, title, `kind`, `topics`, `subject`, and `domains`.

Use `ontology/page-dependencies.json` to identify inbound links, outbound links, missing targets, orphan candidates, and pages that may be semantically affected by a repair.

Regenerate the maps after repairs that change frontmatter, titles, Obsidian links, or body relation phrases:

```powershell
python scripts/build-page-manifest.py
python scripts/build-page-dependencies.py
```

## Modes

Pick the mode from user intent; ask only when genuinely ambiguous.

### Review

Read the requested pages and directly relevant links. Produce a prose verdict with concrete page examples. Avoid scores, grades, and rubric language.

Say:

- what is already usable
- what is misleading or thin
- which pages need edits
- whether the issue is page-local, course-wide, or workflow-level

### Repair

When the user asks to fix, edit pages directly. Preserve source substance, useful links, and frontmatter unless the defect is there.

After editing, run the touched-page content guard, regenerate generated maps when needed, and run relevant deterministic lint.

### Sweep

For large scopes, gather repeatable signals first:

- source/process voice in body
- raw path leaks before `## Source`
- mojibake
- shallow link lists that do not explain the relation
- pages whose body depends on raw notes or PDFs to be understood
- inbound dependents that may need review after a semantic change

Cluster by cause and fix in batches only when the user asked for repairs.

### System Learning

Use this when the same defect appears across pages or workflows.

Order of preference:

1. Strengthen producer contracts first (`study.md`, `course.md`, or another output-producing workflow).
2. Add deterministic lint guard only when a pattern is reasonably machine-detectable.
3. Update `CONVENTIONS.md` when the rule applies across workflows.
4. Leave the beginner mental model simple: study, course, query; maintenance via lint and curate.

Do not introduce new facet fields, enum values, or top-level subjects without user decision.

## Content Guard

For touched pages, inspect only the body before `## Source` unless a rule says otherwise.

Flag and fix:

- `raw/`, `` `raw` ``, staging, source bundle
- `PDF page`, `page range`, render, image-read, extraction, backfill, run-log
- Korean source/process voice listed in `CONVENTIONS.md`
- mojibake markers: `???`, `占?`, `횄`, `횂`
- generic production headings such as `Source Staging`, `Concept Extraction`, `Maps to`

False positives are possible. Preserve legitimate technical English, formulas, commands, file paths inside `## Source`, and quoted titles.

## Log Format

Successful curate runs append one coarse entry:

```markdown
## YYYY-MM-DD

- curate | <scope> - reviewed <N>, updated <N>. <one-line summary>
```
