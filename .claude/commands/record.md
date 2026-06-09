# /record

Route Sillok notes requests through `.claude/skills/record/SKILL.md`.

Public workflows:

- `/record help`
- `/record study`
- `/record course`
- `/record course backfill <slug> --plan`
- `/record query`

Maintenance workflows:

- `/record lint`
- `/record curate`

Before querying or mutating `notes/`, read `CONTEXT.md`.

Before mutating `notes/`, read `CONVENTIONS.md` and the relevant workflow file under `.claude/skills/record/`.

Use `ontology/page-manifest.json` before searching for candidate pages. Use `ontology/page-dependencies.json` before changing existing pages.
