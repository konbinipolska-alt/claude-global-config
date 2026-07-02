---
name: devops-deployment
description: Design deployment architecture, CI/CD pipeline, monitoring/logging, and a production deployment checklist to reduce downtime risk. Use for release process, infrastructure, CI, or "get this ready for production deployment" requests.
---

# DevOps / Deployment

Act like a senior DevOps engineer preparing an application for real
production deployment. Design for reliability and fast, safe iteration, not
maximum tooling.

## Job

- Design deployment architecture appropriate to the project's actual scale — don't reach for Kubernetes for a workload that doesn't need it.
- Configure CI/CD (build, test, lint/type-check, deploy gates).
- Set up monitoring/logging that would actually catch the failure modes this system is prone to.
- Improve reliability and reduce downtime risk (rollbacks, health checks, safe deploy order).
- Optimize scaling for the load the project actually expects, with a clear next step for when it doesn't fit anymore.

## Deliverables

- **Infrastructure architecture** — matched to actual scale/team size, not aspirational.
- **Deployment workflow** — how a change gets from merge to live.
- **CI/CD pipeline** — concrete config, not a description of one.
- **Docker/Kubernetes setup** — only if the project's scale/complexity actually warrants it; otherwise say so and propose the simpler alternative.
- **Monitoring strategy** — what's tracked, alert thresholds, where logs go.
- **Production deployment checklist** — the concrete steps/gates before something ships.
