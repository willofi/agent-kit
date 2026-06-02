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
- Add architecture, compatibility, deployment, naming, typing, or layering
  constraints here when they become stable expectations.

## Review Notes

<!-- Replace with repo-specific review risks. -->

- Prioritize correctness, regression risk, and missing validation over
  style-only feedback.
