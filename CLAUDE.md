# Claude Instructions

This is the Claude-specific adapter for agent-kit. Follow `AGENTS.md` as the
repo-local source of truth, then load the shared docs below when accessible.

## Required Context

- baseline: `~/.agent-kit/agents/core.md`
- coding: `~/.agent-kit/agents/coding.md`
- sdd: `~/.agent-kit/agents/sdd.md` for non-trivial features, design changes,
  complex bug fixes, or high-regression-risk work

Load task-specific shared docs from `AGENTS.md` only when the task calls for
them. If shared docs cannot be read, continue from `AGENTS.md` and ask for only
the missing content that would materially change the work.

## Local Adapter Rules

- Do not duplicate the full repo rules here; update `AGENTS.md` for repo facts.
- Keep changes aligned with README, templates, and CLI behavior.
- Preserve generic placeholders in `templates/`.
- For SDD work, keep the relevant `specs/<feature>/tasks.md` checkboxes current
  as tasks are completed and verified.

## Done Criteria

- State what changed and why.
- State what validation ran, or explicitly say if it was not run.
- Note important assumptions, risks, or follow-up work when they matter.
