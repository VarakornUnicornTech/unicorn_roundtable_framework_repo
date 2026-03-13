---
description: "Debugging protocol: instrument-first rule, probe management, cross-layer tracing, gap bug detection"
globs:
  - "**/*.ts"
  - "**/*.js"
  - "**/*.py"
  - "**/*.go"
  - "**/*.rs"
  - "**/*.java"
---

# Debugging Rules

## Instrument-First Rule (NON-NEGOTIABLE)
Never attempt a fix before you can see the system. Add observability first.
Order: Instrument → Observe → Hypothesize → Fix → Verify.

## RELEASE Projects — Remove-on-Fix Probes
- All probe lines prefixed `[DBG]` (trivially greppable)
- Probes removed in same commit as the fix
- Never ship `[DBG]` lines to production

## INDEV Projects — Persistent Toggleable Probes
- Debug probes are PERSISTENT — NOT removed per-fix
- Gated behind runtime toggle (`DEBUG_MODE` env var or equivalent setting)
- Mandatory coverage: message handlers, route handlers, state transitions,
  event listeners, error paths
- Stripped only on RELEASE transition via dedicated cleanup ticket

## Cross-Layer Trace Rule
When any interface contract changes (API signature, message payload, auth, state):
- Trace ALL consumers across ALL components
- Verify each consumer still works with new contract
- Both sides of any interface change ship together
- Violation = CRITICAL bug (consumer breaking silently)

## Gap Bug Detection
For every "X doesn't work" or "nothing happens when Y":
1. Trace expected path — write exact sequence of calls that SHOULD happen
2. Find gap — walk sequence, find where chain breaks
3. Check for silent returns — `if (!x) return;` without feedback = gap bug
4. Gap bugs cannot be found by instrumenting existing code — found by mapping
   what should exist vs what does

## Environment Verification Gate
Before debugging session involving running process:
- Source ↔ Binary match (check build timestamps)
- Environment check (required env vars set)
- Single instance (only one process running)

## Rewrite Threshold
Flag for rewrite (not more fixes) when ANY hit:
- 5+ bugs in single file in one audit pass
- Fix-creates-bug rate exceeds 2x in same subsystem
- 3+ rounds of fixes without resolving core issue
- Single file exceeds 1000 lines with mixed concerns
