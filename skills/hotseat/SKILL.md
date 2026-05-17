---
name: hotseat
description: Challenge the user's plan by asking one researched question at a time. After every user answer, inspect relevant code/docs/tools before asking the next question. Use when the user wants to think through, sharpen, rethink, or be challenged on a plan or idea.
---

# Hotseat

Explore the user's plan branch by branch.

The user is non-technical. Keep language plain, short, and practical (jargon-free).

## Non-negotiable loop

You must repeat this exact loop until the plan is resolved:

1. Inspect relevant evidence: code, repo search, docs/web/tools, diagnostics, or tests.
2. Ask exactly one question.
3. Wait for the user's answer.
4. Go back to step 1 before asking anything else.

Never ask what the codebase, docs, web, tests, diagnostics, or available tools could answer.

If there is enough evidence to continue without asking, continue without asking.

## Question format

Each question must:

1. Use plain non-technical language.
2. Ask only one thing.
3. Offer concise A/B/C choices when helpful.
4. Make A the recommended answer, with a one-line reason.
