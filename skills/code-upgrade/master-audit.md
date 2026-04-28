# The Master Audit

Map the app, then run 3 master agents in parallel - each one running the full audit suite - and combine their findings into one short, high-confidence plan.

## Before you start

This is expensive. It runs 9 audits in parallel (3 agents × 3 audits each), plus the architecture audit. It takes a while and burns a lot of tokens.

Always confirm first:

> "The Master Audit runs the architecture audit once, then 3 master agents in parallel - each running the duplicate, fail-fast, and bloat audits. That's 10 audits total. It takes a while and can burn significant tokens (potentially $$$ depending on the model). Are you sure?"

Look for an explitcit YES, even if they asked for a Master audit explicitly.

## Run

### 1. Architecture audit

Run [The Architecture Audit](architecture-audit.md) once. This grounds every later finding in real flows.

### 2. Spawn 3 master agents in parallel

Spawn 3 master audit subagents at the same time. Each one independently runs ALL three audits in a synchronous subagent. NO SUBAGENT RECURSION!

Run in order:
- [The Duplicate Audit](duplicate-audit.md)
- [The Fail-Fast Audit](fail-fast-audit.md)
- [The Bloat Audit](bloat-audit.md)

Each of those 3 master agents researches aggressively while running each audit. Don't re-explain it to them.

### 3. Combine across agents

Wait for all 3 master agents to return. Merge their findings.

If the same issue shows up in two different audits (e.g. a duplicate that's also bloat), pick the strongest framing and deduplicate.

Score each finding's **impact (1-10)** based on real-world consequence:

- **1-3** → minor cleanup, small win
- **4-6** → meaningful improvement, worth doing
- **7-9** → major impact (preventing customer-facing bugs, hours saved, big code reduction)
- **10** → critical (silent revenue loss, broken core flow, security risk)

If only 1 of the 3 master agents flagged something, weigh it more carefully. Low impact + low agreement = drop.

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
- **Impact:** [1-10] (and how many of the 3 master agents flagged it, e.g. "8/10, flagged by 3/3")
- **Files involved:** [paths as references at the end]
```

## Rules

- Always confirm cost/time first. Never just start.
- 1 architecture audit, then 3 master agents in parallel, each running all 3 audits. 9 audits total.
- Score each finding by impact 1-10 based on real-world consequence. Sort highest first.
- Keep the summary and to-do brutally short. Detail goes at the bottom only.
- Minimal, surgical fixes.
- Plain English throughout. A non-engineer should be able to act on this.
- Don't auto-apply anything. The output is a proposal.
