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

- architecture: `~/.agent-kit/agents/architecture.md` for structure, boundaries, and large design changes
- review: `~/.agent-kit/prompts/review.md` for code review tasks
- refactor: `~/.agent-kit/prompts/refactor.md` for behavior-preserving cleanup
- debug: `~/.agent-kit/prompts/debug.md` for root-cause analysis
- naming: `~/.agent-kit/rules/naming.md` when naming quality materially affects the work
- git: `~/.agent-kit/rules/git.md` when commit or PR behavior matters

If shared docs are not accessible in the current environment, continue with the local rules here and ask for specific shared contents only when they materially affect the task.

## Repository Context

TODO: Replace this section with repo-specific facts.

- main directories, boundaries, and generated paths
- the parts of the codebase that deserve extra caution

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

TODO: Replace this section with project-specific rules.

- project-specific constraints, conventions, and exceptions
- product, infra, auth, or data-handling constraints that matter often

## Done Criteria

TODO: Replace this section with completion expectations for this repository.

- what a good final response should mention here
- review, release, or documentation expectations that should not be skipped
