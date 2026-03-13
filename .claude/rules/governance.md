---
description: "Core governance rules: plan-before-implementation, no-code-before-ticket, phase gates, approval workflows"
globs:
  - "**/*"
---

# Governance Rules

## Plan-Before-Implementation (CRITICAL)
1. Create a plan document FIRST in the appropriate Development folder
2. Wait for explicit Commander confirmation before implementing
3. Never implement without approval — no matter how simple

## No-Code-Before-Ticket (ABSOLUTE)
No code change — not a single line — until its ticket exists in Development/.
Applies to ALL scenarios: live bugs, approved features, quick fixes, urgent issues.
Conductor must halt and create the ticket first. Violations logged with root cause.

## Phase Dispatch Report
Required before any team begins work. Conductor presents Phase Dispatch Report to Commander.
Format includes: Active Teams table, kickoff message templates, ZCB status.

## UX Smoke Test Gate (user-facing tickets)
Manual UX smoke test by Verification Scholar before marking Complete.
Happy path + at least one failure path. Results logged in ticket. FAIL blocks Complete.

## User Journey Walkthrough (before phase completion)
Full E2E walkthrough chaining ALL delivered tickets.
User actions only ("Click X" not "call handleX()"). Any FAIL blocks phase completion.

## Commander Phase Acceptance Gate (toggleable — OFF by default)
When Commander declares intent to test, no phase advance until COMMANDER-ACCEPTED.
Verdict: ACCEPTED (advance) or REJECTED (fix + re-test).

## Silent Failure = CRITICAL Bug
Any operation that fails silently (no error, no warning, no log, no user feedback) = CRITICAL severity.
Every failure MUST produce observable feedback. "Nothing happens" is never acceptable.

## Hotfix Regression Gate
Every bug fix MUST include a test case reproducing the original bug.
Test must fail before fix, pass after. Test is permanent — never deleted.

## Early Phase Advance — Commander Gate
Team completing all Phase N tickets may NOT advance to Phase N+1 on own initiative.
Must file OverseerReport, enter wait state, and wait for Commander's explicit authorization.
Conductor does NOT have this authority — only Commander does.

## Zero Cross-Team Block (ZCB) Guarantee — HARD RULE
No team may have a ticket blocked waiting on another team's output within same phase.
Conductor runs ZCB check before dispatching every phase briefing.
Any remaining cross-team block = design error — reassign ownership before dispatch.
