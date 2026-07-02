---
name: motion-design
description: Design and audit purposeful UI motion — timing, easing, choreography, and micro-interactions grounded in classical animation principles, not decorative AI-slop animation. Use when adding animation/transitions to a UI, or when asked to review whether existing motion feels intentional vs. gratuitous.
---

# Motion Design

Act like a motion director, not someone sprinkling `transition: all 0.3s` on
every element. Every animation must answer "what is this movement
communicating?" — state change, causality, spatial relationship, or focus.
If the honest answer is "it looks cool," cut it or fold it into the one
signature moment the page is allowed to have (see `frontend-design`).

## Grounding: classical principles, adapted for UI

Borrow from Disney's 12 principles of animation where they map to interface
motion — not literally, but as the underlying physics of "movement that
feels alive":

- **Timing & spacing** — duration and easing curve carry emotional weight.
  Fast + linear reads as mechanical; fast + ease-out reads as responsive;
  slow + ease-in-out reads as deliberate/heavy. Pick the curve for what the
  action *is*, not a house default applied everywhere.
- **Anticipation** — a small pre-movement (compress before expand, dim before
  navigate) makes the main motion legible instead of abrupt.
- **Follow-through & overlap** — elements with different mass shouldn't
  start/stop in perfect unison; a trailing element settling slightly after
  the lead one reads as physical, not robotic.
- **Staging** — one thing moves at a time, or moves most; don't animate five
  properties on ten elements simultaneously and call it "delightful."
- **Exaggeration, in restraint** — UI needs far less than character
  animation. A hint of overshoot on a spring is often enough; full bounce is
  rarely appropriate outside playful brands.
- **Arcs** — natural motion curves rather than snapping in straight lines,
  especially for anything simulating physical movement (drag, reorder).

## Practical rules

- **Respond to real state changes**: loading → loaded, closed → open,
  error → resolved, item added → item present. Motion illustrates a state
  machine transition, not a static screen's mood.
- **Duration budget**: micro-interactions (hover, toggle) 100–200ms;
  transitions (panel, modal, route) 200–400ms; anything longer needs a
  specific justification (onboarding moment, hero load).
- **One choreography, not simultaneous chaos**: stagger children with a small
  offset (30–60ms) rather than firing every card's fade-in at once — but
  don't stagger-spam a list of 50 items into a 2-second wait.
- **Respect `prefers-reduced-motion`** always — provide an instant/cross-fade
  fallback, never just disable functionality.
- **Hover states earn their motion**: a hover effect should reflect
  affordance (this is clickable, this reorders, this reveals more), not be
  applied uniformly to every card "because it feels alive."

## Anti-patterns to flag on audit (AI-slop motion tells)

- Hover-scale applied to literally every card/button on the page.
- Pulsing/breathing dots or glows with no status meaning attached.
- Stagger-spam: every list, regardless of length or context, fades in item
  by item.
- Parallax or scroll-reveal on content that has no spatial depth to justify it.
- Uniform `all` transitions on every element regardless of what's changing.
- Animation duration/easing that's identical across completely different
  interaction types (a modal close and a button hover using the same 300ms
  ease curve).

## Deliverables

- **Motion map** — which state changes/interactions get motion and why; what deliberately gets none.
- **Timing/easing spec** — concrete durations and curves per interaction category.
- **Implementation** — using whatever the project already uses (CSS transitions/animations, or an existing animation library) rather than introducing a new dependency for one effect.
- **Audit findings** (when reviewing existing UI) — anti-pattern hits with file:line, and what to cut vs. what to keep.

## Sources

- Frank Thomas & Ollie Johnston, *The Illusion of Life: Disney Animation* (1981) — origin of the 12 principles of animation
- Material Design motion guidelines (Google) — easing curves, duration scale, choreography for UI specifically: m3.material.io/styles/motion
- Val Head, *Designing Interface Animation* (Rosenfeld Media) — UI-specific application of animation principles
