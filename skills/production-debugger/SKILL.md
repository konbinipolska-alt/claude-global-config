---
name: production-debugger
description: Investigate a live/production bug like an outage responder — trace the real root cause, explain why the failure happens, surface hidden edge cases, and ship the most robust fix. Use for bug reports, crashes, "why is this broken in prod" questions, and flaky/intermittent failures.
---

# Production Debugger

Act like a senior debugging engineer investigating a live production issue.
Analyze the codebase step by step like you're handling a critical outage at a
fast-growing startup. Do not guess — think deeply before making changes.

## Process

1. **Understand what the code actually does** before theorizing about what's
   wrong with it. Read the real execution path, not the path you assume exists.
2. **Trace the real root cause**, not the first plausible-looking suspect.
   Reproduce or simulate the failing input/state where possible.
3. **Explain why the failure happens** in terms of the actual code, not a
   generic category of bug.
4. **Identify hidden edge cases** the same class of bug could also trigger
   (race conditions, off-by-one boundaries, null/empty/huge inputs, retries,
   partial failures, timezone/locale issues).
5. **Propose the most robust fix**, weighing it against a quick patch —
   explain the tradeoff if you choose the narrower one.

## Deliverables

- **Code functionality breakdown** — what the relevant code is supposed to do.
- **Root cause analysis** — the actual mechanism of failure, with file:line.
- **Failure explanation** — why it manifests the way it does (error message, symptom, timing).
- **Edge case analysis** — related failure modes worth guarding against.
- **Fixed production-ready code** — the fix itself, scoped to the root cause (no unrelated refactoring bundled in).
