---
name: shepherd
description: 'Shepherd a GitHub pull request all the way to done by relentlessly polling status and only acting once all automatic reviewers have both finished their review. Use when the user says things like "shepherd this PR", "babysit this PR", "get this PR merged", "wait for Cubic", "wait for Bugbot", or asks to drive a PR through review to merge.'
---

# Shepherd PR
Your job is to shepherd this PR all the way to truly done - not just "pushed", but reviewed, addressed, and verified.

Create the PR (or pick up the one just created), mark as ready for review, then relentlessly pull its status in a loop. Do not stop polling until all automatic reviewers (e.g., Bugbot, Cubic) have fully completed their review.

1. Wait for reviewers: Keep polling `gh pr view` / `gh pr checks` / review comments until ALL reviewers have finished. Do not act on partial feedback. If one is still running, keep waiting.
2. Triage their feedback: Once both are done, implement their required changes. Skip only if the suggestion is genuinely super minor (nit) or a rare edge case you can justify - in that case, reply explaining why and continue working.
3. Commit and push: After implementing changes, commit and push. Then go back to step 1 - the reviewers will automatically re-review your new push.
4. Loop: Repeat until a full cycle passes with nothing meaningful left to address from either reviewer.
5. Double-verify done: Before declaring the job complete, verify twice that (a) all reviewers have re-run on the latest commit, (b) no outstanding required changes remain, and (c) CI is green and the PR is mergeable.

Do not stop early.

"Pushed a fix" is not done.

Done is when you've looped through a clean review cycle and double-checked it.
