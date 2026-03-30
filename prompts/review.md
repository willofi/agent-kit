# Review Guidelines

Load this file when the task is reviewing a code change, diff, or PR.

## What To Focus On

Review in this priority order:

1. **Correctness** — does it do what it claims? Are there bugs or behavioral regressions?
2. **Edge cases** — incorrect assumptions, missing validation, unhandled error paths.
3. **Performance** — traps that matter in practice, not theoretical concerns.
4. **Design** — weak abstractions, unnecessary complexity, or coupling that will cause pain later.
5. **Tests** — missing coverage where regressions are easy to miss.

Do not invent problems for style points. If something is fine, say nothing.

## How To Give Feedback

- Be direct and specific. Vague feedback does not help.
- Explain why an issue matters in real usage, not just in principle.
- Distinguish between blocking issues and suggestions.
- If you are unsure whether something is a bug or intentional, ask before flagging it as a finding.
- Suggest a fix or alternative when you raise a problem.

## Severity Labels

Use these consistently:

- `[blocking]` — must fix before merge; correctness or reliability risk
- `[suggestion]` — worth doing but not required
- `[nit]` — minor style or naming issue; low priority

## Output Format

1. Findings ordered by severity, each labeled `[blocking]`, `[suggestion]`, or `[nit]`.
2. Suggested fix or alternative for each blocking issue.
3. Remaining risks or test gaps not covered by the change.
4. One-line summary of overall quality.

## When To Escalate

If the change touches a critical path, has unclear requirements, or introduces a pattern that will spread, say so explicitly rather than just flagging individual lines.
