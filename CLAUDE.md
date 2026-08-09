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

`Clear` is activated automatically: `install.sh` writes
`"outputStyle": "Clear"` into `~/.claude/settings.json`, so every synced
session starts in it. Switch with `/output-style <name>` at any time — the
installer only sets the key when it is missing, so a manual switch survives
the next sync. `keep-coding-instructions: true` means the style changes tone
and structure only — the normal coding behaviour stays.

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

## Dev-flow skills (`skills/`)

The engineering half of the same workflow, vendored from the same source
under MIT. `wayfinder` exits either into `to-handoff` (design) or into
`to-spec → to-tickets → implement` (code).

| Skill | Use for |
|---|---|
| `to-spec` | Turning the current conversation into a spec on the issue tracker |
| `to-tickets` | Breaking a spec into tracer-bullet tickets with blocking edges |
| `implement` | Building a piece of work from a spec or tickets |
| `triage` | Moving issues and external PRs through triage roles into agent-ready briefs |
| `tdd` | Red-green-refactor and integration tests |

Also: `code-review` (review since a fixed commit, on standards + design axes),
`diagnosing-bugs`, `codebase-design` and `improve-codebase-architecture` (deep
modules), `resolving-merge-conflicts`, `setup-pre-commit`,
`git-guardrails-claude-code`, plus two TypeScript-specific ones,
`migrate-to-shoehorn` and `scaffold-exercises`.

Overlaps to know about: `diagnosing-bugs` covers similar ground to
`production-debugger`, the deep-module pair to `clean-architecture-refactor`,
and `code-review` shadows Claude Code's built-in `/code-review`. Pick one per
task rather than running both.

## Productivity skills (`skills/`)

The rest of the `productivity` bucket from the same source, MIT. All three
are `disable-model-invocation: true` — they only run when invoked by name,
never auto-triggered.

| Skill | Use for |
|---|---|
| `grill-me` | Slash-command entry point that runs a `grilling` session |
| `teach` | Learning a topic across sessions, with state kept in the workspace |
| `writing-great-skills` | Reference for writing and editing skills predictably |

More overlaps: `teach` shadows Claude Code's built-in `learn` skill, and
`writing-great-skills` shadows `skill-creator`. Same rule — pick one.

## How this repo syncs

This repo mirrors `~/.claude/` directly:

- `CLAUDE.md` (this file) → `~/.claude/CLAUDE.md`
- `skills/<name>/` → `~/.claude/skills/<name>/`
- `output-styles/<name>.md` → `~/.claude/output-styles/<name>.md`
- plus `"outputStyle": "Clear"` merged into `~/.claude/settings.json`

`install.sh` in this repo does all four steps. Project repos run it via a
SessionStart hook, which `add-hook.sh` writes for them — run it once inside
a new project and it wires up both the hook and `.claude/settings.json`.
Because the copying lives here and not in the projects, later changes to
what gets synced need no edits in the consuming repos. Project-specific context (e.g.
a Shopify theme's design tokens, scope boundaries) stays in that project's
own `CLAUDE.md`, never in this repo.

## Updating this repo

1. Edit `CLAUDE.md`, `skills/<name>/SKILL.md`, or
   `output-styles/<name>.md` directly in this repo.
2. Commit and push to `main` (or a branch + PR, if you want review).
3. Changes reach other projects the next time their SessionStart hook runs
   (i.e. their next Claude Code on the web session) — there's no need to
   touch anything in the consuming project itself.
