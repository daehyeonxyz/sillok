# Sillok Schema

This schema is for agents. Users should not need to think about it during normal study.

## Frontmatter

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

## kind

- `concept` - reusable idea, method, theory, pattern, or term
- `source-record` - studied source or session record
- `session` - study session summary
- `course` - long-running course, book, or lecture track
- `question` - recurring or unresolved learner question
- `decision` - study/project decision with reasoning
- `insight` - learner-specific realization or connection
- `index` - navigation page

## form

- `prose`
- `index`

## source-types

- `lecture`
- `book`
- `paper`
- `article`
- `docs`
- `conversation`
- `note`
- `external`

## topics, subject, domains

Keep these lightweight:

- `topics` are reusable tags.
- `subject` is an optional broad path such as `computer-science/operating-systems`.
- `domains` is derived from the first segment of `subject`.

If unsure, leave them empty.

## generated maps

`page-manifest.json` and `page-dependencies.json` are generated agent maps.

Do not hand-edit them. Rebuild with:

```powershell
python scripts/build-page-manifest.py
python scripts/build-page-dependencies.py
```
