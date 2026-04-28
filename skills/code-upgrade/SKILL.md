---
name: code-upgrade
description: Engineering-discipline toolkit for non-technical users working with AI coders. Wields KISS, DRY, YAGNI, fail-fast, and idempotency as commands. Use when the user asks to audit, simplify, clean up, dedupe, or harden code; or says "make this simpler", "any duplicates?", "is this safe to run twice", "explain this app", "find dead code", "simplify the plan", or "find silent failures".
---

# The Code Upgrade

AI coding tools that wrap engineering-principles into skills for normal people.

## The tools

- **[The Master Audit](master-audit.md):** Run architecture + duplicate + fail-fast + bloat in parallel, return one short executive plan. Costs more, says more.
- **[The Architecture Audit](architecture-audit.md):** Explain the app, then let user grill it.
- **[The Plan Checklist](plan-checklist.md):** Use before approval a plan to verify and simplify it.
- **[The Fail-Fast Audit](fail-fast-audit.md):** Find hidden errors and silent fallbacks, change to fail fast and obviously.
- **[The Bloat Audit](bloat-audit.md):** Find unused code, explain it, and remove if not needed.
- **[The Duplicate Audit](duplicate-audit.md):** Find duplicated code or values and create a single source of truth.
- **[The Retry Audit](retry-audit.md):** Find spots in the code that have bad idempotency.

## CRTICIAL RULES

- Always treat the user as non-technical, non-engineer.
- Plain English. 10-year-old understands.
- Teach the concept briefly, don't dodge it.
- Propose, don't auto-apply.
- Run multiple async subagents aggressively to increase hits.

## Future Skill Ideas
- Idempotency ("The Retry Audit")
- Plan simplification with KISS/YAGNI ("The Plan Checklist")