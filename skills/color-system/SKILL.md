---
name: color-system
description: Build or audit a color system — palette construction, semantic tokens, and WCAG contrast — instead of defaulting to the generic purple-to-blue AI gradient. Use when a design needs a real color palette/token system, or when reviewing existing color usage for consistency and accessibility.
---

# Color System

Color is a system with roles, not a palette of favorites. Every color in a
production UI should trace back to a token with a defined job — decorative
colors picked because they "look nice together" are how inconsistency and
accessibility failures both creep in.

## Avoid the default

The most common AI-generated color tell is a **purple-to-blue gradient
accent on a white or near-black background**, applied regardless of subject
or brand. It's not wrong on its own, but it's the average of the training
data, not a decision. Derive the palette from the actual brief: the
subject's world, the brand's existing marks, or the emotional register the
product needs (trustworthy/clinical vs. warm/artisanal vs. energetic/loud)
— then pick hues that serve that, even if that means restraint (near-mono)
or an unexpected accent.

## Build the system

- **Roles before hues**: define what needs a color before choosing which —
  typically: background (base + raised surface), foreground/text (primary +
  muted), border, primary brand/accent, and semantic states (success,
  warning, danger, info). Everything else is a variant of these.
- **Named palette, not inline hex**: 4–8 named colors is usually enough for
  a full system once tints/shades are derived programmatically (HSL
  lightness steps or an existing scale generator) rather than hand-picked
  per component.
- **60-30-10 as a starting ratio**: one dominant neutral (60%), one
  secondary/surface color (30%), one accent used sparingly (10%) — accent
  colors lose all impact when they're everywhere.
- **Check for existing tokens first**: never hardcode a hex value that
  already exists as a design token in the project — extend the token system
  instead of creating a parallel one.
- **Dark mode is a mapping, not a repaint**: if the project supports it,
  design token *roles* once and remap values per theme, don't hand-tune
  every component twice.

## Accessibility is not optional

- Text vs. background: **WCAG AA minimum** — 4.5:1 for normal text, 3:1 for
  large text (18px+ bold or 24px+ regular). Aim for AAA (7:1) on primary
  reading content where feasible.
- Non-text UI (icons, borders that convey meaning, focus indicators): 3:1
  minimum against adjacent colors.
- Never encode meaning in color alone (error state, required field, chart
  series) — pair with an icon, label, or pattern for colorblind users (~8%
  of men have some form of color vision deficiency).
- Check contrast for every semantic state color against both light and dark
  surfaces it will actually appear on, not just against white.

## Deliverables

- **Palette** — named hex values by role, with the rationale tying each to the brief.
- **Token mapping** — how roles map to actual CSS custom properties/theme values, reusing what the project already has.
- **Contrast audit** — pass/fail against WCAG AA for every text/background and semantic-state pairing actually used.
- **Dark mode mapping** (if applicable) — role-to-value remap, not a second hand-authored palette.

## Sources

- WCAG 2.2 (W3C) — Success Criterion 1.4.3 (contrast minimum) and 1.4.11 (non-text contrast): w3.org/WAI/WCAG22/quickref
- Refactoring UI (Adam Wathan & Steve Schoger) — palette construction, tint/shade derivation, and restraint in accent-color usage
- Baymard Institute — color/contrast findings from e-commerce usability testing (product imagery, price/CTA legibility): baymard.com/research
