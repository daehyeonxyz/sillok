$ErrorActionPreference = "Stop"

$repo = Split-Path -Parent $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding($false)

function Convert-ToCodex {
    param([string]$Path)
    $text = [System.IO.File]::ReadAllText($Path, $utf8)
    $text = $text.Replace("Claude Code", "Codex")
    $text = $text.Replace("Claude", "Codex")
    $text = $text.Replace(".claude/", ".agents/")
    $text = $text.Replace(".claude\", ".agents\")
    $text = $text.Replace("CLAUDE.md", "AGENTS.md")
    [System.IO.File]::WriteAllText($Path, $text, $utf8)
}

function Repair-AgentsEntrypoint {
    param([string]$Path)
    $text = [System.IO.File]::ReadAllText($Path, $utf8)
    $layersSection = @'
## Layers

- `raw/` - source material. Users can drop PDFs, notes, transcripts, and rough files into `raw/inbox/`.
- `notes/` - agent-maintained Markdown learning context. Flat by default. Special files: `index.md`, `log.md`, `_stubs.md`, `review.md`, `questions.md`.
- `ontology/` - tiny schema, optional vocabularies, and generated routing maps for agents.
- `docs/` - philosophy and workflow docs.
- `CONTEXT.md` - context-routing contract for agents.
- `.claude/skills/record/` - canonical Claude Code workflow bodies.
- `.agents/skills/record/` - Codex workflow bodies used by this surface.

## Workflow Router
'@
    $surfaceSection = @'
## Surface Mirror Discipline

This file is the Codex-facing mirror of the Claude Code surface. Keep `.agents/` + `AGENTS.md` aligned with `.claude/` + `CLAUDE.md`.

- **Canonical edit target**: `.claude/` and `CLAUDE.md`. Regenerate this Codex mirror with `scripts/sync-agents.ps1` when the canonical side changes.
- **Mirror review**: after sync, review `AGENTS.md` and `.agents/skills/record/` for tool-specific wording before staging.
- **Run sync in the same commit** that edits the canonical side. Both surfaces stage together.
- **Shared (NOT mirrored)**: `CONTEXT.md`, `CONVENTIONS.md`, `docs/`, `ontology/`, `raw/`, and `notes/`.

## Operating Principle
'@
    $layersPattern = '(?ms)^## Layers\r?\n\r?\n.*?^## Workflow Router'
    $text = [regex]::Replace($text, $layersPattern, $layersSection, 1)
    $pattern = '(?ms)^## Surface Mirror Discipline\r?\n\r?\n.*?^## Operating Principle'
    $text = [regex]::Replace($text, $pattern, $surfaceSection, 1)
    [System.IO.File]::WriteAllText($Path, $text, $utf8)
}

$srcDir = Join-Path $repo ".claude\skills\record"
$dstDir = Join-Path $repo ".agents\skills\record"
New-Item -ItemType Directory -Force -Path $dstDir | Out-Null

Get-ChildItem -LiteralPath $dstDir -Filter "*.md" -ErrorAction SilentlyContinue | Remove-Item -Force
Get-ChildItem -LiteralPath $srcDir -Filter "*.md" | ForEach-Object {
    $dst = Join-Path $dstDir $_.Name
    Copy-Item -LiteralPath $_.FullName -Destination $dst -Force
    Convert-ToCodex -Path $dst
    Write-Host "synced  .agents/skills/record/$($_.Name)"
}

$claudeMd = Join-Path $repo "CLAUDE.md"
$agentsMd = Join-Path $repo "AGENTS.md"
Copy-Item -LiteralPath $claudeMd -Destination $agentsMd -Force
Convert-ToCodex -Path $agentsMd
Repair-AgentsEntrypoint -Path $agentsMd
Write-Host "synced  AGENTS.md"

Write-Host "`nDone. Review with: git diff .agents AGENTS.md"
