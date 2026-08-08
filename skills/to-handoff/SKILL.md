---
name: to-handoff
description: Turn a wayfinder map's decisions into a design handoff — a per-component spec sheet for the team building it — written to the repo and linked from the map.
disable-model-invocation: true
---

This is the terminus for design-engineering wayfinder maps: where dev maps exit toward `/to-spec`, a design-engineering map exits to a **handoff** — a spec sheet consumed by humans on another team, who were not in the room for any of the decisions.

The handoff is a **synthesis, not a session of decisions**. Every statement in it traces to a closed ticket on the map; when synthesis exposes a gap — a state nobody covered, a binding nobody chose — record it under **Open decisions** and move on. A handoff with honest gaps beats one padded with guesses.

The issue tracker should have been provided to you — run `/setup-matt-pocock-skills` if not.

## Process

1. **Load the map and check the frontier.** Fetch the map issue (`wayfinder:map`). Any still-open tickets go straight into **Open decisions** — the handoff can ship around them, but the reader must see them. Done when: every open child ticket is accounted for in Open decisions.

2. **Zoom every decision.** Fetch the full body and resolution comment of every ticket in the map's Decisions-so-far. Done when: every closed ticket is either reflected somewhere in the handoff or listed under **Coverage** with a one-line reason it isn't handoff-relevant (e.g. apparatus setup, scoping call).

3. **Inventory the components.** From the decisions, list every component and foundation (tokens, theming, breakpoints, motion) the handoff must cover. The map's `layer:system` tickets feed Foundations; `layer:surface` tickets feed the per-component sections.

4. **Write the handoff** using the template below, to `design/handoff/<destination-name>.md`. Use the project's domain glossary vocabulary throughout, and respect any ADRs in the area.

5. **Link the evidence.** Wherever a decision came from a prototype or apparatus, link it: the prototype's throwaway branch, the specimen page in `design/apparatus/`, the audit doc. The reader must be able to see what the decision was judged against, not just its conclusion.

6. **Publish.** Commit the handoff, post a comment on the map linking it as the destination reached, and close the map if nothing remains open. Done when: the map's reader can reach the handoff in one click.

## Template

<handoff-template>

# Handoff: <destination name>

Source: [<map name>](map-link). Decisions link to the tickets that hold their full context.

## Foundations

Token definitions and theming strategy, spacing/density scale, breakpoint strategy, motion timing and easing — each as a short statement of the decision plus a link to its ticket and to the durable doc (`design/tokens.*`) if one exists.

## Components

One section per component:

### <Component name>

- **Purpose** — one line: what it's for and where it appears.
- **Anatomy & variants** — the parts it's made of; which variants exist and the decision that fixed the boundary (one component with variants vs. several components).
- **States** — a matrix covering every state that applies: default, hover, focus, active, disabled, loading, empty, error, partial, offline. State explicitly which states do NOT apply, so absence reads as a decision rather than an oversight.
- **Token bindings** — which tokens drive its color, spacing, type, radius, elevation. Bind by token name, never by raw value.
- **Interaction** — behavior on input: click/tap, keyboard, drag, transitions between states, motion applied.
- **Accessibility** — the ARIA pattern chosen, focus order, contrast obligations, screen-reader behavior for each state.
- **Responsive** — behavior across the breakpoint strategy; what reflows, truncates, or hides.
- **Edge cases** — long content, RTL, zero/one/many, slow network — whatever the decisions surfaced.
- **Evidence** — links to the prototype branch and/or specimen page this was judged against.

## Open decisions

Gaps the handoff ships around: still-open tickets and anything synthesis exposed as undecided. Each entry: the question, why it's open, and its ticket (create one if it has none — an open decision with no ticket is invisible).

## Out of scope

Mirrors the map's Out of scope section: what was consciously ruled beyond this destination, so the reader knows it was excluded rather than missed.

## Coverage

One line per closed ticket that is *not* reflected above, with why — the reader's proof that the handoff digested the whole map.

</handoff-template>
