# Cursor Rules

Use the files below as the default operating contract for this environment when they are available locally:

- `~/.agent-kit/agents/core.md`
- `~/.agent-kit/agents/coding.md`

## Required Behavior

1. Read both files before generating code, plans, or reviews when the session can access them.
2. Prefer those files over generic assistant defaults.
3. If project-local instructions conflict with the global rules, follow the project-local rule only when it is explicit and intentional.
4. If the session cannot read `~/.agent-kit`, ask for the document contents instead of treating the path reference as enough.

## Expected Outcome

- readable implementations over clever shortcuts
- pragmatic trade-offs over speculative architecture
- project-aware language and framework choices
- clear separation of UI, state, domain logic, and external I/O where relevant

If these files are missing or inaccessible, surface that immediately.
