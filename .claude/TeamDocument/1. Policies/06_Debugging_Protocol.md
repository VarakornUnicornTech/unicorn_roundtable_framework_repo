# §8 — Debugging Protocol

> **Policy reference file.** Loaded on-demand from `.claude/policies/`. Core rules live in CLAUDE.md.

**Applies to:** Any bug investigation in a pre-existing or complex subsystem where the root cause is not immediately obvious.

---

## The Instrument-First Rule

> **Never attempt a fix before you can see the system.** Add observability first. Fix second.

The correct order is always:
1. **Instrument** — add debug probes to the affected subsystem
2. **Observe** — reproduce the bug and read the output
3. **Hypothesize** — form a root cause theory from real data
4. **Fix** — implement the fix
5. **Verify** — confirm the fix with probes still in place, then remove them

Attempting Fix 1, Fix 2 blind (without observability) and only adding probes when stuck wastes investigation cycles. The probes must be the first code written, not the last resort.

---

## Debug Probe Standard (Option A — Build-First-Then-Remove)

- Probes use the simplest available in-band mechanism (e.g., `chatLog.addSystem("[DBG] ...")` for TUI, `console.error("[DBG] ...")` for server-side).
- All probe lines must be prefixed with `[DBG]` so they are trivially greppable.
- Probes are **temporary** — they are removed in the same commit that delivers the fix. Never ship `[DBG]` lines to production.
- The probe pattern and findings are documented in the BugFixes log under a `### Debug Instrumentation Session` heading before the ticket is closed.
- If the same subsystem is debugged again in the future, re-apply the same probe points (documented in the PreExisting TechStack file → Known Quirks / in the BugFixes log).

**Standard probe points to instrument first (adjust per subsystem):**
1. The entry filter (e.g., session key check, run ID check) — log what is being dropped and why
2. The branching decision (e.g., `maybeRefreshHistoryForRun` — which path is taken)
3. The async operation result (e.g., what `loadHistory` returned)

---

## Regression Gate for Bug Fixes (event pipelines and state machines)

After any fix that touches an event pipeline, state machine, or async flow:
- A **manual end-to-end smoke test checklist** must be completed before the ticket is closed.
- The checklist is written into the ticket's Acceptance Criteria section.
- The Verification Scholar signs off on the checklist, not just unit test results.
- If the pipeline cannot be tested automatically (e.g., requires a live external event like a Gmail push), the checklist must explicitly cover that scenario with manual steps.

---

## Side-Effect Scan (before removing or replacing any call)

Before removing, replacing, or refactoring any function call in a complex subsystem:
1. Grep for all callers of that function across the codebase.
2. For each caller: document what it was responsible for delivering.
3. Confirm the replacement covers all those responsibilities — or explicitly accept the regression and create a follow-up ticket.

This check must be documented in the PR/ticket notes. "I replaced X with Y" without a caller audit is a policy violation.

---

*Extracted from CLAUDE.md §8 — 11-03-2026*
