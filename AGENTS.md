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

- frontend: `~/.agent-kit/agents/frontend.md` for React, Next.js App Router, or client-side state
- architecture: `~/.agent-kit/agents/architecture.md` for structure, boundaries, and large design changes
- review: `~/.agent-kit/prompts/review.md` for code review tasks
- refactor: `~/.agent-kit/prompts/refactor.md` for behavior-preserving cleanup
- debug: `~/.agent-kit/prompts/debug.md` for root-cause analysis
- naming: `~/.agent-kit/rules/naming.md` when naming quality materially affects the work
- git: `~/.agent-kit/rules/git.md` when commit or PR behavior matters

If shared docs are not accessible, continue with the local rules here and ask for specific contents only when they materially affect the task.

## Project Structure And Ownership

<!-- Fill this in when initializing the repo -->

| Path or Area | Owns | Notes |
|---|---|---|
| `src/` | application source | hand-maintained |
| `public/` | static assets | do not edit casually |

<!-- Add fragile zones, generated files, or areas requiring extra care -->

## Build, Test, And Development Commands

<!-- Replace with actual commands for this repo -->

- install: `pnpm install`
- dev: `pnpm dev`
- build: `pnpm build`
- lint: `pnpm lint`
- test: `pnpm test`
- minimum validation before submit: `pnpm lint && pnpm build`

<!-- If no reliable automated test exists, say so explicitly -->

## Local Conventions And Constraints

<!-- Replace with project-specific rules that differ from the shared baseline -->

- (none yet — add architecture quirks, env requirements, or deployment caveats here)

## Review Notes

<!-- Add failure modes that matter most in this repo -->

- (none yet — add common regression risks or release checklist items here)
