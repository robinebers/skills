# The Plan Checklist

You're the gate before any code gets written. Walk a plan through five engineering principles before starting the work. If the plan fails any check, propose a fix.

This is the umbrella check. The other audits (Bloat, Duplicate, Fail-Fast, Retry) look at code that already exists. This one looks at code that's *about* to be written.

## The 5 checks

Walk all five, in order. Give a plain-English **pass / fail / unsure** verdict for each.

1. **KISS - is it simple?** *(Keep It Simple, Stupid.)* Could a smaller, dumber version of the plan ship the same outcome? Anywhere the plan looks fancy or clever where boring would work? If unsure, grill the user.

2. **YAGNI - is it only what was asked?** *(You Aren't Gonna Need It.)* Does the plan include extras the user didn't ask for - nice-to-haves, future-proofing, backward-compatibility, configurability nobody requested? Cut anything that wasn't part of the actual ask and if unsure, grill the user.

3. **DRY - does it reuse what exists?** *(Don't Repeat Yourself.)* Search the codebase for each step. Are there functions, components, routes, helpers, or patterns that already do what the plan would build from scratch? Don't ask the user unless you are unsure AFTER reading sufficient code.

4. **Fail-fast - will errors be loud?** Will errors in the new code show up immediately and obviously, or could they get silently swallowed? Look for plans that catch errors and move on, fall back to defaults, or hide failures.

5. **Retry-safe - safe to run twice?** If anything in the plan touches the outside world (sends an email, charges money, hits an external API, runs as a webhook or background job), what happens if it fires twice? Pass means nothing important happens. Fail means duplicate charge / email / record. N/A means pure logic with no side effects.

Use judgment. If something else about the plan smells off, flag it too.

## Run

### 1. Restate the goal

One sentence: *"We're trying to do X so that Y."* If unclear, ask before continuing.

### 2. Search the codebase

For each step in the plan, use subagents to look for existing functions, components, routes, libraries, or patterns that already do it. This feeds the DRY check.

### 3. Walk the 5 checks

Verdict on each in plain English. If a check fails, propose exactly what to change.

### 4. Output

```
# Goal
[One sentence]

# Checklist

- [ ] **KISS:** [pass / fail - one sentence why]
- [ ] **YAGNI:** [pass / fail - one sentence why]
- [ ] **DRY:** [pass / fail - one sentence why]
- [ ] **Fail-fast:** [pass / fail - one sentence why]
- [ ] **Retry-safe:** [pass / fail / N/A - one sentence why]

# Plan, tightened

- ✓ Keep: [step] - reason
- ✗ Cut: [step] - reason
- ~ Change: [old → simpler] - reason

# Already in the codebase (reuse)

- [what it does] *(file: [path](path))*

# What's actually new

1. [Smallest change]
2. [Smallest change]

# Risk

- **One-way doors:** [list, or "none"]
- **Recommended order:** [most-reversible first]
```

### 5. Ask

> "Proceed with the tightened plan, or grill it more?"

## Rules

- Walk all 5 checks. Don't skip any.
- Cut anything not needed for the stated goal.
- If the codebase already has something, reuse it. Show the path.
- No code unless asked.
- Don't start implementing.
- If the plan is already minimal, say so. Don't invent cuts.
- Plain English throughout. A non-engineer should be able to act on this.
