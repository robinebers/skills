# Skills

A small public repo of reusable agent skills, packaged for installation with [`npx skills`](https://skills.sh/).

## Included Skills

- `code-upgrade` - Engineering-discipline toolkit for non-technical users working with AI coders. Wraps KISS, DRY, YAGNI, fail-fast, and idempotency into commands. Includes:
  - **The Master Audit** - architecture map first, then duplicate / fail-fast / bloat / retry in either Normal (1 generalist sub-agent across the whole app) or Deep (3 specialist sub-agents in parallel, each running all 4 audits but scoped to a different part such as frontend / backend / other), returning one short executive plan.
  - **The Architecture Audit** - explain the app, then let the user grill it.
  - **The Plan Checklist** - vet a plan against KISS, YAGNI, DRY, fail-fast, and retry-safety before any code is written.
  - **The Bloat Audit** - find code AI coders tend to over-produce (dead code, one-shot helpers, defensive checks for impossible cases, etc.) and propose deletions.
  - **The Duplicate Audit** - find values and logic duplicated across the codebase, propose a single source of truth.
  - **The Fail-Fast Audit** - find places where errors are silently swallowed, propose loud failures.
  - **The Retry Audit** - find spots that could fire twice and cause real damage (duplicate emails, double charges), propose idempotency fixes.

- `worktree-setup` - Set up new AI agent workspaces (Git worktrees) so they start ready-to-go — same tools, same settings, same access as your main setup. No blank slate, no manual fiddling. Works with Cursor, Codex, Conductor, and Claude Code.

- `shepherd` - Shepherd a GitHub pull request to merge-ready by polling status, addressing automatic reviewer feedback (Cubic, Bugbot etc.), and verifying the review cycle is truly clean. Stops at merge-ready and never merges without explicit human approval.

- `hotseat` - Create significantly better plans by putting yourself into the hotseat. The agent challenges your plan one question at a time until everything's clear. Inspired by [Matt Pocock](https://github.com/mattpocock)'s [`grill-me`](https://github.com/mattpocock/skills/blob/main/grill-me/SKILL.md), but meaningfully improved for accuracy.

## Install

Install everything from GitHub:

```bash
npx skills add robinebers/skills
```

Install a single skill:

```bash
npx skills add robinebers/skills --skill code-upgrade
npx skills add robinebers/skills --skill worktree-setup
npx skills add robinebers/skills --skill shepherd
npx skills add robinebers/skills --skill hotseat
```

List what the package exposes:

```bash
npx skills add robinebers/skills --list
```

The `skills` CLI will install each skill into the right location for your agent, including Cursor, Claude Code, Codex, and others.
