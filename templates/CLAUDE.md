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

<!-- Replace with project-specific rules that differ from shared guidance. -->

- Follow existing project patterns before introducing new ones.
- For non-trivial code, prefer explanatory comments at domain boundaries,
  security-sensitive logic, transactions, external I/O, and major feature flows.
  Use the project's preferred collaboration language for those comments, and
  avoid broad comment churn for obvious implementation details.
- When documenting deployment configuration, distinguish Docker Compose root
  environment files from per-app environment files used by independently
  deployed services.
- For frontend work that expects E2E UI validation, state whether Playwright is
  already available, newly introduced, or intentionally deferred; document the
  validation command when it is part of the change.
- Add architecture, naming, typing, layering, environment, deployment, or
  compatibility constraints here when they become stable expectations.

## Review Notes

<!-- Replace this section with repo-specific review risks when they are known. -->

- Prioritize correctness, regression risk, and missing validation over
  style-only feedback.
- Watch for drift between SDD artifacts and late-MVP implementation details,
  especially missing routes, command output, or response shape mismatches.
- Deployment docs should not imply that Docker Compose environment layout is the
  only supported layout when per-app deployment configuration exists or is
  expected.
- Add common failure modes, migration concerns, rollout checks, or
  release-sensitive areas here when they become clear.

## Done Criteria

- State what changed and why.
- State what validation ran, or explicitly say if it was not run.
- Note important assumptions, risks, or follow-up work when they matter.
