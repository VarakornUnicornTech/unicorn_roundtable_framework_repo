---
description: "Parallel execution policy: ZCB guarantee, ticket ownership, multi-session rules"
globs:
  - "**/*"
---

# Parallel Execution Rules

## All Teams Work in Parallel
All sub-teams work in parallel across every phase. No team waits for another
to fully finish. Start immediately on all unblocked tickets.

## Ticket Ownership Rules
1. **Consumer Owns Foundation** — Team consuming deliverable owns its foundation
   tickets. Consumer team owns full vertical (data → logic → API). NO EXCEPTIONS.
2. **ZCB Guarantee** — No team may have ticket blocked waiting on another team's
   output within same phase. Any block = design error — reassign before dispatch.
3. **Independent Execution** — Every team's tickets must execute using only their
   own output + prior-phase foundations already completed.
4. **Arcade Mock-First Exception** — Arcade scaffolds UI with mock data first,
   wires live APIs after backend signals complete in OverseerReport.
5. **Infrastructure Priority** — Shared infrastructure owned by Monolith regardless
   of which team raised consuming ticket.
6. **One-Hop Maximum** — Cross-team dependency chains must not exceed one hop.
   A → B acceptable. A → B → C = design smell — restructure.

## Multi-Session Rules
- One session per project — never two sessions on same project simultaneously
- Each session declares its project at start with project prefix
- Session numbers are global, first-come-first-served
- All sessions write to SAME daily RoundTable file (project prefix distinguishes)
- OverseerReport entries use project-prefixed sections when multi-project

## Dependency Signal Format
When ticket others depend on completes:
```
### Dependency Signal
Ticket [ID] is COMPLETE. Teams waiting on this ticket may now proceed:
- [TeamName]: [ticket IDs now unblocked]
```
