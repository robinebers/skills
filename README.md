# Skills

A small public repo of reusable agent skills, packaged for installation with [`npx skills`](https://skills.sh/).

## Included Skills

- `code-upgrade` - Engineering-discipline toolkit for non-technical users working with AI coders. Wraps KISS, DRY, YAGNI, fail-fast, and idempotency into commands. Includes:
  - **The Master Audit** - architecture map plus 3 master agents running duplicate / fail-fast / bloat in parallel, returning one short executive plan.
  - **The Architecture Audit** - explain the app, then let the user grill it.
  - **The Plan Checklist** - vet a plan against KISS, YAGNI, DRY, fail-fast, and retry-safety before any code is written.
  - **The Bloat Audit** - find code AI coders tend to over-produce (dead code, one-shot helpers, defensive checks for impossible cases, etc.) and propose deletions.
  - **The Duplicate Audit** - find values and logic duplicated across the codebase, propose a single source of truth.
  - **The Fail-Fast Audit** - find places where errors are silently swallowed, propose loud failures.
  - **The Retry Audit** - find spots that could fire twice and cause real damage (duplicate emails, double charges), propose idempotency fixes.
- `conductor-json` - Generate `conductor.json` files for Conductor workspaces.
- `shepherd` - Shepherd a GitHub pull request all the way to done by polling status, addressing automatic reviewer feedback (Cubic, Bugbot, etc.), and verifying the merge cycle is truly clean.

## Install

Install everything from GitHub:

```bash
npx skills add robinebers/skills
```

Install a single skill:

```bash
npx skills add robinebers/skills --skill code-upgrade
npx skills add robinebers/skills --skill conductor-json
npx skills add robinebers/skills --skill shepherd
```

List what the package exposes:

```bash
npx skills add robinebers/skills --list
```

The `skills` CLI will install each skill into the right location for your agent, including Cursor, Claude Code, Codex, and others.
