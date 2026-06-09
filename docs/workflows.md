# naite Workflows

naite has one first-run guide, three daily-use workflows, and two maintenance workflows.

## /record help

Use this when the learner asks how to start.

Help should explain naite in friendly Korean, then route by material type:

```text
1. 강의자료 PDF가 있어요.
2. 예전에 AI와 공부했던 대화가 있어요.
3. 필기나 시험 정리 노트가 있어요.
4. 과목 전체를 천천히 옮기고 싶어요.
5. 이미 쌓인 기록에 질문하고 싶어요.
```

Help should not mutate `notes/` directly. It routes to `study`, `course backfill --plan`, or `query`.

If the learner has old AI conversations, help should point to `docs/session-extractor.md`.

## /record study

Use this after a single study event.

Input can be:

- source files in `raw/inbox/`
- rough notes
- AI conversations
- problem-solving attempts
- pasted text

Output can be:

- concept pages
- question updates
- review items
- session/source records
- links to existing pages

For long PDFs, transcript bundles, directories of notes, or dense AI conversations, the agent should use the Reader / Writer / Verifier split in `CONTEXT.md`. The learner still only asks for `/record study`.

## /record course

Use this for long-running learning.

Course examples:

- university course
- online course
- textbook
- lecture series
- certification track

The course workflow manages lifecycle. The actual learning inside each chapter still uses study-like behavior.

### /record course backfill

Use this when a learner wants to move a completed or partly completed course into the notes.

Start with:

```text
/record course backfill <course-slug> --plan
```

Backfill begins from lecture PDFs as baseline material. Notes, exam summaries, and AI conversation extracts are optional boosters.

The plan should split the course by week, chapter, exam range, or source bundle. Do not process a whole course silently in one pass.

## /record query

Use this to ask the accumulated notes.

Query should read from `notes/` first, then answer with links to relevant pages.
The agent should use `ontology/page-manifest.json` as the fast path before reading full pages.

By default, query is read-only.

## /record lint

Use this for deterministic health checks.

Lint should refresh the generated maps first:

```powershell
python scripts/build-page-manifest.py
python scripts/build-page-dependencies.py
```

Lint should surface:

- broken Obsidian links
- schema drift
- obvious secret patterns
- output-quality guard violations
- binary or raw-source creep

Lint reports findings. It should not make broad repairs unless the user asks.

## /record curate

Use this for qualitative review and cleanup.

Curate should handle:

- page quality review
- direct repair
- large-scope sweeps
- recurring-rule learning

When the same defect repeats, update producer workflows first, then add lint checks if the pattern is machine-detectable.

## Hidden Complexity

naite can later grow advanced workflows such as ingest or decision capture. They are intentionally not part of the beginner surface.

AI conversation capture stays inside `/record study`.

The generated files `ontology/page-manifest.json` and `ontology/page-dependencies.json` are also hidden complexity. They help agents route context and surface dependent pages, but users do not need to edit or understand them during normal study.
