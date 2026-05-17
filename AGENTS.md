# Agent instructions

Conventions for AI coding agents working in this repo.

## Skill aliases: keep canonical and stub in sync

`skills/worktree-setup/SKILL.md` is the canonical worktree-setup skill. `skills/setup-process/SKILL.md` is a hidden alias stub (`metadata.internal: true`) that keeps the old `--skill setup-process` invocation working for users who still have the old name in their notes or CLAUDE.md.

**When editing the canonical, mirror the body into the stub.** The two files must stay byte-identical apart from the frontmatter. Verify after every edit:

```bash
diff skills/setup-process/SKILL.md skills/worktree-setup/SKILL.md
```

Only the frontmatter `name:` and the `metadata.internal` block should differ. If anything else differs, the stub is stale and anyone invoking `--skill setup-process` will get out-of-date content.

When backward compat is no longer worth maintaining, deleting `skills/setup-process/` is the clean exit — the README already references only `worktree-setup`.
