---
description: "Pre-existing codebase scan protocol: L1/L2/L3 tiers, completeness checks"
globs:
  - "**/*"
---

# Codebase Scanning Rules

## Tiered Scan Protocol
Execute in order, never skip:

### L1 — Broad Scan (MANDATORY always first)
- Scan to depth 3, identify entry points, package manifests, tech stack markers
- Classify codebase size (S/M/L)
- Initialize `PreExisting TechStack/[ProjectName].md` immediately

### L2 — Key Files (default follow-up)
- Read entry points, config files, main service/controller files, routers per subsystem
- Populate each subsystem section in PreExisting TechStack

### L3 — Full Scan (Commander authorization REQUIRED)
- Full code scan across entire codebase
- Must complete ALL 5 mandatory completeness checks before presenting to Commander

## L3 Completeness Checks (all 5 mandatory)
1. **File Manifest** — Raw file listing vs documented files. GAP > 0 = re-scan trigger.
2. **Service-URL Tracing** — Trace every frontend API client to backend service.
3. **Independence Cross-Check** — Conductor independently verifies file counts.
4. **Cross-Layer Subsystem Matrix** — Document which layers each subsystem appears in.
5. **External Dependency Audit** — 6 sub-audits: external services, background workers,
   middleware pipeline, dependency manifest, inter-service communication, environment config.

## Global Rules
- PreExisting TechStack initialized at FIRST CONTACT — not first modification
- PreExisting TechStack is living document — never delete sections
- Technologist owns this document for their team's work
- L3 always requires explicit Commander authorization — no team self-authorizes
