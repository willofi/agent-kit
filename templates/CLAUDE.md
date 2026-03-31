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

<!-- Replace this section with repo-specific facts when they are known.
Keep the file usable even before customization: if details are missing, inspect the repository directly instead of guessing. -->

- Inspect the repository directly before assuming ownership, generated paths, or edit boundaries.
- Document fragile zones, deployment caveats, or areas requiring extra care here when they become clear.

## Commands And Validation

<!-- Replace these with repo-specific commands when they are known.
Until then, discover commands from the repository itself rather than guessing. -->

- install: inspect the repo before choosing a command
- dev: inspect the repo before choosing a command
- build: inspect the repo before choosing a command
- lint: inspect the repo before choosing a command
- test: inspect the repo before choosing the cheapest reliable automated check
- minimum validation before done: run the smallest reliable checks that cover the changed behavior
- if no reliable automated test exists, say so explicitly and describe the manual validation performed

## Local Rules

<!-- Replace this section with project-specific rules that differ from the shared baseline when they matter. -->

- If project-specific rules are not documented yet, inspect the codebase and follow existing patterns rather than inventing new ones.
- Add architecture, naming, typing, layering, environment, deployment, or compatibility constraints here when they become stable expectations.

## Done Criteria

<!-- Replace this section with repo-specific completion expectations when they are known. -->

- mention what changed and why, at the right level for the task
- mention the validation that was run, or say explicitly if it was not run
- mention notable risks, assumptions, or follow-up work when they matter
