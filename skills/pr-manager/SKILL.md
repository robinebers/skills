---
name: pr-manager
description: 'Manage GitHub pull requests with `gh` and `git`: create or update a pull request, wait for checks, fetch review comments, and optionally fix them automatically. Use when the user says things like "create pr", "open a pr", "update the pr", "pull comments", "check PR comments", "check for new comments", or "fetch review comments".'
---

# PR Manager

Create or update a GitHub pull request, then run automated review cycles: wait for checks, pull comments, summarize them, and optionally fix them — in a loop until the PR is clean.

## Preference Question

Ask this **once per conversation** using the structured question tool. If the user already answered, reuse that answer for all future cycles.

```
How should I handle review comments?

A) Fix everything automatically
B) Fix critical and should-fix (skip suggestions)
C) Just summarize, I'll decide
```

## Create or Update PR

1. If on `main`/`master`, create a new branch first (fix/x, feat/x, chore/x, etc).
2. Commit relevant changes.
3. Push the branch to GitHub.
4. If no PR exists yet, open one with `gh pr create` using a concise title and a short body (use the repo's PR template if `gh` picks one up, otherwise write a `## Summary` with 1-3 bullets and a `## Test plan` checklist).
5. Note the push timestamp — this marks the start of the review cycle.

## Review Cycle

After every push, run this cycle automatically. Do not ask the user whether to continue.

1. **Poll checks** — run `gh pr checks` until all checks have completed.
2. **CRITICAL:** DO NOT STOP, EVEN IF PENDING. You are explicitly waiting for ALL AI code reviewers to finish their reviews.
3. **Update user:**  Show brief progress updates like `3/5 checks done, waiting...`. Poll every 30 seconds.
4. **Fetch comments** — use `gh` to pull PR reviews, inline comments, and issue comments.

```bash
gh pr view <PR> --json reviews,comments,url,title,author
gh api repos/{owner}/{repo}/pulls/{number}/comments --paginate
gh api repos/{owner}/{repo}/issues/{number}/comments --paginate
```

3. **Filter to what's new** — only show comments that arrived **after the last push**. On the very first cycle, show all unresolved comments. If the current cycle has no new comments but older unresolved comments exist, fall back to those.
4. **Skip resolved comments** — if a thread is marked resolved or clearly already fixed, drop it.
5. **Summarize** — organize and present comments using the output format below.

## Fix Cycle

Based on the user's preference:

- **A (fix everything)**: fix all comments, then commit, push, and run another review cycle.
- **B (fix critical + should-fix)**: fix `Must Fix` and `Should Fix` comments, summarize `Nice to Have` items, then commit, push, and run another review cycle.
- **C (just summarize)**: show the summary and stop. Wait for the user to tell you what to do.

**Stop looping** when two consecutive cycles produce no new `Must Fix` or `Should Fix` comments. Summarize anything remaining and report done.

## Output Format

Number comments sequentially as C1, C2, C3 across all categories so the user can refer to them easily.

Show exactly:
- One title line: `PR #123 - {title}`
- `### Must Fix`
- `### Should Fix`
- `### Nice to Have`

Nothing else — no metadata, no counts, no extra sections.

If a category is empty, show `Nothing here.` under it.

```markdown
PR #123 - {title}

### Must Fix

**C1** · @reviewer · `src/file.tsx:42`
{Plain-language summary: what the reviewer is asking and what it means in practice.}

**Why it matters**: {Impact explained in simple, everyday language. No jargon.}
**How to fix**: {The likely fix in simple terms, when obvious.}

---

### Should Fix

**C2** · @reviewer · `src/api.ts:88`
...

### Nice to Have

**C3** · @reviewer · `src/index.ts:5`
...
```

### Writing style for summaries

- Write for someone who is not a developer. If a technical term is unavoidable, explain it immediately in plain language.
- "Why it matters" should describe real-world impact: what breaks, what gets slower, what confuses users.
- "How to fix" should be a simple action, not a code snippet.
- Keep each comment summary to 2-4 lines max.
- Group by reviewer when multiple comments come from the same person.
- Collapse long threads into one item with enough context to understand the issue.
