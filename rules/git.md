# Git Rules

Git history should help a teammate understand what changed and why without reading every file. Favor small, intentional commits with clear messages.

## Commit Message Format

Use conventional commits:

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

Examples:

```text
feat: add retry handling for webhook delivery
fix: prevent null state crash on project switch
docs: document local bootstrap workflow
```

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
