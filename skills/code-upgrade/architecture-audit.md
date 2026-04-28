# The Architecture Audit

Map the app, then answer follow-ups. Read-only.

## Output shape

Remember, non-technical, non-engineers. So keep it high-level and concise.

Avoid paths, filenames, line numbers, etc.

```
# What this app is
[One sentence]

# Main pieces
- Frontend: [what]
- Backend: [what]
- Database: [what]
- Jobs: [what]
- Outside services: [list, e.g. "Stripe", "Aptify", ...]
etc (only include what exists)

# Main flows
1. [Flow]: user → step → step → outcome
etc

# Worth grilling
- [Anything risky, complex, or surprising]
etc (if anything)
```

End with:

```
## **"Ask me anything.*

- 'where does the X happen?'
- 'why is Y in two places?'"*
```

(generate 3 very very concise suggested follow-ups)

## Rules

- Plain English, for non-engineers.
- Don't propose changes - point to the right tool (Code Minimizer, Bloat Audit, etc.).
