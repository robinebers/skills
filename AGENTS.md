# AGENTS.md

Conventions for agents working in this repo. Read before adding or editing a skill.

## What this repo is

A public collection of **agent-agnostic skills** distributed via [skills.sh](https://skills.sh/) (`npx skills`).

- A skill is just `skills/<name>/SKILL.md`, optionally with `references/`, `scripts/`, and an `agents/openai.yaml` interface file.
- There are **no `.claude-plugin` / `.codex-plugin` manifests**. The `skills` CLI installs each skill into the right location per agent (Cursor, Claude Code, Codex, …). Agent-agnosticism is the CLI's job, not ours.

## Skill conventions (hard invariants)

- Folder name **==** frontmatter `name:`, and both are kebab-case (`^[a-z][a-z0-9]*(-[a-z0-9]+)*$`).
- Frontmatter has `name` + `description`. The `description` is the activation trigger — write *what it does + when to use it* with concrete trigger phrases.
- Flat namespace: prefix domain-specific skills so generic names aren't ambiguous (e.g. `macos-build-run-debug`, not `build-run-debug`).
- `references/X.md` links inside a `SKILL.md` must resolve **within that skill's own folder**. Skills install independently, so never link into another skill's internal files — refer to other skills by name instead.
- Optional `agents/openai.yaml` carries the Codex interface (`display_name`, `short_description`, `default_prompt: "Use $<name> …"`). Keep the `$<name>` token in sync with the folder name.

## Validate before committing

```bash
scripts/validate-skills.sh     # structure, frontmatter, name==folder, kebab-case, refs resolve
npx skills add . --list        # CLI parse check — should report "Found N skills" and list them all
```

There is no first-party `skills validate`/`lint` command, so `validate-skills.sh` (ours) covers the invariants and `add . --list` confirms the CLI can discover and parse every skill from the local path (no push required).

## Porting a skill from openai/plugins (repeatable playbook)

Source: <https://github.com/openai/plugins> — skills live at `plugins/<plugin>/skills/<skill>/`. This is where the macOS / iOS / Expo / Stripe skills came from. **The work is copy + decontaminate, not manifest conversion.**

1. **Triage value first.** Port skill-rich knowledge plugins. Skip (or ask before doing) low-value ones:
   - pure MCP wrappers with no `skills/` dir (e.g. `windsor-ai`) — nothing to port;
   - plugins redundant with an MCP connector you already have (e.g. `sentry`);
   - plugins shipping a *bundled* MCP server (e.g. `codex-security`) — heavier, treat as a separate project.
2. **Copy the payload only:** `cp -R plugins/<plugin>/skills/<skill> skills/<name>`. That brings `SKILL.md`, `references/`, `scripts/`, and `agents/openai.yaml`.
   - **Drop:** plugin-level `commands/`, `.codex-plugin/`, the plugin-level `agents/`, `assets/` (marketplace icons), `.mcp.json` (note the MCP dependency in the README instead), and the plugin README.
   - **Drop entirely** any `codex-*`-named skill (Codex-app-specific).
3. **Rename if generic.** Prefix by domain (`macos-*`). Then fix in the copied files: frontmatter `name:`, the `$name` token in `agents/openai.yaml`, and any backtick cross-references to renamed sibling skills.
4. **Decontaminate Codex coupling** (prose surgery). Sweep:
   ```bash
   grep -rIli -e codex -e environment.toml -e "Run button" -e write_stdin skills/<name>
   ```
   Then fix each hit:
   - remove `.codex/environments/environment.toml` + "Codex app Run button" wiring; **keep** the agent-agnostic `build_and_run.sh` script contract;
   - "Codex app" / "Codex" → neutral wording or delete;
   - Codex tool names (e.g. `write_stdin`) → generic phrasing ("answer prompts interactively");
   - "Codex in-app browser" → "a browser";
   - rename Codex-flavored filenames/temp dirs (e.g. `run-button-bootstrap.md` → `build-run-script.md`, `codex-ios-*` → `ios-*`) and update the references.
5. **Update `README.md`** — add the skill under its group, add an install example, and note external tooling deps (MCP servers, `npx` CLIs).
6. **Credit the source.** `openai/plugins` is MIT — keep the Credits note in the README.
7. **Validate** (the two commands above) and commit.

## "Done" checklist

- `grep -rIli -e codex -e environment.toml skills/<name>` → empty.
- folder name == frontmatter `name`, kebab-case.
- `scripts/validate-skills.sh` passes; `npx skills add . --list` lists the new skill.
- README updated; provenance credited.
