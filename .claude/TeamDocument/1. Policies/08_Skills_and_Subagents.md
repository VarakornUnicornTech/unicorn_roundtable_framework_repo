# §8 — Skills & Subagents Standard

## Skills (Custom Slash Commands)

Skills are prompt templates in `.claude/skills/[name]/SKILL.md` invoked with `/name`. Each skill expands into a full structured prompt that Claude executes.

### Available Skills

| Command | File | Purpose |
|---------|------|---------|
| `/compact-resume` | `skills/compact-resume/SKILL.md` | Post-compact re-orientation |
| `/team-start` | `skills/team-start/SKILL.md` | Formal team kickoff |
| `/phase-status` | `skills/phase-status/SKILL.md` | Phase + ticket status report |
| `/audit` | `skills/audit/SKILL.md` | End-to-end user flow audit |
| `/zcb-check` | `skills/zcb-check/SKILL.md` | Zero Cross-Team Block validation |
| `/l3-scan` | `skills/l3-scan/SKILL.md` | L3 full code scan |
| `/overseer-report` | `skills/overseer-report/SKILL.md` | File OverseerReport entry |
| `/template` | `skills/template/SKILL.md` | Framework version management |
| `/Overseer` | `skills/Overseer/SKILL.md` | Persona switch to Overseer |
| `/Monolith` | `skills/Monolith/SKILL.md` | Persona switch to Monolith |
| `/Syndicate` | `skills/Syndicate/SKILL.md` | Persona switch to Syndicate |
| `/Arcade` | `skills/Arcade/SKILL.md` | Persona switch to Arcade |
| `/Cipher` | `skills/Cipher/SKILL.md` | Persona switch to Cipher |

### Granularity Rule
Skills should map to **discrete operations** that are explicitly invoked, not to steps that CLAUDE.md rules already enforce automatically. Do not create skills for actions that should be automatic (e.g., SESSION START logging — that is enforced by CLAUDE.md, not a skill).

---

## AM Orchestration Modes

### Mode A — AM Direct Orchestration (DEFAULT)

Commander gives AM a goal. AM handles all coordination internally:

1. AM presents COO Vision Gate Execution Plan to Commander and waits for approval
2. AM spawns each sub-team as a subagent using the Agent tool, passing:
   - The team's agent file content (`.claude/agents/[team].md`)
   - The Phase Briefing Mail
   - Commander's constraints from the Vision Gate
3. AM receives each team's output
4. AM files OverseerReport
5. AM presents the consolidated result to Commander

Commander gives one instruction, receives one report.

### Mode B — Separate Sessions (opt-in)

Commander opens a **separate Claude session** per team. Commander pastes the relevant `agents/[team].md` content manually at the session start to bootstrap the team persona.

**When to use Mode B:**
- Commander wants live visibility into a team's reasoning
- Exploratory or uncertain work where course correction is expected
- When AM orchestration overhead is not warranted for a simple single-team task

**How Commander activates Mode B:**
1. Open a new Claude Code session
2. Paste the full contents of `.claude/agents/[team].md` at the start of the conversation
3. The team self-initializes from the agent definition
4. Commander interacts directly with that team

---

## Subagent Standard

### Trigger Conditions

A Conductor MUST use a subagent (not inline execution) when:
- Work spans more than one team's domain
- A task will consume significant context that should be isolated
- Parallel team execution is required (Mode A dispatch)

### Pre-Flight Declaration (MANDATORY)

Before spawning any subagent, the Conductor must declare:

```
[SUBAGENT PRE-FLIGHT]
Team: [Team Name]
Agent file: .claude/agents/[team].md
Briefing: [Phase N Briefing path]
Scope: [ticket IDs or task description]
Commander constraints: [from Vision Gate or direct instruction]
```

### AM Orchestration Prompt Format (Mode A)

When AM spawns a sub-team subagent, the prompt must include:

```
[SUBAGENT] Team [Name] — Phase [N] Execution

You are Team [Name] of the RoundTable organization. Read your agent file to adopt your full identity and voice.

Agent file: .claude/agents/[team].md
Briefing: [path to Phase Briefing Mail]
Tickets: [ticket IDs assigned to this team]
Commander constraints: [from Vision Gate]

Initialize per your Mandatory Initialization sequence, then execute your tickets.
File OverseerReport entries as tickets complete. Return your final OverseerReport summary to AM when all tickets are done.
```

### `/team-start` Dual-Use

The `/team-start` skill may be invoked by:
- **Commander directly** (Mode B) — to formally kick off a team session
- **AM internally** (Mode A) — as part of each subagent's initialization before dispatch

---

## COO Vision Gate (MANDATORY — Mode A)

Before AM spawns any subagents for phase execution, AM MUST present and receive explicit Commander approval:

```markdown
## Phase [N] Execution Plan — [ProjectName]
Mode: A — AM Direct Orchestration

| Team      | Tickets       | Scope   |
|-----------|---------------|---------|
| Monolith  | MON-01–MON-XX | [brief] |
| Syndicate | SYN-01–SYN-XX | [brief] |
| Arcade    | ARC-01–ARC-XX | [brief] |

Your vision / constraints to pass to teams?
Approve to proceed.
```

Commander either adds direction or approves. AM incorporates Commander's input into each team's kickoff prompt before spawning.
