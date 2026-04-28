# The Fail-Fast Audit

Find places where problems are getting hidden. Make them loud.

A loud failure is good - you spot it and fix it. A silent failure is bad - the app pretends to work, charges the wrong card, sends the wrong email, and you find out weeks later.

## Categories

Run as many subagents as helpful to scan thoroughly.

1. **Errors caught and silently ignored:** code spots a problem, throws it away, keeps going as if nothing happened.
2. **Fake fallbacks:** when the real setting is missing (API key, password, URL), the app quietly uses a stand-in instead of stopping.
3. **"Nothing" returned instead of an error:** function gives back empty or null when it should be saying "this should never have happened".
4. **Skipping over missing data:** code politely steps around missing fields that were supposed to always be there.
5. **Background work that fails silently:** tasks running in the background where errors disappear into the void.
6. **Inputs not checked:** data from users or outside services taken at face value.
7. **Retry-forever loops:** endless retries that turn a permanent failure into invisible flailing.
8. **Errors only printed to logs:** no alert, no monitoring tool, no message to the user.
9. **Big safety nets:** a whole page, route, or job wrapped in one giant catch that swallows everything inside.

Use judgment. If something else smells like "this is hiding a real problem", flag it too.

## Run

### 1. Scan

Map the project using async subagents - one per category if helpful.

Investigate to give someone that never read/wrote code enough context to understand the impact, in plain language.

### 2. Output

```
# Hidden failures found

## High risk

- A payment failure is being silently caught and treated as success. If the payment provider errors, the user sees "thanks for your order" but no money was charged.
  Why it matters: missing revenue, broken orders, nobody gets alerted.
  Fix: stop swallowing the error - let it fail loudly, report it, show the user a real error.
  *(file: [src/api/checkout.ts:42](src/api/checkout.ts#L42))*

## Medium risk

- If the real payment key is missing from the environment, the app falls back to a fake test key instead of stopping. Production could silently run with a fake key and process nothing.
  Fix: refuse to start the app at all if the real key isn't set.
  *(file: [src/config.ts:12](src/config.ts#L12))*

## Low risk

- A user's email is replaced with an empty string when it's missing. Probably fine, worth a quick look.
  *(file: [src/lib/user.ts:201](src/lib/user.ts#L201))*

# Summary
[N] places where problems could go unnoticed in production.
```

### 3. Ask

"Want to fix any of these? Pick a number, 'all high risk', or 'none'."

## Rules

- Don't auto-fix.
- Each finding describes what would *actually go wrong in production* - in plain language.
- Risk in human terms ("user gets charged twice", "no alert when payments break").
- If a swallowed error looks intentional, flag it as a possibility - still confirm with the user.
- Code names and file paths go at the end as a reference, not the headline.
