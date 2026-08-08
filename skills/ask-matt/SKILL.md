---
name: ask-matt
description: Ask which skill or flow fits your situation. A router over the skills in this repo.
disable-model-invocation: true
---

# Ask Matt

You don't remember every skill, so ask.

A **flow** is a path through the skills. Most paths run along one **main flow**. Everything else is standalone, or a vocabulary layer that runs underneath.

## The main flow: idea → handoff

The route design-engineering work travels. You have an idea — a redesign, a token system, a component library — and the destination is a **handoff**: a per-component spec sheet the building team works from.

1. **`/grill-with-docs`** — sharpen the idea by interview. Start here when you **have a codebase**: it's stateful, retaining what it learns in `CONTEXT.md` and ADRs. (No codebase? Use `/grill-me` — see Standalone. Both run the same `/grilling` primitive; `grill-with-docs` is the one that leaves a paper trail.)
2. **Branch — can you settle every question in conversation?** Structure and naming questions ("one Card with three variants, or three components?") settle by grilling. A question that needs a **rendered answer** detours, bridged by **`/handoff`** in both directions (see Crossing sessions):
   - **`/explore-variants`** when the question is a **system axis** — token set, spacing scale, motion timing, theming, breakpoints: one fixed specimen, several named candidates, toggled side by side.
   - **`/prototype`** when the question is a page or flow design, or a state model: several radically different variations on one route, or a tiny terminal app.
3. **Branch — is this a multi-session effort?**
   - **Yes** → **`/wayfinder`** (see below): chart the map, work the tickets, then exit through **`/to-handoff`**.
   - **No** → the thread already holds every decision; run **`/to-handoff`** on it directly if the output should be a handoff, or just apply the decision.

### The big effort: `/wayfinder`

For the huge, foggy effort — a design system from scratch, a multi-surface redesign — too big for one session. It charts a **shared map** of **decision tickets** on the issue tracker and resolves them one at a time — producing **decisions, not deliverables** — until the fog is pushed back and the way is clear. Where **`/grill-with-docs`** sharpens an idea you can hold in one session, wayfinder is for the idea you can't — and it's slower and denser, so save it for exactly that, never a well-scoped feature.

Tickets route by question: system axes → **`/explore-variants`**, pages and flows → **`/prototype`**, structure and naming → grilling, outside facts → **`/research`** (fired as parallel background agents), apparatus that must exist before a decision can be judged → task tickets (specimen pages, harnesses, audits — every task must block a decision ticket). The routing rules live in the [design-engineering overlay](../../../docs/design-engineering/overlay.md), copied into the target project's `CLAUDE.md`.

When the map clears, **it hands off, it doesn't build**: **`/to-handoff`** collapses the map's linked decisions into the per-component spec sheet — states, token bindings, interaction, accessibility, edge cases — for the humans building it.

### Context hygiene

Keep grilling and charting in **one unbroken context window** — don't compact or clear mid-thinking. The limit is the **[smart zone](https://www.aihero.dev/ai-coding-dictionary/smart-zone)**: the window (~120k tokens on state-of-the-art models) within which the model still reasons sharply. If a session approaches it, don't push on degraded — `/handoff` and continue in a fresh thread. When working a wayfinder map, resolve **one ticket per session** (research excepted).

## Vocabulary underneath

A model-invoked reference that runs *beneath* the other skills — the single source of truth for its vocabulary. Reach for it directly when the **words**, not the process, are the problem; or let the skills above pull it in.

- **`/domain-modeling`** — sharpen the project's *domain* language: challenge a fuzzy term, resolve an overloaded word ("card" doing three jobs), record a hard-to-reverse decision as an ADR. It's the active discipline `/grill-with-docs` drives to keep `CONTEXT.md` a clean glossary.

## Crossing sessions

- **`/handoff`** — when a thread is full or you need to branch off (e.g. into a `/prototype` or `/explore-variants` session), this compacts the conversation into a markdown file. You don't continue in place — you **open a new session and reference that file** to carry the context across. It's the bridge between context windows, in either direction. Use it when you want a **fresh session** but need the **current conversation preserved**. Not to be confused with `/to-handoff`, the map terminus.
- **`/compact`** (built-in) — stay in the **same conversation**, letting the earlier turns be summarized. Use it at **intentional breaks between phases**, when you don't mind losing the verbatim history. Don't compact mid-phase — the agent can lose its way. `/handoff` forks; `/compact` continues.

## Standalone

Off the main flow entirely.

- **`/grill-me`** — the same relentless interview as `/grill-with-docs`, but for when you have **no codebase**. Stateless: it saves nothing locally, builds no `CONTEXT.md`. Reach for it to sharpen any plan or design that doesn't live in a repo.
- **`/prototype`** and **`/explore-variants`** — the detours in step 2 of the main flow, but reach for either any time a design question is hard to settle on paper.
- **`/research`** — delegate reading legwork to a **background agent**: it investigates a question against **primary sources**, then leaves a cited Markdown file in the repo. Keep working while it reads. The file it produces is something to take *into* the main flow at `/grill-with-docs` — research feeds the thinking, it doesn't replace it.
- **`/teach`** — learn a concept over multiple sessions, using the current directory as a stateful workspace.
- **`/writing-great-skills`** — reference for writing and editing skills well.

## Precondition

**`/setup-matt-pocock-skills`** — run before your first flow to configure the issue tracker and doc layout the other skills assume. Custom issue trackers also work.

## Not in this flow

The upstream dev-flow skills (`to-spec`, `to-tickets`, `implement`, `tdd`, `code-review`, `diagnosing-bugs`, `triage`, `improve-codebase-architecture`, `resolving-merge-conflicts`, `codebase-design`) live unpromoted in `skills/misc/` — this repo's flow ends at the handoff; building from it is another team's (or another repo's) work.
