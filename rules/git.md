# Git Rules

Git history should explain what changed and why without making a teammate read
every file. Favor small, intentional commits with clear messages.

## Branch Strategy

When starting a new unit of work, create a dedicated branch from `main` before making commits.

- Prefer a branch prefix that matches the type of work, such as `feature/`, `fix/`, or `refactor/`.
- Use `main` as the default base branch unless the project clearly uses a different primary integration branch.
- Make the work commits on that dedicated branch instead of committing directly on `main` or another shared branch.
- Pick a branch name that describes the actual change, not just the area of the codebase.
- If the team or project already defines a different branching convention, follow that convention consistently.

Example: `fix/prevent-partial-scaffold-output`

## Commit Message Format

Prefer conventional commits unless the project has an established different format:

- `feat`
- `fix`
- `refactor`
- `docs`
- `test`
- `chore`
- `perf`

```text
<type>: <short description>
```

Example: `docs: document local bootstrap workflow`

## Message Quality

- Keep the summary short, specific, and imperative.
- Describe the change, not the ticket number.
- Avoid noisy prefixes, emojis, and vague text.
- Split unrelated work into separate commits.

## Commit Hygiene

- Commit coherent units of work.
- Review the diff before committing.
- Avoid mixing formatting churn into behavior changes unless required.
- Prefer a clean sequence of understandable commits over one giant dump.
