# Repository Guidelines

This file is the repo-local entry point for AI working rules. Keep project facts
here and use shared agent-kit docs for reusable guidance.

## Instruction Precedence

- Treat this file as the repo-local source of truth.
- Project-local instructions override shared docs when they conflict.
- If a section is still a placeholder, inspect the repository before guessing.

## Shared Guidance

Load by default when accessible:

- baseline: `~/.agent-kit/agents/core.md`
- coding: `~/.agent-kit/agents/coding.md`

Load for non-trivial features, design changes, complex bug fixes, or
high-regression-risk work:

- sdd: `~/.agent-kit/agents/sdd.md`

Load only when the task matches:

- frontend: `~/.agent-kit/agents/frontend.md` for React, Next.js App Router, or client-side state
- backend: `~/.agent-kit/agents/backend.md` for API design, database changes, authentication, background jobs, or server-side logic
- architecture: `~/.agent-kit/agents/architecture.md` for structure, boundaries, and large design changes
- review: `~/.agent-kit/prompts/review.md` for code review tasks
- refactor: `~/.agent-kit/prompts/refactor.md` for behavior-preserving cleanup
- debug: `~/.agent-kit/prompts/debug.md` for root-cause analysis
- naming: `~/.agent-kit/rules/naming.md` when naming quality materially affects the work
- git: `~/.agent-kit/rules/git.md` when commit or PR behavior matters

If shared docs are inaccessible, continue with this file and ask only for
missing shared content that would materially change the work.

## Spec-Driven Work

For SDD work, follow `~/.agent-kit/agents/sdd.md` and maintain
`specs/<feature>/requirements.md`, `design.md`, and `tasks.md`. Use Quick Fix
only for obvious, tightly bounded changes.

During late-MVP or final checkpoints, add an explicit spec consistency review
task that checks implemented routes, commands, response shapes, and documented
behavior against the current spec artifacts.

## Project Structure

<!-- Replace with repo-specific facts. Until then, inspect the repo directly. -->

- Document source roots, generated files, ownership boundaries, and fragile
  paths here when they become clear.

## Commands

<!-- Replace with repo-specific commands. Until then, discover them from files. -->

- install: inspect the repo before choosing a command
- dev: inspect the repo before choosing a command
- build: inspect the repo before choosing a command
- lint: inspect the repo before choosing a command
- test: inspect the repo before choosing the cheapest reliable automated check
- minimum validation before submit: run the smallest reliable checks that cover the changed behavior

If no reliable automated test exists, say so and describe the manual validation.

## Local Rules

<!-- Replace with project-specific rules that differ from shared guidance. -->

- Follow existing project patterns before introducing new ones.
- For user-facing workflows, check the user's next likely action; make missing
  follow-up steps explicit in UI, docs, or a follow-up spec.
- Normalize third-party, streaming, and AI provider-native payloads before UI or
  public interfaces; treat AI output as untrusted input.
- For secret-bearing forms and APIs, check backend exposure, logs, browser UX,
  and misleading credential field names.
- For Docker or local service changes, account for existing volumes, images,
  and containers, not only fresh setup.
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
- Add architecture, compatibility, deployment, naming, typing, or layering
  constraints here when they become stable expectations.

## Review Notes

<!-- Replace with repo-specific review risks. -->

- Prioritize correctness, regression risk, and missing validation over
  style-only feedback.
- Watch for drift between SDD artifacts and late-MVP implementation details,
  especially missing routes, command output, or response shape mismatches.
- When implementation reveals durable lessons, capture them in
  `retrospective.md` after updating active spec files as needed.
- Deployment docs should not imply that Docker Compose environment layout is the
  only supported layout when per-app deployment configuration exists or is
  expected.
- Add common failure modes, migration concerns, rollout checks, or
  release-sensitive areas here when they become clear.
