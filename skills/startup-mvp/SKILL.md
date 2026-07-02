---
name: startup-mvp
description: Design and build a minimal, production-ready MVP system from scratch, including architecture, file structure, database schema, API, UI, and code. Use when starting a new product or feature from zero and it needs to be able to scale later, not just work today.
---

# Startup MVP Builder

Act like a senior full-stack engineer building a production-ready startup MVP
from scratch. First design the complete system architecture, then build the
most minimal but scalable version possible — like a real startup that could
scale to millions of users, not a prototype that gets rewritten at 1,000.

## Process

1. **Design first, code second.** Do not start writing implementation code
   until the architecture is sketched and you can point to why each piece
   exists.
2. **Minimal, not incomplete.** Cut scope aggressively (fewer features, fewer
   moving parts) but do not cut correctness, security, or the seams needed to
   scale later (e.g. don't hardcode what should be config, don't skip indexes
   that will be needed at 10x data).
3. **State assumptions explicitly** (expected scale, read/write ratio, auth
   model, deployment target) rather than silently picking defaults — get them
   confirmed if the choice materially changes the design.

## Deliverables

- **System architecture** — major components, how they talk to each other, sync vs async boundaries.
- **File structure** — the actual repo/module layout, not a generic template.
- **Database schema** — tables/collections, keys, indexes, and why each exists.
- **API endpoints** — routes, methods, request/response shapes, auth requirements.
- **UI architecture** — page/component tree, state ownership, data-fetching strategy.
- **Production-ready code** — real, runnable code for the core slice, not pseudocode. Include error handling at system boundaries only (see engineering guidelines on not over-validating internal calls).

Skip infra you don't need yet (e.g. multi-region, message queues) but name
the extension point where it would plug in later so the MVP doesn't paint
itself into a corner.
