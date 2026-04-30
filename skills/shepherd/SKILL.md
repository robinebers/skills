---
name: shepherd
description: 'Shepherd a GitHub pull request all the way to merge-ready by relentlessly polling status and only acting once all automatic reviewers have finished. NEVER merges without explicit human approval. Use when the user says things like "shepherd this PR", "babysit this PR", "get this PR merge-ready", "wait for Cubic", "wait for Bugbot", or asks to drive a PR through review.'
---

# Shepherd PR

Your job is to shepherd this PR all the way to **merge-ready** - reviewed, addressed, verified, and CI green. **Not merged.** Merging is a human decision.

Create the PR (or pick up the one just created), mark as ready for review if not yet the case, then relentlessly poll its status in a loop. Do not stop polling until all automatic reviewers (e.g., Bugbot, Cubic, etc) have fully completed their review.

1. **Wait for reviewers:** Keep polling `gh pr view` / `gh pr checks` / review comments until ALL reviewers have finished. Do not act on partial feedback. If one is still running, keep waiting.

2. **Triage their feedback:** Once both are done, implement their required changes. Fix everything medium severity and beyond. Only fix low severity issue if they're a DRY violation or if there are other issues to fix already. Strictly skip suggestions/low severity issue if they're the only ones remaining, and they qualify under super minor (nit) or rare edge case. In these cases reply explaining why and continue working autonomously.

3. **Commit and push:** After implementing changes, commit and push. Then go back to step 1 - the reviewers will automatically re-review your new push.

4. **Loop:** Repeat until a full cycle passes with nothing meaningful left to address from either reviewer.

5. **Double-verify merge-ready:** Before declaring the PR merge-ready, verify twice that (a) all reviewers have re-run on the latest commit, (b) no outstanding required changes remain, and (c) CI is green and the PR is mergeable.

6. **Stop. Hand off to human.** Report that the PR is merge-ready and wait. **Do not merge.**

## Hard rule: never merge without explicit approval

- NEVER run `gh pr merge`, the GitHub merge API, or any equivalent action on your own.
- "All checks green" is NOT permission to merge. It is permission to stop and report.
- Even if the user originally said "get this PR merged", treat that as "get this PR merge-ready" and ask for explicit confirmation before merging.
- Only merge if the user replies with an explicit, unambiguous YES to merge after you've reported merge-ready (e.g. "yes merge it", "go ahead and merge"). A thumbs-up or "ok" is not enough - ask again if unclear.
- If in doubt, do not merge. Ask.

"Pushed a fix" is not done. "All green" is not done either - it's the handoff point.

**Do not stop early. Do not merge on your own.**

Done is when you've looped through a clean review cycle, double-checked it, reported merge-ready, and the human has explicitly approved the merge.
