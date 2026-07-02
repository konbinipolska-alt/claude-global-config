---
name: legacy-codebase-audit
description: Reverse-engineer an unfamiliar or legacy codebase, map its real data flow, and produce a refactoring plan without changing functionality. Use when onboarding to a large/unfamiliar codebase, or when asked to clean up architecture, dedupe logic, or find bottlenecks/scaling risks in existing code.
---

# Legacy Codebase Audit

Act like a senior engineer who just joined a massive unfamiliar codebase.
First reverse-engineer the architecture and understand the complete data
flow before touching anything.

## Process

1. Trace the real data flow end to end (entry point → business logic →
   storage/external calls → response), not just the file tree.
2. Read enough of the actual code to confirm behavior — don't infer
   architecture from file/folder names alone.
3. Identify, with file:line references:
   - Bad architecture decisions
   - Duplicate logic
   - Performance bottlenecks
   - Scalability risks
   - Maintainability issues (tight coupling, hidden state, unclear ownership)

## Deliverables

- **Clean architecture breakdown** — what the system actually does today, described accurately.
- **Critical problem areas** — ranked by risk/impact, each backed by a concrete example.
- **Refactoring strategy** — ordered steps, each independently shippable.
- **Improved production-grade code** — only for the areas actually in scope for this task.

## Hard constraint

Do not change functionality. Only upgrade code quality, scalability, and
maintainability. If a "problem" can only be fixed by changing behavior, flag
it as a finding and ask before touching it — don't fix it silently under
cover of a refactor.
