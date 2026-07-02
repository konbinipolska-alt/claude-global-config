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

## How this repo syncs

This repo mirrors `~/.claude/` directly:

- `CLAUDE.md` (this file) → `~/.claude/CLAUDE.md`
- `skills/<name>/SKILL.md` → `~/.claude/skills/<name>/SKILL.md`

Project repos pull it in automatically via a SessionStart hook — see
`README.md` for the copy-pasteable snippet. Project-specific context (e.g.
a Shopify theme's design tokens, scope boundaries) stays in that project's
own `CLAUDE.md`, never in this repo.

## Updating this repo

1. Edit `CLAUDE.md` or `skills/<name>/SKILL.md` directly in this repo.
2. Commit and push to `main` (or a branch + PR, if you want review).
3. Changes reach other projects the next time their SessionStart hook runs
   (i.e. their next Claude Code on the web session) — there's no need to
   touch anything in the consuming project itself.
