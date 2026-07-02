---
name: spatial-layout-design
description: Build or audit layout and spacing — grid systems, whitespace, alignment, and visual hierarchy through proximity — instead of defaulting to cards nested in cards with uniform padding. Use when structuring a new layout/page, or when reviewing whether existing spacing/composition feels generic or cramped.
---

# Spatial & Layout Design

Space is a design material, not the leftover area between components. Where
you put emptiness communicates hierarchy and grouping as much as any visual
style does — most generic-looking UIs aren't failing at color or type, they're
failing at spacing.

## Avoid the default

The most common AI-generated layout tell is **cards nested in cards**: every
piece of content wrapped in its own bordered/shadowed box, at every nesting
level, regardless of whether grouping actually needs to be signaled. Not
everything is a card. Use a border/shadow/surface change only where there's
a real boundary to communicate; otherwise let whitespace and alignment do
the grouping.

## Build the system

- **Spacing scale, not arbitrary values**: pick a base unit (4px or 8px) and
  derive every margin/padding/gap from it. Check for an existing spacing
  scale/tokens in the project before introducing a new one — inconsistent
  spacing is the fastest way to make a layout look unintentional.
- **Grid as structure, not decoration**: define columns/gutters that content
  actually aligns to. Elements that almost-but-not-quite line up read as
  sloppier than elements that openly break the grid on purpose.
- **Proximity over containers**: group related elements by spacing them
  closer to each other than to unrelated elements first; reach for a
  visible boundary (border, surface change) only when proximity alone isn't
  enough to read as a group.
- **Density matches purpose**: a marketing/landing page wants generous
  whitespace and few things competing for attention at once; a dashboard or
  admin tool wants higher information density and tighter rhythm. Don't
  apply landing-page spaciousness to a data table, or dashboard density to a
  hero section.
- **Alignment discipline**: pick one primary axis (usually a left edge or a
  center line) and keep elements honestly aligned to it — text, icons, and
  containers that are off by a few pixels from their neighbors is one of the
  fastest "amateur" signals.
- **Breathing room around the signature element**: whatever the page's one
  memorable moment is (see `frontend-design`), give it more surrounding
  space than anything else on the page — crowding it undercuts its impact.

## Deliverables

- **Spacing scale** — named tokens, base-unit derived, reused from existing project tokens where present.
- **Grid/structure** — columns, gutters, breakpoints, and what aligns to what.
- **Layout rationale** — why density/grouping choices fit this page's purpose, not a generic template.
- **Audit findings** (when reviewing) — arbitrary spacing values, unnecessary card-in-card nesting, misalignment, flagged with file:line.

## Sources

- Baymard Institute — e-commerce UX benchmarking (category navigation, product-list density, mobile layout research): baymard.com/research
- Laws of UX (proximity, Hick's Law, Fitts's Law as they apply to spatial grouping and layout): lawsofux.com
- Nielsen Norman Group — visual hierarchy and F-pattern/Z-pattern scanning research: nngroup.com
- 8-point grid system as a spacing-scale convention (widely used in production design systems, e.g. Material Design, Apple HIG)
