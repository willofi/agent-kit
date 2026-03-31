# Claude Instructions

## Instruction Precedence

- Treat this file as the repo-local source of truth.
- Project-local instructions in this file override shared docs when they conflict.
- Use shared docs to extend these rules, not replace them.
- If a section below is still a placeholder, inspect the repository directly instead of guessing.

## Default Working Rules

Use these defaults unless project-local instructions say otherwise:

- Prefer direct, concrete recommendations over vague options.
- Keep code changes focused and easy to review.
- Match the existing stack and local conventions unless they are clearly harmful.
- Explain important assumptions, risks, and trade-offs.
- Validate changed behavior with the cheapest reliable check.

## Shared Baseline

Use these shared docs by default when they are accessible:

- baseline: `~/.agent-kit/agents/core.md`
- coding: `~/.agent-kit/agents/coding.md`

## Task-Specific Shared Docs

Load these shared docs only when they match the task:

Do not load task-specific shared docs unless the current task requires them.

- frontend: `~/.agent-kit/agents/frontend.md` for React, Next.js App Router, or client-side state
- architecture: `~/.agent-kit/agents/architecture.md` for structure, boundaries, and large design changes
- review: `~/.agent-kit/prompts/review.md` for code review tasks
- refactor: `~/.agent-kit/prompts/refactor.md` for behavior-preserving cleanup
- debug: `~/.agent-kit/prompts/debug.md` for root-cause analysis
- naming: `~/.agent-kit/rules/naming.md` when naming quality materially affects the work
- git: `~/.agent-kit/rules/git.md` when commit or PR behavior matters

If shared docs are not accessible in the current environment, continue with the local rules here and ask for specific shared contents only when they materially affect the task.

## Repository Context

TODO: Replace this section with repo-specific facts.

- `<path-or-area>`: what it owns, whether it is generated, and any edit boundaries that matter
- `<path-or-area>`: fragile zones, deployment caveats, or areas requiring extra care

## Commands And Validation

TODO: Replace this section with the real commands used in this repository.

- install: `<command>`
- dev: `<command>`
- build: `<command>`
- lint: `<command>`
- test: `<command>`
- minimum validation before done: `<command>`, `<command>`
- if no reliable automated test exists, say so explicitly and describe the manual validation performed

## Local Rules

TODO: Replace this section with project-specific rules that differ from the shared baseline.

- conventions that affect architecture, naming, typing, or layering
- environment, deployment, or compatibility constraints

## Done Criteria

TODO: Replace this section with completion expectations for this repository.

- mention what changed and why, at the right level for the task
- mention the validation that was run, or say explicitly if it was not run
- mention notable risks, assumptions, or follow-up work when they matter
