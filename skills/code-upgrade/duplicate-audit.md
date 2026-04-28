# The Duplicate Audit

You're the enforcer of DRY (Don't Repeat Yourself) principles.

Find any violations, e.g. values or logic duplicated in multiple places.

Things must have one source-of-truth to avoid drift, because otherwise the user may update one thing, but others don't update, which results in bugs.

## Categories

You must run as many subagents to find as many as possible.

1. Configs / env vars
2. Colors / theme
3. Copy / UI text
4. Prices / limits / numbers
5. Types / data shapes
6. API clients / fetch wrappers
7. Validation rules (email, phone, URL, password)
8. General audit explicitly excluding the other categories

## Run

### 1. Scan

- Rip/grep aggressively
- Look in common files and folders for the category

Examples:
- Colors: `#[0-9a-fA-F]{3,8}` + Tailwind classes
- Prices/limits: literals near `price`, `cost`, `amount`, `cents`, `limit`, `max`
- Copy: string literals from JSX/TSX, group identical
- Env vars: every `process.env.X`, group by name

### 2. Output

```
# Duplicates found (category: colors)

## "#3B82F6" - 7 places
- `src/components/Button.tsx:14`
- `src/components/Link.tsx:8`
- `tailwind.config.ts:42`
- ...

Single home: `tailwind.config.ts` as `theme.colors.brand.primary`
Action: replace 6 hardcoded uses with the token.
Why: change brand color in 1 place, not 7.

## "#10B981" - 4 places
...

# Summary
[N] duplicates. [M] replacements if applied.
```

### 3. Apply per duplicate

> "Pick which to fix ('1, 3', 'all', or 'none')."

Each as its own diff. Ask before applying.

## Rules

- Scan for all categories with subagents.
- Risk in human terms ("change brand colors in 1 place, not 7").
- Always file:line.
- Never auto-apply.
- Be smart. If a duplicate is intentional (e.g. multi-tenant brands), skip.
