# Cursor Rules

Use this file as a thin adapter to the shared agent-kit guidance.

## Required Context

When available, read these before generating code, plans, or reviews:

- `~/.agent-kit/agents/core.md`
- `~/.agent-kit/agents/coding.md`

For non-trivial features, design changes, complex bug fixes, or
high-regression-risk work, also read:

- `~/.agent-kit/agents/sdd.md`

## Behavior

- Prefer project-local instructions over shared defaults when the conflict is
  explicit and intentional.
- If `~/.agent-kit` cannot be read, ask for the needed document contents instead
  of treating path references as sufficient.
- Keep Cursor-specific rules here short; shared behavior belongs in
  `agents/`, `prompts/`, or `rules/`.
