# CLAUDE.md

Personal, cross-project Claude Code configuration for Konbini. This file is
synced to `~/.claude/CLAUDE.md` (see "How this repo syncs" below) so it
applies in every repo, not just one project.

## Communication rules

- Always start chat replies with "Konbini".
- Talk to the user in Polish in chat.
- All work product is in English: code, comments, commit messages, PR
  titles/descriptions, file names, and every file under `docs/` or
  `.claude/skills/`.
- Git: creating local commits after a meaningful change is fine without
  asking. Always ask for confirmation before `git push`.
- Reply shape follows the `Clear` output style (see "Output styles"
  below): one point per turn, spoken tone, and the
  Where/Did/Worked/Now skeleton after doing work.

## Output styles (`output-styles/`)

| Style | Use for |
|---|---|
| `Clear` | Spoken, scannable, low-load replies with a fixed task-reply shape |

Activate with `/output-style Clear` (Claude Code reads
`~/.claude/output-styles/*.md`). `keep-coding-instructions: true` means the
style changes tone and structure only — the normal coding behaviour stays.

## Engineering skills library (`skills/`)

General-purpose senior-engineer personas, useful on any project. Each is a
standalone skill Claude Code can invoke by name or auto-trigger from its
description:

| Skill | Use for |
|---|---|
| `startup-mvp` | Designing + building a minimal, scalable MVP from scratch |
| `legacy-codebase-audit` | Reverse-engineering an unfamiliar codebase before changing it |
| `production-debugger` | Root-causing a live bug/outage |
| `performance-optimizer` | Speed/memory/scalability optimization passes |
| `clean-architecture-refactor` | Refactoring for modularity without changing behavior |
| `infra-systems-architect` | Designing backend/infrastructure architecture for a new system |
| `four-agent-team` | Full Architect → Engineer → Reviewer → Optimizer pass on one task |
| `frontend-ui-builder` | Building reusable, accessible production UI components |
| `senior-tech-lead` | Pre-code clarification, tradeoffs, and planning on ambiguous work |
| `security-audit` | Vulnerability review with severity and fixes |
| `devops-deployment` | Deployment architecture, CI/CD, monitoring, release checklist |

These are guidelines, not a queue of pending tasks — no software gets built
from them until the user explicitly asks for an implementation.

## Design skills library (`skills/`)

World-class UI/UX quality bar, covering aesthetics, typography, color,
spatial/layout, motion, and copy. `frontend-design` is Anthropic's official
skill (copied verbatim, Apache 2.0, see its `LICENSE.txt`); the rest are
original, written after researching the highest-rated community skills so
they encode the same underlying methodologies without vendoring unreviewed
third-party instructions.

| Skill | Use for |
|---|---|
| `frontend-design` | Distinctive overall aesthetic direction; avoiding templated AI defaults |
| `typography-system` | Type scale, pairing, hierarchy, measure/line-height |
| `color-system` | Palette construction, semantic tokens, WCAG contrast |
| `spatial-layout-design` | Grid, spacing scale, whitespace, alignment |
| `motion-design` | Purposeful UI motion grounded in classical animation principles |
| `tone-of-voice-ux-writing` | Brand voice + UX microcopy patterns (buttons, errors, empty states, forms) |
| `design-critique-audit` | Pre-ship quality gate tying all of the above into one anti-AI-slop checklist |

## Design-engineering workflow skills (`skills/`)

A planning workflow for design work too big for one session: sharpen the
idea, chart it as decision tickets, resolve them one at a time, exit through
a handoff. Vendored from
[aleksanderwalczuk/design-skills](https://github.com/aleksanderwalczuk/design-skills)
(itself derived from Matt Pocock's skills), MIT — see each skill's
`LICENSE.txt`.

| Skill | Use for |
|---|---|
| `ask-matt` | Router — picking which of these skills fits the situation |
| `grill-with-docs` | Relentless interview that sharpens an idea and writes `CONTEXT.md` + ADRs |
| `wayfinder` | Charting a large effort as decision tickets on an issue tracker |
| `explore-variants` | Comparing system axes (tokens, spacing, motion) side by side |
| `prototype` | Throwaway prototype that answers one UI or logic question |

Support skills, invoked by the five above: `domain-modeling` (glossary and
ADRs), `research` (background agent against primary sources), `to-handoff`
(per-component spec sheet), `grilling` and `handoff` (interview and
context-compaction primitives), and `setup-matt-pocock-skills` (run once per
project to wire the issue tracker).

Same rule as the other libraries: these plan and decide, they don't build
until the user asks.

## How this repo syncs

This repo mirrors `~/.claude/` directly:

- `CLAUDE.md` (this file) → `~/.claude/CLAUDE.md`
- `skills/<name>/SKILL.md` → `~/.claude/skills/<name>/SKILL.md`
- `output-styles/<name>.md` → `~/.claude/output-styles/<name>.md`

Project repos pull it in automatically via a SessionStart hook — see
`README.md` for the copy-pasteable snippet. Project-specific context (e.g.
a Shopify theme's design tokens, scope boundaries) stays in that project's
own `CLAUDE.md`, never in this repo.

## Updating this repo

1. Edit `CLAUDE.md`, `skills/<name>/SKILL.md`, or
   `output-styles/<name>.md` directly in this repo.
2. Commit and push to `main` (or a branch + PR, if you want review).
3. Changes reach other projects the next time their SessionStart hook runs
   (i.e. their next Claude Code on the web session) — there's no need to
   touch anything in the consuming project itself.
