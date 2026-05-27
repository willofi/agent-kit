# Spec-Driven Development Guidelines

Load this file for non-trivial features, design changes, complex bug fixes, or
work with meaningful regression risk. The goal is to make the agent's intent,
plan, and verification path explicit before implementation starts.

## When To Use SDD

Use the SDD flow when the task:

- changes product behavior or public interfaces
- spans multiple files, modules, services, or tools
- has unclear requirements, edge cases, or rollout risk
- needs architectural judgment or migration planning
- could create expensive regressions if misunderstood

Use the Quick Fix path for obvious typos, small documentation corrections,
simple config edits, or clearly bounded one-file changes. If a Quick Fix grows
in scope, switch to SDD before continuing.

## Required Flow

1. Ground in the repository before asking product or design questions.
2. Write or update `requirements.md`.
3. Write or update `design.md`.
4. Write or update `tasks.md`.
5. Wait for user approval or a clear implementation instruction.
6. Implement tasks in order unless the task file is updated with the reason.
7. After each verified task, update its checkbox in `tasks.md` immediately.

Do not treat a plan as complete until the implementation path, validation, and
open assumptions are clear enough for another agent to execute.

## requirements.md

Requirements should describe observable behavior and constraints, not the
implementation. Prefer EARS-style statements with stable IDs:

```text
- REQ-001
  WHEN <event or condition>,
  THE SYSTEM SHALL <observable behavior>.

- REQ-002
  IF <state or precondition>,
  THE SYSTEM SHALL <observable behavior>.

- REQ-003
  WHILE <ongoing condition>,
  THE SYSTEM SHALL <maintained behavior>.

- REQ-004
  WHERE <context or scope>,
  THE SYSTEM SHALL <context-specific behavior>.
```

Include negative cases, failure behavior, security, performance, accessibility,
or compatibility constraints when they materially affect the implementation.

## design.md

Design should translate requirements into an implementation approach. Include:

- related requirement IDs
- architecture, module, or ownership changes
- data models, public interfaces, command behavior, or wire shapes
- validation, error handling, and failure modes
- test strategy and acceptance checks
- migration, compatibility, or rollout concerns when relevant
- alternatives rejected and why, but only when the trade-off matters
- open questions and assumptions that could change the plan

Keep design at the level needed to remove implementation ambiguity. Avoid
speculative architecture that is not required by the current requirements.

## tasks.md

Tasks should be checkbox items that are small, ordered, and verifiable.

Each task should include:

- a stable task ID such as `T001`
- related requirement IDs
- completion criteria
- verification command or manual check

Example:

```markdown
- [ ] `T001` Add login form validation (`REQ-001`, `REQ-003`)
  - Completion: invalid emails show an inline field error.
  - Verification: `pnpm test auth`.
```

Only mark a task complete after implementation and verification. For partial
work, leave the checkbox empty and add a short note. If the task list changes
during implementation, update `tasks.md` and explain the reason in the task or
final response.

## Drift Control

If implementation reveals that the spec is wrong or incomplete:

- update `requirements.md` when desired behavior changes
- update `design.md` when the chosen approach changes
- update `tasks.md` when the implementation steps or verification change
- ask the user before making major product, architecture, or compatibility
  decisions that were not already settled

The source of truth is the current repository plus the current spec artifacts,
not the agent's earlier assumptions.
