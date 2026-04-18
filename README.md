# Skills

A small public repo of reusable agent skills, packaged for installation with `[npx skills](https://skills.sh/)`.

## Included Skills

- `code-auditor` - Audit codebases for duplicate code, dead code, dependency bloat, and refactoring opportunities.
- `conductor-json` - Generate `conductor.json` files for Conductor workspaces.
- `shepherd` - Shepherd a GitHub pull request to done by waiting for Cubic and Bugbot reviews, addressing feedback, and verifying the merge cycle is truly clean.

## Install

Install everything from GitHub:

```bash
npx skills add robinebers/skills
```

Install a single skill:

```bash
npx skills add robinebers/skills --skill code-auditor
npx skills add robinebers/skills --skill conductor-json
npx skills add robinebers/skills --skill shepherd
```

List what the package exposes:

```bash
npx skills add robinebers/skills --list
```

The `skills` CLI will install each skill into the right location for your agent, including Cursor, Claude Code, Codex, and others.