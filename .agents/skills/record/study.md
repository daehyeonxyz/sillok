# /record study

Use this when the learner completed one study event.

Examples:

- read an article, book section, or paper
- watched a lecture
- asked an AI assistant questions while studying
- solved exercises
- wrote rough notes
- finished a small standalone topic

## Goal

Turn the study event into durable learning context.

Do not archive the entire conversation or source into `notes/`. Extract what changes future study.

## Context Loading

1. Read `CONTEXT.md`.
2. Read `CONVENTIONS.md`.
3. Read this workflow file.
4. Read `ontology/page-manifest.json` before searching for existing pages.
5. Read `notes/index.md`, `notes/questions.md`, `notes/review.md`, and `notes/_stubs.md`.
6. Read `ontology/page-dependencies.json` before changing an existing page with inbound dependents.

## Steps

1. Identify the study material:
   - files under `raw/inbox/`
   - pasted notes
   - the current conversation
   - links or filenames the user mentions
2. Decide whether to use the Reader / Writer / Verifier split from `CONTEXT.md`.
3. Decide what should persist:
   - important concepts
   - learner-specific questions
   - misunderstandings or confusions
   - examples that made something click
   - review items
   - links to existing pages
4. Create or update a small number of pages:
   - one session/source record when useful
   - one to three concept, question, or insight pages if they are durable
   - `notes/questions.md`
   - `notes/review.md`
   - `notes/_stubs.md` if a useful page should exist later
5. Run the content guard from `CONVENTIONS.md` on touched page bodies before any trailing `## Source`.
6. Regenerate `ontology/page-manifest.json` if page coordinates changed.
7. Regenerate `ontology/page-dependencies.json` if Obsidian links or body relations changed.
8. Append one line to `notes/log.md`.
9. Report what changed and what the learner should review next.

## Reader / Writer / Verifier

Use the split for long PDFs, transcripts, lecture bundles, directories of notes, or AI conversations with many turns.

Reader:

- reads the source material and extracts claims, concepts, examples, equations, terms, learner questions, and possible links
- does not write `notes/`
- returns a compact chunk for the Writer

Writer:

- reads the Reader chunk, `CONVENTIONS.md`, this workflow, and generated maps
- creates or updates notes pages
- avoids loading the full source again unless the chunk is insufficient

Verifier:

- checks frontmatter, output quality, link usefulness, source block placement, log entry, and generated map freshness
- surfaces dependent pages from `ontology/page-dependencies.json` when touched pages have inbound links

## Page Guidance

Prefer short, reusable pages over long summaries.

A good `/record study` result answers:

- What did I study?
- What did I understand?
- What is still unclear?
- What should I revisit?
- What prior page does this connect to?

## If The User Gives An AI Conversation

Treat the conversation as study material.

Extract:

- the learner's actual questions
- useful explanations
- corrected misunderstandings
- open questions
- reusable concepts

Do not create a separate `capture` operation unless the user explicitly asks for an advanced raw conversation archive.
