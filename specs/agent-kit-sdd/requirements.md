# agent-kit Kiro-Style SDD Requirements

## Overview

Add a shared, tool-agnostic spec-driven development protocol to agent-kit.
The protocol should make Kiro-style `requirements.md` -> `design.md` -> `tasks.md`
work the default for non-trivial work while preserving a lightweight path for
obvious small fixes.

## Requirements

- `REQ-001`
  WHEN an agent receives a non-trivial feature, design change, complex bug fix,
  or high-regression-risk task,
  THE SYSTEM SHALL guide the agent to use a spec-driven flow before
  implementation.

- `REQ-002`
  WHEN a task is an obvious typo, simple documentation correction, or clearly
  bounded one-file change,
  THE SYSTEM SHALL allow a Quick Fix path without requiring full spec artifacts.

- `REQ-003`
  WHEN an agent writes `requirements.md`,
  THE SYSTEM SHALL use stable requirement IDs such as `REQ-001` and prefer
  EARS-style observable acceptance criteria.

- `REQ-004`
  WHEN an agent writes `design.md`,
  THE SYSTEM SHALL cover relevant requirements, architecture or module changes,
  interfaces, error handling, validation strategy, risks, and rejected
  alternatives when they matter.

- `REQ-005`
  WHEN an agent writes `tasks.md`,
  THE SYSTEM SHALL create small checkbox tasks with related requirement IDs and
  explicit completion or verification criteria.

- `REQ-006`
  WHEN an implementation task is completed and verified,
  THE SYSTEM SHALL update the relevant checkbox in `tasks.md` immediately.

- `REQ-007`
  WHEN project entry files or tool adapters reference shared guidance,
  THE SYSTEM SHALL keep SDD guidance centralized and avoid duplicating the full
  protocol in every adapter.

- `REQ-008`
  WHEN a user runs `ai-pack list` or `ai-pack sdd`,
  THE SYSTEM SHALL expose an SDD preset that includes the baseline engineering,
  coding, architecture, and SDD guidance.

- `REQ-009`
  WHEN `ai-scaffold all` creates project entry files,
  THE SYSTEM SHALL keep the supported scaffold targets unchanged while adding
  references to the shared SDD guidance.

- `REQ-010`
  WHEN documentation changes public commands or presets,
  THE SYSTEM SHALL keep README examples, smoke tests, and implementation in sync.

- `REQ-011`
  WHEN an agent writes a substantial spec,
  THE SYSTEM SHALL guide the agent to define current behavior, target behavior,
  non-goals, domain vocabulary, risky boundaries, and traceability before
  implementation.

- `REQ-012`
  WHEN an agent writes `requirements.md` for substantial work,
  THE SYSTEM SHALL group requirements by capability or workflow and cover
  success, empty, invalid, unauthorized, failure, recovery, and out-of-scope
  behavior where relevant.

- `REQ-013`
  WHEN an agent writes `design.md` for substantial work,
  THE SYSTEM SHALL provide a default outline that covers repository context,
  architecture, components, data/state, contracts, flows, errors, security,
  correctness properties, testing, rollout, alternatives, and open questions.

- `REQ-014`
  WHEN an agent writes `tasks.md` for substantial work,
  THE SYSTEM SHALL guide phased, ordered, traceable, independently verifiable
  tasks with checkpoint and final spec consistency review tasks where relevant.

- `REQ-015`
  WHEN the SDD workflow skill or README describes SDD usage,
  THE SYSTEM SHALL surface the spec quality bar without duplicating the full
  protocol outside `agents/sdd.md`.
