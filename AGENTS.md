# Repository Guidelines

This file is the repo-local entry point for AI working rules.

## Instruction Precedence

- Treat this file as the repo-local source of truth.
- Project-local instructions in this file override shared docs when they conflict.
- Use shared docs to extend these rules, not replace them.
- If a section below is still a placeholder, inspect the repository directly instead of guessing.

## Default Working Rules

Use these defaults unless project-local code clearly requires otherwise:

- Prefer readable code over clever code.
- Keep changes focused and avoid unrelated churn.
- Match the existing stack and code style unless it is clearly harmful.
- Validate assumptions at system boundaries and make failure paths easy to trace.
- Test the changed behavior at the cheapest reliable level first.
- Surface assumptions, risks, and trade-offs early.

## Shared Baseline

Use these shared docs by default when they are accessible:

- baseline: `~/.agent-kit/agents/core.md`
- coding: `~/.agent-kit/agents/coding.md`

## Task-Specific Shared Docs

Load these shared docs only when they match the task:

Do not load task-specific shared docs unless the current task requires them.

- architecture: `~/.agent-kit/agents/architecture.md` for structure, boundaries, and large design changes
- review: `~/.agent-kit/prompts/review.md` for code review tasks
- refactor: `~/.agent-kit/prompts/refactor.md` for behavior-preserving cleanup
- debug: `~/.agent-kit/prompts/debug.md` for root-cause analysis
- naming: `~/.agent-kit/rules/naming.md` when naming quality materially affects the work
- git: `~/.agent-kit/rules/git.md` when commit or PR behavior matters

If shared docs are not accessible in the current environment, continue with the local rules here and ask for specific shared contents only when they materially affect the task.

## Project Structure And Ownership

TODO: Replace this section with repo-specific facts.

- `<path-or-area>`: what it owns, and whether it is hand-maintained or generated
- `<path-or-area>`: boundaries, fragile zones, or files that should not be edited casually

## Build, Test, And Development Commands

TODO: Replace this section with the real commands used in this repository.

- install: `<command>`
- dev: `<command>`
- build: `<command>`
- lint: `<command>`
- test: `<command>`
- minimum validation before submit: `<command>`, `<command>`
- if no reliable automated test exists, say so explicitly and describe the manual validation performed

## Local Conventions And Constraints

TODO: Replace this section with project-specific rules.

- architecture or framework conventions that differ from the shared baseline
- compatibility, deployment, or environment caveats
- naming, typing, or layering rules that matter often

## Review Notes

TODO: Replace this section with the failure modes that matter most here.

- common regression risks
- migration, rollout, or release checks if they matter
