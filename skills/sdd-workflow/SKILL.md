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

4. Write requirements as observable behavior with stable `REQ-###` IDs.
5. Write design with implementation approach, interfaces, risks, and validation.
6. Write tasks as ordered checkbox items with requirement IDs and verification.
7. Stop after the task plan unless the user clearly approves implementation.
8. During implementation, complete tasks in order.
9. After each verified task, update its checkbox in `tasks.md`.
10. If implementation changes the plan, update the relevant spec file before continuing.

## Default User Prompt

Interpret this request as activating the workflow:

```text
agents/sdd.md 흐름으로 진행해줘.
먼저 specs/<feature-name>/requirements.md, design.md, tasks.md를 만들거나 갱신하고,
task plan 승인 후 task별로 구현하면서 검증된 항목의 checkbox를 갱신해줘.
```
