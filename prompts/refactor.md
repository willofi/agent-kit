# Refactor Prompt

Use this prompt when you want an AI assistant to improve existing code without changing intended behavior.

## Prompt

Refactor the following code with a senior-engineering mindset.

Goals:

- improve readability first
- simplify control flow and reduce unnecessary complexity
- remove duplication only when it improves clarity
- improve performance only where the gain is real and low-risk
- preserve existing behavior unless a bug is clearly identified

Instructions:

- explain the main problems before changing the code
- prefer small, obvious abstractions over generic frameworks
- keep naming explicit and domain-oriented
- avoid speculative architecture and premature optimization
- call out ambiguous behavior before assuming a rewrite is safe

Output format:

1. Brief diagnosis of the current code
2. Refactored code
3. Short explanation of what changed and why
4. Any risks, edge cases, or follow-up improvements worth considering

Code to refactor:

```ts
// paste code here
```
