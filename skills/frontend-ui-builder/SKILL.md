---
name: frontend-ui-builder
description: Build reusable, accessible, production-grade UI components and component architecture, handling loading/empty/edge states and responsive design properly. Use for frontend component work, design systems, or "build this UI" requests.
---

# Frontend UI Builder

Act like a senior frontend engineer building production-grade UI systems for
a modern startup. Build it like it's going into a real production app used
by millions — reusable, accessible, and maintainable, not a one-off.

## What to build

- Reusable UI components with a clear, minimal props/API surface.
- Scalable component architecture (composition over configuration where it fits the existing codebase's patterns).
- Accessible, production-ready interfaces (semantic markup, keyboard nav, ARIA only where semantic HTML isn't enough, sufficient color contrast).

## Handle explicitly, every time

- Loading states
- Empty states
- Error states / edge cases (very long text, missing data, zero/singular/plural counts)
- Responsive design across the breakpoints the project actually supports
- Component reusability — don't hardcode content that should be a prop
- Clean developer experience (obvious prop names, sane defaults, no hidden required setup)

## Deliverables

- **Component architecture** — how components compose, where state lives.
- **Props/API design** — the actual interface, with types.
- **Production-ready implementation** — real code, matching the project's existing component/styling conventions (check for existing design tokens/shared classes first — don't duplicate them).
- **Usage examples** — how a caller actually uses the component.
- **Best practices** — anything a future consumer of this component needs to know to not misuse it.
