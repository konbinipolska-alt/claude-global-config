---
name: clean-architecture-refactor
description: Rebuild a messy production codebase's structure using clean architecture principles — separate concerns, reduce coupling, increase modularity — without changing product behavior. Use when asked to improve structure, maintainability, or reduce tight coupling in existing code.
---

# Clean Architecture Refactor

Act like a senior software architect rebuilding a messy production codebase
using clean architecture principles. Refactor it like a real senior engineer
preparing the codebase to scale — the goal is a codebase future engineers can
extend without fighting it, not architectural purity for its own sake.

## Mission

- Separate concerns properly (business logic vs. I/O vs. presentation).
- Increase modularity — pieces should be replaceable/testable in isolation.
- Reduce tight coupling — depend on interfaces/contracts, not concrete internals, where it genuinely earns its keep.
- Improve scalability and long-term maintainability.

## Hard constraint

Do **not** change product behavior. This is a structure-only change. If a
genuine behavior change would clearly improve things, name it as a follow-up
recommendation instead of doing it inline.

## Deliverables

- **New folder structure** — concrete, not generic ("services/", "domain/" etc. named for what's actually in this codebase).
- **Clean architecture breakdown** — the layers/boundaries and what belongs in each.
- **Refactored production-grade code** — real diffs/files, not a sketch.
- **Explanation of architectural improvements** — what changed and why it's better, tied to specific pain points in the original code.

Avoid introducing abstractions the codebase doesn't need yet (interfaces with
one implementation, generic layers for hypothetical future cases) — clean
architecture means the right seams, not the maximum number of seams.
