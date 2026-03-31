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
When gathering additional shared or repository context, start with the smallest relevant scope and avoid bulk-loading files or docs.

- frontend: `~/.agent-kit/agents/frontend.md` for React, Next.js App Router, or client-side state
- architecture: `~/.agent-kit/agents/architecture.md` for structure, boundaries, and large design changes
- review: `~/.agent-kit/prompts/review.md` for code review tasks
- refactor: `~/.agent-kit/prompts/refactor.md` for behavior-preserving cleanup
- debug: `~/.agent-kit/prompts/debug.md` for root-cause analysis
- naming: `~/.agent-kit/rules/naming.md` when naming quality materially affects the work
- git: `~/.agent-kit/rules/git.md` when commit or PR behavior matters

If shared docs are not accessible in the current environment, continue with the local rules here and ask for specific shared contents only when they materially affect the task.

## Project Structure And Ownership

- `agents/`: shared baseline and task-specific operating docs; hand-maintained
- `prompts/`: reusable task prompts for review, refactor, and debug workflows
- `rules/`: cross-cutting naming and Git rules that other repos can import
- `cursor/`: Cursor-specific entry rules; keep aligned with the shared docs they reference
- `templates/`: generic downstream templates consumed by `ai-scaffold`; keep placeholders generic and tool-agnostic
- `bin/`: installed CLI commands such as `ai-context`, `ai-cat`, `ai-pack`, and `ai-scaffold`
- `scripts/`: bootstrap, scaffold, and smoke-test automation; changes here should be validated end-to-end

## Build, Test, And Development Commands

- install: none
- dev: n/a
- build: n/a
- lint: `bash -n scripts/*.sh bin/*`
- test: `bash scripts/test.sh`
- minimum validation before submit: `bash scripts/test.sh`

## Local Conventions And Constraints

- Keep docs short and composable. Prefer assistant-neutral guidance unless a file is intentionally tool-specific.
- Keep README examples, preset behavior, templates, and installed commands in sync within the same change.
- Avoid hard-coded example project structures or package-manager commands in shared templates unless they are clearly marked as placeholders.
- Prefer backwards-compatible CLI and preset changes. If behavior changes, update the migration guidance in `README.md`.

## Review Notes

- Drift between `README.md` and the actual behavior of `bin/` or `scripts/` is a primary regression risk.
- Shell setup changes must work in both the zsh path and the POSIX `.profile` path used by bootstrap.
- Changes to scaffold output should verify that generic templates stay generic and do not accidentally copy repo-specific facts.
