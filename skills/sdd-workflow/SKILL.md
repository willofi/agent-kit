---
name: sdd-workflow
description: Use when the user asks for agent-kit SDD, spec-driven development, requirements/design/tasks planning, task-plan approval before implementation, or maintaining specs/<feature>/requirements.md, design.md, and tasks.md with verified task checkboxes.
---

# SDD Workflow

Use this skill for agent-kit spec-driven work.

## Required Context

Prefer project-local instructions first:

- `AGENTS.md`
- `CLAUDE.md` only as a tool-specific adapter when relevant

Then load shared guidance when accessible:

- `~/.agent-kit/agents/core.md`
- `~/.agent-kit/agents/coding.md`
- `~/.agent-kit/agents/architecture.md`
- `~/.agent-kit/agents/sdd.md`

If local files are inaccessible, ask the user for `ai-pack sdd` output.

## Workflow

1. Ground in the repository before asking product or design questions.
2. Decide whether the task is Quick Fix or SDD.
3. For SDD, create or update:

```text
specs/<feature-name>/
  requirements.md
  design.md
  tasks.md
```

4. Identify current behavior, target behavior, non-goals, domain vocabulary, and
   risky boundaries before drafting details.
5. Write requirements as observable behavior with stable `REQ-###` IDs or the
   existing spec's ID style. Group larger specs by capability or workflow.
6. Write design with repository context, architecture, interfaces, data/state,
   key flows, error handling, security/privacy, correctness properties,
   risks, alternatives, and validation where relevant.
7. Write tasks as ordered, phased checkbox items with requirement IDs,
   completion criteria, and verification.
8. Review the spec against the quality bar in `~/.agent-kit/agents/sdd.md`
   before asking for approval.
9. Stop after the task plan unless the user clearly approves implementation.
10. During implementation, complete tasks in order.
11. After each verified task, update its checkbox in `tasks.md`.
12. If implementation changes the plan, update the relevant spec file before
    continuing.
13. Capture durable lessons in `retrospective.md` only after active
    requirements, design, and tasks are updated.

## Default User Prompt

Interpret this request as activating the workflow:

```text
agents/sdd.md 흐름으로 진행해줘.
먼저 specs/<feature-name>/requirements.md, design.md, tasks.md를 만들거나 갱신하고,
task plan 승인 후 task별로 구현하면서 검증된 항목의 checkbox를 갱신해줘.
```
