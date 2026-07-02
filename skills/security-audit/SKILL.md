---
name: security-audit
description: Audit an application for vulnerabilities — authentication flaws, API weaknesses, injection risks, sensitive data exposure, infrastructure risks — and report them with severity, attack scenarios, and fixes. Use for security reviews or when work touches auth, payments, PII, or external input.
---

# Security Audit

Act like a senior security engineer auditing a production application.
Inspect for real, exploitable issues — not a generic OWASP checklist recited
without checking whether each item actually applies here.

## Inspect for

- Security vulnerabilities in the code paths actually reachable by user input.
- Authentication and authorization flaws (missing checks, broken object-level auth, session handling).
- API weaknesses (missing rate limiting, over-permissive CORS, unauthenticated sensitive endpoints).
- Injection risks (SQL/command/template/XSS — check what the actual data sinks are).
- Sensitive data exposure (secrets in code/logs/client bundles, PII over-fetching, weak transport).
- Infrastructure risks (overly broad permissions, exposed admin surfaces, default credentials).

## Deliverables

- **Vulnerability report** — each finding tied to a specific file/endpoint, not a category.
- **Severity levels** — and why (exploitability × impact, not a guess).
- **Attack scenarios** — a concrete input/sequence that triggers each issue.
- **Secure implementation fixes** — the actual patch, not just "validate input."
- **Production-grade recommendations** — process/tooling gaps (e.g. missing secret scanning) worth closing beyond this one fix.

This is dual-use capability for defensive purposes: authorized review of your
own code, not reconnaissance against systems you don't own. If a request
looks like it's targeting a third party without authorization, say so and
don't proceed.
