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
When gathering additional shared or repository context, start with the smallest relevant scope and avoid bulk-loading files or docs.

- frontend: `~/.agent-kit/agents/frontend.md` for React, Next.js App Router, or client-side state
- architecture: `~/.agent-kit/agents/architecture.md` for structure, boundaries, and large design changes
- review: `~/.agent-kit/prompts/review.md` for code review tasks
- refactor: `~/.agent-kit/prompts/refactor.md` for behavior-preserving cleanup
- debug: `~/.agent-kit/prompts/debug.md` for root-cause analysis
- naming: `~/.agent-kit/rules/naming.md` when naming quality materially affects the work
- git: `~/.agent-kit/rules/git.md` when commit or PR behavior matters

If shared docs are not accessible in the current environment, continue with the local rules here and ask for specific shared contents only when they materially affect the task.

## Repository Context

- `agents/`, `prompts/`, and `rules/` are the reusable shared guidance that downstream repos consume.
- `templates/` contains the generic scaffold source for downstream `AGENTS.md` and `CLAUDE.md` files. Do not replace placeholders here with repo-specific facts.
- `bin/` contains the installed `ai-*` commands that bootstrap exposes on `PATH`.
- `scripts/` owns bootstrap, scaffold, and smoke-test behavior. Keep it aligned with `README.md`.

## Commands And Validation

- install: none
- dev: n/a
- build: n/a
- lint: `bash -n scripts/*.sh bin/*`
- test: `bash scripts/test.sh`
- minimum validation before done: `bash scripts/test.sh`

## Local Rules

- Treat documentation accuracy as product behavior. If a preset, command, or template changes, update the docs in the same patch.
- Prefer composable, reusable guidance over long assistant-specific monoliths.
- Preserve generic placeholders in `templates/` so scaffolded files do not make false assumptions about downstream repos.

## Done Criteria

- mention what changed and why, at the right level for the task
- mention the validation that was run, or say explicitly if it was not run
- mention notable risks, assumptions, or follow-up work when they matter
