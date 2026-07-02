---
name: design-critique-audit
description: Run a final, world-class-bar design critique across aesthetics, typography, color, spatial/layout, motion, and copy before shipping — a consolidated anti-AI-slop checklist tying together frontend-design, typography-system, color-system, spatial-layout-design, motion-design, and tone-of-voice-ux-writing. Use as a pre-ship quality gate on any UI, or when asked to review/critique a design that already exists.
---

# Design Critique / Audit

Act as the senior design director doing final review before a piece ships —
the person whose job is to catch what individually-competent work misses
when nobody steps back to look at the whole. Run every dimension below
against the actual UI (code, screenshots, or a running instance), not
against the intent behind it.

## The AI-slop checklist

These are the recurring tells that make an interface read as generated
rather than designed. None are wrong in isolation — the failure is applying
them by default, everywhere, without a reason specific to this brief.

- **Typography**: Inter/Roboto/Arial/Space Grotesk used with no rationale;
  a single font size doing too many jobs; inconsistent scale steps.
  → `typography-system`
- **Color**: purple-to-blue gradient accent applied regardless of brand;
  hardcoded hex values duplicating existing tokens; low-contrast text that
  fails WCAG AA. → `color-system`
- **Layout**: cards nested in cards at every level; uniform padding
  regardless of content density; near-misses on alignment. → `spatial-layout-design`
- **Motion**: hover-scale on every card/button; pulsing/breathing glow with
  no status meaning; stagger-spam on every list regardless of length;
  identical easing/duration across unrelated interaction types. → `motion-design`
- **Copy**: generic placeholder-sounding strings ("Lorem ipsum"-adjacent
  filler tone); system-speak leaking into user-facing text; inconsistent
  naming for the same action across screens. → `tone-of-voice-ux-writing`
- **Overall composition**: no single memorable/signature element — or the
  opposite, boldness spent in five places instead of one. → `frontend-design`

## Process

1. **Look at the whole before the parts.** Form a first impression the way a
   real user would (what do you notice in the first two seconds?) before
   auditing dimension by dimension.
2. **Walk each dimension explicitly** — typography, color, spatial/layout,
   motion, copy, overall aesthetic — invoking the matching skill above for
   anything that needs a deeper pass, rather than re-deriving those rules
   here.
3. **Rate severity honestly**: a generic-but-functional choice (Critical
   only if it breaks usability or accessibility; Important if it undercuts
   the brand/quality bar; Polish if it's a nice-to-have). Don't flag
   everything as Critical — that's as useless as flagging nothing.
4. **Always name what to keep**, not just what to fix — a critique that's
   100% negative is as unhelpful as one that's 100% positive; call out what
   already reads as intentional and shouldn't be touched.

## Deliverables

- **First-impression summary** — what a real user notices first, 2–3 sentences.
- **Findings by dimension** — each with severity (Critical/Important/Polish), file:line or component reference, and the specific change (not just "improve typography").
- **What to keep** — the choices that already read as deliberate and distinctive.
- **Priority order** — which findings to fix first if time is limited (usually: accessibility/contrast failures, then the dimension most responsible for the "generic" first impression, then polish).

## Sources

- Jakob Nielsen, "10 Usability Heuristics for User Interface Design" (Nielsen Norman Group, 1994) — the baseline heuristic framework this critique process is structured around: nngroup.com
- Baymard Institute — e-commerce-specific UX benchmarking used elsewhere in this project (see `docs/claude-ux-planning-prompt.md`) for category navigation, search, and checkout research: baymard.com/research
