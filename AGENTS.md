# Repository Guidelines

This file is the repo-local entry point for AI working rules. Keep it focused on
agent-kit facts and links to shared guidance instead of duplicating the shared
docs.

## Instruction Precedence

- Treat this file as the repo-local source of truth.
- Project-local instructions here override shared docs when they conflict.
- Use shared docs to extend these rules, not replace them.
- If a section below is incomplete, inspect the repository directly before
  guessing.

## Shared Guidance

Load these shared docs by default when they are accessible:

- baseline: `~/.agent-kit/agents/core.md`
- coding: `~/.agent-kit/agents/coding.md`

Load SDD for non-trivial features, design changes, complex bug fixes, or
high-regression-risk work:

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

When shared docs are inaccessible, continue with the local rules here and ask
for specific shared contents only when they materially affect the task.

## Repository Structure

- `agents/`: reusable baseline and task-specific operating docs
- `prompts/`: reusable review, refactor, and debug prompts
- `rules/`: cross-cutting naming and Git rules
- `cursor/`: Cursor-specific adapter rules
- `templates/`: downstream entry-file templates consumed by `ai-scaffold`
- `bin/`: installed CLI commands such as `ai-context`, `ai-cat`, `ai-pack`, and `ai-scaffold`
- `scripts/`: bootstrap, scaffold, and smoke-test automation
- `specs/`: spec-driven work artifacts for this repository

## Commands

- install: none
- dev: n/a
- build: n/a
- lint: `bash -n scripts/*.sh bin/*`
- test: `bash scripts/test.sh`
- minimum validation before submit: `bash scripts/test.sh`

## Local Rules

- Keep docs short, composable, and assistant-neutral unless a file is
  intentionally tool-specific.
- Keep README examples, preset behavior, templates, and installed commands in
  sync within the same change.
- Avoid hard-coded downstream project structures or package-manager commands in
  shared templates unless clearly marked as placeholders.
- Prefer backwards-compatible CLI and preset changes. If behavior changes,
  update the migration guidance in `README.md`.
- For non-trivial code, prefer Korean explanatory comments at domain
  boundaries, security-sensitive logic, transactions, external I/O, and major
  feature flows. Avoid broad comment churn for obvious implementation details.
- For non-trivial changes in this repo, keep `specs/<feature>/requirements.md`,
  `design.md`, and `tasks.md` current; update completed task checkboxes as work
  is verified.
- During late-MVP or final checkpoints, add an explicit spec consistency review
  task that checks implemented routes, commands, response shapes, and documented
  behavior against the current spec artifacts.
- When documenting deployment configuration, distinguish Docker Compose root
  environment files from per-app environment files used by independently
  deployed services.
- For frontend work that expects E2E UI validation, state whether Playwright is
  already available, newly introduced, or intentionally deferred; document the
  validation command when it is part of the change.

## Review Notes

- Drift between `README.md` and the actual behavior of `bin/` or `scripts/` is a
  primary regression risk.
- Drift between SDD artifacts and late-MVP implementation details is a primary
  review risk, especially for missing routes, command output, or response shape
  mismatches.
- Deployment docs should not imply that Docker Compose environment layout is the
  only supported layout when per-app deployment configuration exists or is
  expected.
- Shell setup changes must work in both the zsh path and the POSIX `.profile`
  path used by bootstrap.
- Changes to scaffold output should verify that generic templates stay generic
  and do not accidentally copy repo-specific facts.
