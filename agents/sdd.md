# Spec-Driven Development Guidelines

Load this file for non-trivial features, design changes, complex bug fixes, or
work with meaningful regression risk. The goal is to make intent, plan, and
verification explicit before implementation starts.

## When To Use SDD

Use SDD when the task:

- changes product behavior or public interfaces
- spans multiple files, modules, services, or tools
- has unclear requirements, edge cases, or rollout risk
- needs architectural judgment or migration planning
- could create expensive regressions if misunderstood

Use Quick Fix for obvious typos, small documentation corrections, simple config
edits, or clearly bounded one-file changes. If scope grows, switch to SDD.

## Required Flow

1. Ground in the repository before asking product or design questions.
2. Identify the feature boundary, current behavior, target behavior, and
   explicit non-goals.
3. Write or update `requirements.md`.
4. Write or update `design.md`.
5. Write or update `tasks.md`.
6. Review the spec against the quality bar below.
7. Wait for user approval or a clear implementation instruction.
8. Implement tasks in order unless the task file is updated with the reason.
9. After each verified task, update its checkbox in `tasks.md` immediately.

The plan is not complete until another agent could execute the path,
validation, and assumptions without making new decisions.

## Spec Quality Bar

A strong spec is organized by product or domain capability, not by a shallow
list of files to edit. For substantial work, the spec should make these things
clear:

- what exists today, what will change, and what stays out of scope
- the domain vocabulary and lifecycle states a teammate must understand
- happy paths, empty states, failure states, permission boundaries, and recovery
  paths
- security, privacy, concurrency, performance, compatibility, and migration
  constraints when they can affect the implementation
- external service, provider, streaming, AI, or command-line boundaries and how
  raw outputs become internal contracts
- user-facing next actions after each important workflow completes or fails
- how each requirement maps to design decisions, tasks, and verification

Prefer depth where ambiguity is expensive. It is acceptable for a small spec to
omit irrelevant sections, but do not omit a section merely because the answer is
unknown; record the assumption or open question instead.

## requirements.md

Describe observable behavior and constraints, not implementation. Prefer stable
IDs and EARS-style statements:

```text
- REQ-001
  WHEN <event or condition>,
  THE SYSTEM SHALL <observable behavior>.
```

Include negative cases, failure behavior, security, performance, accessibility,
or compatibility constraints when they materially affect the implementation.
For user-facing workflows, identify the user's next likely action; for domain
workflows, think in lifecycle terms rather than only CRUD terms.

For larger specs, group requirements by capability or workflow. Each group
should include:

- the user or system goal behind the capability
- acceptance criteria for success, empty, loading, invalid, unauthorized,
  timeout, partial failure, and rollback cases where relevant
- observable response shapes, status codes, UI states, command output, or
  persisted state changes when those are part of the contract
- explicit out-of-scope behavior so future agents do not infer extra work

Use one stable ID style within a spec. New specs should prefer `REQ-001`,
`REQ-002`, and so on. If an existing spec already uses
`Requirement 1` / `Acceptance Criteria 1.1`, preserve that style and keep
traceability consistent.

## design.md

Translate requirements into an implementation approach. Include:

- related requirement IDs
- current repository context and affected ownership boundaries
- architecture, module, or ownership changes
- data models, public interfaces, command behavior, or wire shapes
- key flows, state transitions, jobs, transactions, and external I/O
- validation, error handling, and failure modes
- security and privacy handling, especially for secret-bearing data
- correctness properties, invariants, or consistency rules when they matter
- test strategy and acceptance checks
- migration, compatibility, or rollout concerns when relevant
- alternatives rejected and why, but only when the trade-off matters
- open questions and assumptions that could change the plan

Keep design only detailed enough to remove implementation ambiguity.

For substantial specs, start from this outline and remove only sections that are
clearly irrelevant:

```markdown
## Overview
## Current Repository Context
## Requirements Mapping
## Architecture
## Components and Interfaces
## Data Models and State
## API, Command, or Wire Contracts
## Key Flows
## Error Handling
## Security and Privacy
## Correctness Properties
## Testing Strategy
## Migration, Compatibility, and Rollout
## Alternatives Considered
## Open Questions
```

Frontend design should name loading, empty, error, disabled, and responsive
states. Backend design should name persistence, transaction, validation,
authorization, logging, and external-service boundaries. AI or third-party
provider design should normalize provider-native payloads into internal
contracts before UI or public APIs consume them.

## tasks.md

Tasks are small, ordered, verifiable checkbox items. Each task includes:

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
work, leave it unchecked with a short note. If tasks change during
implementation, update `tasks.md` and explain why.

For substantial specs, organize tasks into phases that match implementation
dependencies, such as foundation, backend contract, frontend workflow,
integration, hardening, and documentation. Add explicit checkpoint tasks after
risky phases and a final spec consistency review task that compares implemented
routes, commands, response shapes, UI states, and documented behavior against
the current spec.

A task is too broad if it cannot be completed and verified in one focused pass
or if it hides unrelated backend, frontend, migration, and documentation work
behind one checkbox. Split it until completion and verification are concrete.
When file paths, modules, commands, or test names are known, include them.

Tasks should preserve traceability. Every in-scope requirement should be covered
by at least one task, and every task should point back to the requirement IDs or
acceptance criteria it satisfies.

## Spec Review Before Approval

Before asking for approval, inspect the spec as if another agent will implement
it without extra context:

- requirements are grouped by capability or workflow, not only by component
- design answers where code will live, how data moves, and how failures behave
- tasks are phased, ordered, traceable, and independently verifiable
- validation commands are real for the repository or clearly marked manual
- risky areas such as secrets, provider payloads, migrations, concurrency,
  existing runtime state, and user next actions are covered or explicitly
  deferred
- assumptions and open questions are visible enough for the user to approve or
  correct

## Drift Control

If implementation reveals that the spec is wrong or incomplete:

- update `requirements.md` when desired behavior changes
- update `design.md` when the chosen approach changes
- update `tasks.md` when the implementation steps or verification change
- add or update `retrospective.md` only for lessons that should inform future
  specs, not as a substitute for changing the active requirements, design, or
  tasks
- ask the user before making major product, architecture, or compatibility
  decisions that were not already settled

The source of truth is the current repository plus the current spec artifacts,
not the agent's earlier assumptions.
