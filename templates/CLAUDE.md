# Claude Instructions

This is the Claude-specific adapter for the project. Follow `AGENTS.md` when it
exists, then load the shared agent-kit docs below when accessible.

## Required Context

- baseline: `~/.agent-kit/agents/core.md`
- coding: `~/.agent-kit/agents/coding.md`
- sdd: `~/.agent-kit/agents/sdd.md` for non-trivial features, design changes,
  complex bug fixes, or high-regression-risk work

Load task-specific shared docs from `AGENTS.md` only when the task calls for
them. If shared docs cannot be read, continue from local instructions and ask
only for missing content that would materially change the work.

## Adapter Rules

- Do not duplicate full repo rules here; follow `AGENTS.md` when present and
  update `AGENTS.md` for project facts.
- Preserve generic placeholders in scaffolded files until project facts are
  known.
- For SDD work, keep the relevant `specs/<feature>/tasks.md` checkboxes current
  as tasks are completed and verified.

## Spec-Driven Work

During late-MVP or final checkpoints, add an explicit spec consistency review
task that checks implemented routes, commands, response shapes, and documented
behavior against the current spec artifacts.

## Local Rules

- Keep project-specific rules in `AGENTS.md`; this file should stay a thin Claude adapter.

## Review Notes

- Put repo-specific review risks in `AGENTS.md` so adapters do not drift.

## Done Criteria

- State what changed and why.
- State what validation ran, or explicitly say if it was not run.
- Note important assumptions, risks, or follow-up work when they matter.
