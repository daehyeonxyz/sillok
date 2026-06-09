# /record lint

Deterministic maintenance for a naite learning context.

`/record lint` and `/record curate` are the two maintenance tracks:

- `/record lint` is deterministic guardrail work.
- `/record curate` is qualitative judgement and repair.

## Goal

Find machine-checkable drift without turning the beginner workflow into a taxonomy project.

## Context Loading

1. Read `CONTEXT.md`.
2. Read `CONVENTIONS.md`.
3. Read this workflow file.
4. Read or rebuild `ontology/page-manifest.json`.
5. Read or rebuild `ontology/page-dependencies.json`.

## Generated Maps

Run these before reporting map-dependent findings:

```powershell
python scripts/build-page-manifest.py
python scripts/build-page-dependencies.py
```

Use `ontology/page-manifest.json` for page counts, schema-coordinate summaries, and starter-page presence.

Use `ontology/page-dependencies.json` for broken Obsidian links, inbound counts, orphan candidates, and soft relation idiom counts.

These JSON files are tracked operating maps. Do not hand-edit them.

## Checks

Report findings for:

- missing required starter files
- stale or invalid generated maps
- broken Obsidian links in `notes/`
- frontmatter with unknown `kind`, `form`, or `source-types`
- raw/source-processing voice before trailing `## Source`
- mojibake markers
- obvious secret patterns
- binary creep outside expected folders
- empty or stale `questions.md`, `review.md`, or `_stubs.md` when recent study pages suggest updates

## Output Quality Guard

Scan touched pages, and optionally all `notes/*.md`, before trailing `## Source`.

Flag:

- `raw/`, `` `raw` ``, staging, source bundle
- `PDF page`, `page range`, render, image-read, extraction, backfill, run-log
- Korean source/process voice listed in `CONVENTIONS.md`
- mojibake markers: `???`, `占?`, `횄`, `횂`
- generic production headings: `Source Staging`, `Concept Extraction`, `Maps to`

Do not flag:

- paths inside the trailing `## Source` block
- formulas, commands, model names, technical English terms, or quoted titles

## Report Shape

Print a concise markdown report:

```md
# naite Lint

## Summary
- pages: N
- broken links: N
- schema drift: N
- output guard: N
- secrets: N
- map freshness: ok|stale

## Findings
- path:line - finding
```

Secrets are blockers. Stop and report before any further write.
