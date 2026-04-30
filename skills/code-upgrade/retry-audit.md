# The Retry Audit

You're the enforcer of idempotency. Find spots in the code that could accidentally fire twice and cause real damage - duplicate emails, double charges, two welcome bonuses.

The internet is messy. Webhooks retry, jobs restart, users double-click. Treat every external trigger as something that *will* happen at least twice. Code that handles this safely is **idempotent**: running it twice has the same effect as running it once.

## Categories

You must run async subagents to find as many as possible.

1. **Webhook handlers:** Stripe, GitHub, Linear, Slack, Resend, Clerk all retry on any error or timeout.
2. **Sending things to people:** emails, SMS, push notifications.
3. **Money / credit movements:** charges, refunds, credit grants, plan upgrades.
4. **Creating things in outside services:** Stripe customers, third-party user accounts, calendar events.
5. **Database inserts that should be upserts:** "create row" instead of "create row if missing".
6. **Background jobs and crons:** queues that retry on failure, crons that overlap if the previous run is slow.
7. **User-facing buttons:** no disabled state, no dedup token, double-click = double action.
8. **AI calls with side effects:** "generate and send the report" running twice = two reports.

Use judgment. If something else smells like "running this twice would cause damage", flag it too.

## Run

### 1. Scan

Map the project using async subagents - one per category if helpful.

For each spot, figure out: what triggers it, what it does to the outside world, what would actually go wrong if it ran twice.

Investigate to give someone that never read/wrote code enough context to understand the impact, in plain language.

### 2. Classify

- **Safe:** running it twice does the same thing as running it once (e.g. upsert with a unique constraint, dedup key, idempotency-key header).
- **Risky:** running it twice causes a duplicate side effect a real person would notice.
- **Unclear:** depends on how the caller behaves - need to dig further or ask.

### 3. Output

```
# Spots that could fire twice

## Risky

> A payment webhook grants credits to the user. The payment provider retries on any error or slow response, so the same purchase can grant credits twice. Customer ends up double-credited.

**Why it matters:** real money lost on every retry.
  Fix options:
    - A) Remember which webhook events have already been processed, and ignore duplicates.
    - B) Make the credit grant unique per checkout, so a second grant for the same checkout silently does nothing.
  Recommended: A (works for every future webhook from this provider, not just this one).
  *(file: [src/webhooks/stripe.ts:42](src/webhooks/stripe.ts#L42))*

- A welcome email is sent from a background job. If the job fails partway and retries, the user gets a second welcome email.
  **Why it matters:** bad first impression, looks broken.
  Fix: mark the user as "welcomed" before sending, and skip if already marked. Or pass an idempotency key to the email provider.
  *(file: [src/jobs/welcome-email.ts:18](src/jobs/welcome-email.ts#L18))*

## Unclear

- An "upgrade plan" endpoint. Whether it's safe depends on how the frontend handles double-clicks. Probably risky.
  *(file: [src/api/upgrade.ts:8](src/api/upgrade.ts#L8))*

## Safe

- A GitHub webhook handler stores events keyed by GitHub's unique delivery ID, so duplicate deliveries are silently ignored. Good.
  *(file: [src/webhooks/github.ts:12](src/webhooks/github.ts#L12))*

# Summary
[N] risky, [M] unclear, [K] safe.
```

### 4. Ask

> "Want to fix the risky ones? Pick a number, 'all risky', or 'none'."

Each fix as its own diff. Ask before applying.

## Rules

- Each risky finding describes the *customer-facing damage* in plain English ("user gets charged twice", "two welcome emails").
- Code names and file paths go at the end as a reference, not the headline.
- Prefer "dedup key in the database" or "upsert with a unique constraint" over "check then insert" (which has a race condition).
- For outside services with built-in idempotency keys (Stripe, Resend, Inngest), use them.
- Don't auto-fix.
- If a webhook has no signature verification, mention it as a related risk but flag it as out of scope (that's a security issue, not an idempotency one).

