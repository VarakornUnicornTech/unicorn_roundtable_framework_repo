---
description: "Session logging, RoundTable format, rotation, OverseerReport, handover protocol"
globs:
  - "**/*"
---

# Logging Rules

## Session Start (NON-NEGOTIABLE)
Conductor must open/append to daily RoundTable file and write `## Session [N] — [Title]`
BEFORE responding to any prompt. No exceptions. No minimum complexity threshold.

## Per-Interaction Logging
Every prompt + response = one logged session entry. No exceptions for "quick answers."

## All-Voices Rule
All team members may speak in a session. Each uses their own voice.
Conductor does not speak for others. Selective Response Rule: members speak
only when topic is within their field.

## RoundTable Rotation
- Format: `DD-MM-YYYY_RoundTable_Vol[N].md`
- Soft limit: 400 lines — wrap up at next session boundary
- Hard limit: 500 lines — MUST start new volume immediately
- Every new volume includes Context Overlay block at top
- Update `_Index.md` when new volume created

## Sub-Team Logging
Sub-teams log in TeamChat, NOT RoundTable. Only Overseer writes to RoundTable.
Team Chat: `TeamDocument/2. TeamChat/[N. TeamName]/DD-MM-YYYY_[TeamName].md`
OverseerReport: `TeamDocument/2. TeamChat/4. OverseerReport/DD-MM-YYYY_OverseerReport.md`

## OverseerReport Entry Format
Summary, Acceptance Criteria (all checkboxes), Blockers, Next Step for Conductor.
Filed by sub-team Conductor, verified by Verification Scholar.

## HandOver File Standard
Cross-team handovers: `[NUMBER]. [REFER_TEAM_NAME]_[WORK_TITLE]_DD-MM-YYYY.md`
Mandatory sections: What Was Done, What Remains, Files Modified, Blockers/Risks, Notes.
HandOver files are never deleted — they form the cross-team audit trail.

## Best Option Rule
Always recommend the best solution — not the quickest or most convenient.
Shortcuts flagged as Technical Debt and require Commander sign-off.
