# Claude Instructions

This file gives Claude repo-local context. Keep project facts here and use
shared agent-kit docs for reusable guidance.

## Instruction Precedence

- Treat this file as the repo-local source of truth when no `AGENTS.md` is
  present.
- If `AGENTS.md` exists, follow it for repo-local rules and use this file only
  for Claude-specific notes.
- Project-local instructions override shared docs when they conflict.
- If a section below is still a placeholder, inspect the repository directly
  instead of guessing.

## Shared Guidance

Load these shared docs by default when they are accessible:

- baseline: `~/.agent-kit/agents/core.md`
- coding: `~/.agent-kit/agents/coding.md`

For non-trivial features, design changes, complex bug fixes, or
high-regression-risk work, also load:

- sdd: `~/.agent-kit/agents/sdd.md`

Load task-specific docs only when they match the task:

- frontend: `~/.agent-kit/agents/frontend.md` for React, Next.js App Router, or client-side state
- backend: `~/.agent-kit/agents/backend.md` for API design, database changes, authentication, background jobs, or server-side logic
- architecture: `~/.agent-kit/agents/architecture.md` for structure, boundaries, and large design changes
- review: `~/.agent-kit/prompts/review.md` for code review tasks
- refactor: `~/.agent-kit/prompts/refactor.md` for behavior-preserving cleanup
- debug: `~/.agent-kit/prompts/debug.md` for root-cause analysis
- naming: `~/.agent-kit/rules/naming.md` when naming quality materially affects the work
- git: `~/.agent-kit/rules/git.md` when commit or PR behavior matters

If shared docs are inaccessible, continue with the local rules here and ask for
specific shared contents only when they materially affect the task.

## Spec-Driven Work

Use the SDD flow for non-trivial work:

1. Create or update `specs/<feature>/requirements.md`.
2. Create or update `specs/<feature>/design.md`.
3. Create or update `specs/<feature>/tasks.md`.
4. Wait for approval or a clear implementation instruction.
5. Implement task by task, updating checkboxes as tasks are verified.

Use a Quick Fix path for obvious typos, small docs corrections, simple config
edits, or clearly bounded one-file changes.

## Project Structure And Ownership

<!-- Replace this section with repo-specific facts when they are known.
Keep the file usable before customization: if details are missing, inspect the
repository directly instead of guessing. -->

- Inspect the repository directly before assuming ownership, generated paths, or
  edit boundaries.
- Document fragile zones, deployment caveats, or areas requiring extra care here
  when they become clear.

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

<!-- Replace this section with project-specific rules that differ from the
shared baseline when they matter. -->

- If project-specific rules are not documented yet, inspect the codebase and
  follow existing patterns rather than inventing new ones.
- Follow the project's existing import style. If it already uses path aliases,
  keep aliases defined in the appropriate project config and use them
  consistently.
- Add architecture, naming, typing, layering, environment, deployment, or
  compatibility constraints here when they become stable expectations.

## Done Criteria

<!-- Replace this section with repo-specific completion expectations when they
are known. -->

- mention what changed and why, at the right level for the task
- mention the validation that was run, or say explicitly if it was not run
- mention notable risks, assumptions, or follow-up work when they matter
