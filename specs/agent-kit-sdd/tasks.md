# agent-kit Kiro-Style SDD Tasks

- [x] `T001` Add dogfood SDD spec artifacts (`REQ-003`, `REQ-004`, `REQ-005`)
  - Completion: `requirements.md`, `design.md`, and `tasks.md` exist under
    `specs/agent-kit-sdd/`.
  - Verification: inspect the files for requirement IDs, design mapping, and
    checkbox tasks.

- [x] `T002` Add centralized SDD guidance (`REQ-001` through `REQ-007`)
  - Completion: `agents/sdd.md` defines the SDD protocol and `agents/core.md`
    points non-trivial work to it.
  - Verification: `ai-context` can list `agents/sdd.md`.

- [x] `T003` Reduce adapter duplication and add SDD references (`REQ-007`,
  `REQ-009`)
  - Completion: `AGENTS.md`, `CLAUDE.md`, `cursor/rules.md`,
    `templates/AGENTS.md`, and `templates/CLAUDE.md` reference SDD without
    duplicating the full protocol.
  - Verification: scaffolded entry files mention `agents/sdd.md`.

- [x] `T004` Add the SDD preset and docs (`REQ-008`, `REQ-010`)
  - Completion: `ai-pack sdd` works and README documents the preset and SDD
    workflow.
  - Verification: `ai-pack list` includes `sdd`; `ai-pack sdd` includes
    `agents/architecture.md` and `agents/sdd.md`.

- [x] `T005` Update and run validation (`REQ-006`, `REQ-010`)
  - Completion: smoke tests cover the new SDD behavior and all tasks are checked
    when verified.
  - Verification: `bash scripts/test.sh`.

- [x] `T006` Strengthen the SDD spec quality bar (`REQ-011` through `REQ-014`)
  - Completion: `agents/sdd.md` explains substantial-spec scope, requirements
    grouping, design outline, phased tasks, checkpoints, and approval-time
    self-review.
  - Verification: inspect `agents/sdd.md`; `ai-pack sdd` includes the updated
    guidance.

- [x] `T007` Sync SDD workflow docs and skill (`REQ-015`, `REQ-010`)
  - Completion: README and `skills/sdd-workflow/SKILL.md` point agents toward
    the centralized quality bar without duplicating the full protocol.
  - Verification: inspect README and skill text.

- [x] `T008` Validate SDD quality-bar packaging (`REQ-010`, `REQ-015`)
  - Completion: smoke tests assert the SDD preset exposes the quality bar and
    substantial-spec outline.
  - Verification: `bash scripts/test.sh`.
