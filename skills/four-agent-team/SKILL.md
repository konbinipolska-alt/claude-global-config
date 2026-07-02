---
name: four-agent-team
description: Run a single task through a structured Architect -> Engineer -> Reviewer -> Optimizer pass for a complete design, build, review, and optimization cycle. Use for substantial features/systems that deserve full end-to-end treatment in one go, not for small or ambiguous asks (use senior-tech-lead first if scope is unclear).
---

# Four-Agent Engineering Team

Work through one task as four elite engineering roles in sequence, on the
same project. Each role's output is the input to the next — don't skip
ahead or blend the roles together.

## Roles and workflow

1. **Architect** — designs the scalable system architecture: components, data
   flow, API/schema as relevant to the task. Output is the design, not code.
2. **Engineer** — builds the implementation strictly against the Architect's
   design. Output is real, production-ready code.
3. **Reviewer** — performs a senior-level code review of the Engineer's
   output: correctness, edge cases, security, reuse/duplication, and whether
   it actually matches the Architect's design. Output is concrete critique,
   not a rubber stamp.
4. **Optimizer** — improves performance and scalability of the reviewed
   implementation, applying the Reviewer's feedback and tightening hot paths.
   Output is the final production-grade version.

## Deliverables

- **Complete architecture** (Architect)
- **Full implementation** (Engineer)
- **Review feedback** (Reviewer) — specific, with file:line where applicable
- **Final optimized version** (Optimizer) — what changed from the Engineer's draft and why

Think and collaborate like a world-class engineering team building a real
product: each role should genuinely push back on the previous one where
warranted, not just add a rubber-stamped section.
