# The Master Audit

Map the app, then run the audit suite and combine the findings into one short, high-confidence plan.

## Pick a mode

Before starting, ask the user which mode they want:

- **Normal:** Runs a full audit across the whole codebase. Takes a bit of time and isn't cheap, but it's good enough for most cases.
- **Deep:** Runs 3x targeted master audits in parallel - one per part of the app (e.g. frontend, backend, etc). Significantly slower and over 3x the cost. Occasionally finds things Normal misses.

## Before you start

Once they've picked a mode, confirm cost before kicking off:

> "Master audits use significant cost or subscription usage and take some time. Are you sure you'd like to run it now? Answer **YES** to continue."

Look for an explicit YES, even if they asked for a Master audit explicitly.

## Run

### 1. Architecture audit (synchronous, both modes)

Run [The Architecture Audit](architecture-audit.md) once and wait for it to finish. This is required for the next steps.

Capture the key outputs (entry points, main flows, hot files, risky areas) so they can be passed as shared context to the next step.

### 2. Spawn sub-agent(s)

**Normal mode:** Spawn 1 master audit sub-agent. It runs ALL four audits sequentially across the whole app, in a synchronous sub-agent. NO SUBAGENT RECURSION!

Run in order:

- [The Duplicate Audit](duplicate-audit.md)
- [The Fail-Fast Audit](fail-fast-audit.md)
- [The Bloat Audit](bloat-audit.md)
- [The Retry Audit](retry-audit.md)

**Deep mode:** Once the architecture audit is done, pick 3 parts of the app that fit this codebase, based on what the architecture audit revealed. Common splits:

- `frontend` / `backend` / `other`
- `client` / `server` / `other`
- `app` / `infra` / `other`
- `web` / `api` / `other`

Pick the three largest or most mission-critical parts and one other to cover everything else. Provide the agents with **light direction** and let them explore freely, in read-only mode. Always include `other` as the catch-all so nothing falls through.

Then dispatch 3 specialist sub-agents in parallel - one per part. Each specialist runs ALL four audits, scoped to its part. NO SUBAGENT RECURSION!

- Specialist A → its part → [Duplicate](duplicate-audit.md), [Fail-Fast](fail-fast-audit.md), [Bloat](bloat-audit.md), [Retry](retry-audit.md)
- Specialist B → its part → [Duplicate](duplicate-audit.md), [Fail-Fast](fail-fast-audit.md), [Bloat](bloat-audit.md), [Retry](retry-audit.md)
- Specialist C → its part → [Duplicate](duplicate-audit.md), [Fail-Fast](fail-fast-audit.md), [Bloat](bloat-audit.md), [Retry](retry-audit.md)

Pass each specialist:
- The architecture audit output (entry points, main flows, hot files, risky areas), so they don't re-map the app entirely.
- Their assigned part and a clear scope (paths/dirs that belong to it). The catch-all specialist owns everything not claimed by the other parts.

In both modes, sub-agents research aggressively. Don't re-explain the audits to them.

### 3. Combine findings

Wait for all sub-agents to return. Merge their findings.

If the same issue shows up in two different audits (e.g. a duplicate that's also bloat), pick the strongest framing and deduplicate.

In Deep mode, also watch for duplicates that span multiple parts (e.g. the same constant defined in frontend AND backend) - those are usually high-impact.

Score each finding's **impact (1-10)** based on real-world consequence:

- **10** → critical (silent revenue loss, broken core flow, security risk)
- **7-9** → major impact (preventing customer-facing bugs, hours saved, big code reduction)
- **4-6** → meaningful improvement, worth doing
- **1-3** → minor cleanup, small win

Aim for a minimal, surgical plan: the biggest impact with the smallest, safest code change. Sort findings by impact, highest first.

### 4. Output

Three sections, in this order:

```
# Executive Summary

[Two short sentences. The current state of the codebase and the single biggest opportunity.]

# Executive To-Do

- [ ] **[Action headline]:** [one short sentence on what it does]
- [ ] **[Action headline]:** [one short sentence on what it does]
- [ ] **[Action headline]:** [one short sentence on what it does]

# The Plan

For each to-do item, in the same order:

## [Action headline]

- **What it is:** [plain language, 1-2 sentences]
- **Why it matters:** [in human terms, what would actually go wrong or improve]
- **Impact:** [1-10]
- **Files involved:** [paths as references at the end]
```

## Rules

- Always ask Normal vs Deep, then confirm cost/time before running. Require an explicit YES.
- Architecture audit is always synchronous and goes first. Pass its output to the next stage.
- Normal = 1 generalist sub-agent runs all 4 audits sequentially across the whole app.
- Deep = 3 specialist sub-agents in parallel, each running all 4 audits but scoped to a different part (e.g. frontend / backend / other). Always include `other` as a catch-all.
- Score each finding by impact 1-10 based on real-world consequence. Sort highest first.
- Keep the summary and to-do brutally short. Detail goes at the bottom only.
- Minimal, surgical fixes.
- Plain English throughout. A non-engineer should be able to act on this.
- Don't auto-apply anything. The output is a proposal.
