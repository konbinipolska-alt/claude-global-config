---
name: explore-variants
description: Resolve a comparative design-system decision — token set, spacing/density scale, motion timing, theming, breakpoint strategy — by rendering candidate options against one fixed specimen and judging them side by side. Use when a wayfinder prototype ticket's question is a system axis rather than a page design, or when the user wants to compare design options they can only judge by looking.
---

# Explore Variants

Some design decisions can't be settled on paper because the answer space is combinatorial and the judgment is comparative: a spacing scale, a motion curve, a token palette only reveal themselves next to their rivals, applied to real content. This skill resolves such a decision by building a **sweep** — one fixed **specimen**, several **candidates**, toggled side by side.

It differs from `/prototype`'s UI branch in what varies: a UI prototype varies the *design* of one route; a sweep holds the design fixed and varies one **axis** of the system beneath it. Getting this wrong wastes the exploration — if the candidates are different layouts, use `/prototype`; if they can't be rendered at all (naming, component boundaries), the decision is a `/grilling`, not a sweep.

The human judges; the agent builds. A sweep that picks its own winner has answered nothing — the verdict only exists once a human has flipped through the candidates and said which one (or which combination) wins.

## Process

1. **Name the axis.** One dimension per sweep — the spacing scale OR the type scale, never both, or the comparison stops being readable: with two axes varying, the human can't tell which one caused what they're seeing. If the ticket's question spans multiple axes, sweep the most upstream one first and ticket the rest. Done when: the axis is stated in one line at the top of the sweep.

2. **Draft the candidates.** 2–5 complete, coherent options — each a full setting of the axis someone could actually adopt, not a grid of permutations. Ground them in the map's decisions so far and any constraints in its Notes. Name each candidate memorably (names survive into the verdict; "option 3" doesn't). Done when: each candidate is a named, complete value-set for the axis.

3. **Fix the specimen.** The surface the candidates render against, identical across all of them. Reuse existing apparatus (`design/apparatus/`) when it shows the contexts where the axis matters; build a minimal specimen otherwise — dense and sparse regions for a spacing sweep, interactive elements for a motion sweep, every semantic color role for a palette sweep. Done when: the specimen exercises every context in which the candidates visibly differ.

4. **Wire the toggle.** Candidates switch via a URL search param and a floating bottom bar (upstream `/prototype` UI conventions). Each candidate applies as a swap of the axis's values — a CSS-variable set, a config object — over the shared specimen, never a fork of its markup. The bar surfaces the active candidate's name *and its raw values*, so every screenshot is self-documenting. One command to run; no persistence; no polish beyond runnable.

5. **Judge side by side.** Walk the human through the candidates and capture reactions per candidate, not just a final pick — a winner often steals values from a runner-up, and the losers' *why* is what makes the decision durable. Done when: the human has named a verdict — a winning candidate, possibly amended.

6. **Capture and close.** The verdict and its reasoning go into the ticket's resolution comment. The winning values are extracted into their durable home (`design/tokens.*` or the relevant `design/` doc). The sweep code follows the prototype durability contract: committed to a throwaway branch out of main, linked from the ticket as the primary source the decision was judged against. Done when: the decision is readable without running anything, and the sweep is reachable from the ticket.

## Fit test

A sweep fits when all three hold:

- **One axis** — a single system dimension is in question.
- **Renderable candidates** — the options differ visibly on a screen.
- **Comparative judgment** — the question is "which of these," answered by looking, not by argument.

Token sets, spacing and density scales, motion timing and easing, theming strategies, breakpoint strategies, type scales, elevation/radius systems all pass. Component API naming and boundary questions fail the second test — route those to `/grilling`.
