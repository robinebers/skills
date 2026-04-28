---
name: shepherd
description: 'Shepherd a GitHub pull request all the way to done by relentlessly polling status and only acting once all automatic reviewers have both finished their review. Use when the user says things like "shepherd this PR", "babysit this PR", "get this PR merged", "wait for Cubic", "wait for Bugbot", or asks to drive a PR through review to merge.'
---

# Shepherd PR

Your job is to shepherd this PR all the way to truly done - not just "pushed", but reviewed, addressed, and verified.

Create the PR (or pick up the one just created), mark as ready for review if not yet the case, then relentlessly pull its status in a loop. Do not stop polling until all automatic reviewers (e.g., Bugbot, Cubic, etc) have fully completed their review.

1. **Wait for reviewers:** Keep polling `gh pr view` / `gh pr checks` / review comments until ALL reviewers have finished. Do not act on partial feedback. If one is still running, keep waiting.

2. **Triage their feedback:** Once both are done, implement their required changes. Fix everything medium severity and beyond. Only fix low severity issue if they're a DRY violation or if there are other issues to fix already. Strictly skip suggestions/low severity issue if they're the only ones remaining, and they qualify under super minor (nit) or rare edge case. In these cases reply explaining why and continue working autonomously.

3. **Commit and push:** After implementing changes, commit and push. Then go back to step 1 - the reviewers will automatically re-review your new push.

4. **Loop:** Repeat until a full cycle passes with nothing meaningful left to address from either reviewer.

5. **Double-verify done:** Before declaring the job complete, verify twice that (a) all reviewers have re-run on the latest commit, (b) no outstanding required changes remain, and (c) CI is green and the PR is mergeable.

"Pushed a fix" is not done.

**Do not stop early.**

Done is when you've looped through a clean review cycle and double-checked it.
