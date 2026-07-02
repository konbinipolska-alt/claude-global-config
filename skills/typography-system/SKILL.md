---
name: typography-system
description: Build or audit a rigorous typographic system — type scale, pairing, hierarchy, measure, and line-height — instead of reaching for default AI-generated fonts and ad-hoc sizes. Use when a design needs a real type system, or when reviewing whether existing typography reads as generic.
---

# Typography System

Typography is the single highest-leverage design decision on any page — it
carries hierarchy, tone, and brand before a single color or image is
considered. Treat it as a system, not a series of one-off `font-size` picks.

## Avoid the defaults

Every AI-generated interface reaches for the same handful of typefaces
because they're the safest average of the training data: **Inter, Roboto,
Arial, Helvetica, Space Grotesk, and system-ui-as-a-personality-choice**.
These aren't wrong technically, but they read as "no decision was made."
Unless the brief specifically calls for maximum neutrality (e.g. a dense
data/admin tool where typography should disappear), pick a typeface that has
a point of view — and justify it against the subject, not against "what
looks clean."

## Build the system

- **Roles, not just sizes**: define a display face (used with restraint, for
  the 1–2 moments that carry personality), a body face (optimized for
  reading at length, not for the hero), and — only if needed — a
  utility/mono face for data, code, or captions. Two type families is
  usually enough; a third needs a specific reason.
- **Scale**: pick a ratio (1.125–1.333 for tight/functional UI, 1.4–1.618 for
  editorial/expressive) and derive every size from it rather than eyeballing
  each heading level. Name the steps (e.g. `--text-xs` … `--text-3xl`) so
  they're reusable, and check the project for existing tokens before
  inventing a parallel scale.
- **Weight and width as hierarchy tools**: prefer weight/size contrast over
  reaching for a whole new typeface to distinguish heading from body.
  Overusing bold for emphasis flattens hierarchy — reserve heavy weights for
  true top-level moments.
- **Measure and line-height**: body text wants ~45–75 characters per line
  (`ch` unit is a fast proxy) and 1.4–1.6 line-height; tighten line-height as
  size increases (large display type can go to 1.0–1.15) or it looks loose
  and amateurish.
- **Tracking**: negative letter-spacing on large display type, slightly
  positive/default on small uppercase labels — never uniform tracking across
  every size.

## Pairing rules

- Pair by contrast, not similarity: a geometric/humanist sans display with a
  text-optimized serif or vice versa reads intentional; two similar
  grotesques next to each other reads like an accident.
  Also fine: one distinctive display face + its own family's regular weight
  as body, used consistently.
- Never let two faces compete for the same job (two display faces on one
  page, or a decorative face used at body-text sizes).

## Deliverables

- **Type roles + scale** — named tokens, ratio-derived, with rationale.
- **Pairing** — the chosen faces and why they suit the subject/brand, not "because they're popular."
- **Implementation** — actual CSS/tokens wired into the project's existing design-token system if one exists.
- **Audit findings** (when reviewing) — inconsistent ad-hoc sizes, default-font usage with no rationale, measure/line-height violations, flagged with file:line.

## Sources

- Butterick's Practical Typography — scale, measure, line-height, and pairing fundamentals: practicaltypography.com
- Refactoring UI (Adam Wathan & Steve Schoger) — type scale and hierarchy chapter
- Nielsen Norman Group — legibility and readability research for on-screen text: nngroup.com
