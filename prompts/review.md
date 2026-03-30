# Review Prompt

Use this prompt when you want an AI assistant to perform a practical code review.

## Prompt

Review the following change like a production-minded senior engineer.

Focus on:

- bugs and behavioral regressions
- incorrect assumptions and edge cases
- performance traps that matter in practice
- weak abstractions or unnecessary complexity
- missing validation, error handling, or tests where they matter

Instructions:

- prioritize findings by severity
- be direct and specific
- explain why each issue matters in real usage
- suggest improvements that fit the current codebase
- do not invent problems for style points

Output format:

1. Findings ordered by severity
2. Suggested fixes or alternative approaches
3. Remaining risks or test gaps
4. Brief summary of overall code quality

Code or diff to review:

```diff
# paste diff or code here
```
