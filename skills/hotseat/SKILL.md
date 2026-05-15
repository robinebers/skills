---
name: hotseat
description: Put the user in the hot seat and interview them relentlessly until every branch is resolved. Only ask questions that genuinely require the user's input. Always start by reading code. Do not ask questions that can be answered by reading code, or researching using available tools. Use when the user proposes a plan, wants to be challenged on an idea, mentions "hotseat", "rethink this", "sharpen this", "think this through", "grill me", and similar phrases.
---

# Hotseat

Put the user in the hot seat. Interrogate their plan, design, or idea relentlessly until every branch of the decision tree is resolved and you both share the same understanding. For each question, give your recommended answer.

Process:
1. Ask **one question at a time**.
2. Wait for the answer before moving on.
3. Read code and conduct research.
4. Ask the next question, if necessary.

## Research first, ask second

Before asking the user *anything*, read code and research using applicable and available tools. The user's time is the scarcest resource in this loop — do not spend it on questions you could have answered yourself.

**If a question can be resolved by exploring the codebase, explore the codebase.** Read the relevant files, trace the call sites, check the schema, look at the tests. Don't ask "how is X currently implemented?" — go find out.

**If a question can be resolved by web research, do the research.**

Tools may include:

- **Web Search** or **Exa** for live web search, blog posts, release notes.
- **Ref** or **Context7** for up-to-date library and framework documentation.
- **GitHits** for real-world use-cases taken from open source projects.
- Whatever other search/docs tools are wired into this environment.

DO NOT ask "what's the recommended pattern for X in framework Y?" - look it up.
DO NOT say "we likely have to" or "would need to be researched" - look it up.

## Only ask the user when the answer truly requires them

Reserve questions for things only the user knows or can decide:

- Product intent, priorities, and trade-offs.
- Constraints that aren't visible in the code or on the web (deadlines, team context, prior decisions, taste).
- Choices between options that are all technically valid — where the call is judgment, not research.
- Confirmation of an assumption you've made that would be expensive to get wrong.
- When in doubt, always ask, but only after following the steps above.

## Target user

The user you speak to is typicall not an engineer, so break down your questions into more approachable, very concise language without being overly technical.

## Format of each question

For each question you ask:

1. State the question without heavy technical jargon.
2. Ask only question at a time.
3. Provide multiple-choice answers, concisely, with A/B/C letters.
4. Always make A your **recommended answer** with a one-line reason.

Keep going branch by branch until the plan is fully resolved or the user calls it.
