#!/usr/bin/env bash
set -euo pipefail

AGENT_KIT_REFERENCE='~/.agent-kit'
TARGET_DIR="$(pwd)"
FORCE=0

usage() {
  cat <<'EOF'
usage: ai-scaffold <target> [--force]

targets:
  agents    create AGENTS.md in the current directory
  claude    create CLAUDE.md in the current directory
  all       create both AGENTS.md and CLAUDE.md
  list      show supported targets
EOF
}

fail() {
  printf '[agent-kit] error: %s\n' "$1" >&2
  exit 1
}

write_file() {
  local path
  path="$1"

  if [[ -e "${path}" && "${FORCE}" -ne 1 ]]; then
    fail "${path} already exists. Re-run with --force to overwrite it."
  fi
}

render_agents_md() {
  cat <<EOF
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

- baseline: \`${AGENT_KIT_REFERENCE}/agents/core.md\`
- coding: \`${AGENT_KIT_REFERENCE}/agents/coding.md\`

## Task-Specific Shared Docs

Load these shared docs only when they match the task:

Do not load task-specific shared docs unless the current task requires them.

- architecture: \`${AGENT_KIT_REFERENCE}/agents/architecture.md\` for structure, boundaries, and large design changes
- review: \`${AGENT_KIT_REFERENCE}/prompts/review.md\` for code review tasks
- refactor: \`${AGENT_KIT_REFERENCE}/prompts/refactor.md\` for behavior-preserving cleanup
- debug: \`${AGENT_KIT_REFERENCE}/prompts/debug.md\` for root-cause analysis
- naming: \`${AGENT_KIT_REFERENCE}/rules/naming.md\` when naming quality materially affects the work
- git: \`${AGENT_KIT_REFERENCE}/rules/git.md\` when commit or PR behavior matters

If shared docs are not accessible in the current environment, continue with the local rules here and ask for specific shared contents only when they materially affect the task.

## Project Structure And Ownership

TODO: Replace this section with repo-specific facts.

- \`<path-or-area>\`: what it owns, and whether it is hand-maintained or generated
- \`<path-or-area>\`: boundaries, fragile zones, or files that should not be edited casually

## Build, Test, And Development Commands

TODO: Replace this section with the real commands used in this repository.

- install: \`<command>\`
- dev: \`<command>\`
- build: \`<command>\`
- lint: \`<command>\`
- test: \`<command>\`
- minimum validation before submit: \`<command>\`, \`<command>\`
- if no reliable automated test exists, say so explicitly and describe the manual validation performed

## Local Conventions And Constraints

TODO: Replace this section with project-specific rules.

- architecture or framework conventions that differ from the shared baseline
- compatibility, deployment, or environment caveats
- naming, typing, or layering rules that matter often

## Review Notes

TODO: Replace this section with the failure modes that matter most here.

- common regression risks
- migration, rollout, or release checks if they matter
EOF
}

render_claude_md() {
  cat <<EOF
# Claude Instructions

## Instruction Precedence

- Treat this file as the repo-local source of truth.
- Project-local instructions in this file override shared docs when they conflict.
- Use shared docs to extend these rules, not replace them.
- If a section below is still a placeholder, inspect the repository directly instead of guessing.

## Default Working Rules

Use these defaults unless project-local instructions say otherwise:

- Prefer direct, concrete recommendations over vague options.
- Keep code changes focused and easy to review.
- Match the existing stack and local conventions unless they are clearly harmful.
- Explain important assumptions, risks, and trade-offs.
- Validate changed behavior with the cheapest reliable check.

## Shared Baseline

Use these shared docs by default when they are accessible:

- baseline: \`${AGENT_KIT_REFERENCE}/agents/core.md\`
- coding: \`${AGENT_KIT_REFERENCE}/agents/coding.md\`

## Task-Specific Shared Docs

Load these shared docs only when they match the task:

Do not load task-specific shared docs unless the current task requires them.

- architecture: \`${AGENT_KIT_REFERENCE}/agents/architecture.md\` for structure, boundaries, and large design changes
- review: \`${AGENT_KIT_REFERENCE}/prompts/review.md\` for code review tasks
- refactor: \`${AGENT_KIT_REFERENCE}/prompts/refactor.md\` for behavior-preserving cleanup
- debug: \`${AGENT_KIT_REFERENCE}/prompts/debug.md\` for root-cause analysis
- naming: \`${AGENT_KIT_REFERENCE}/rules/naming.md\` when naming quality materially affects the work
- git: \`${AGENT_KIT_REFERENCE}/rules/git.md\` when commit or PR behavior matters

If shared docs are not accessible in the current environment, continue with the local rules here and ask for specific shared contents only when they materially affect the task.

## Repository Context

TODO: Replace this section with repo-specific facts.

- main directories, boundaries, and generated paths
- the parts of the codebase that deserve extra caution

## Commands And Validation

TODO: Replace this section with the real commands used in this repository.

- install: \`<command>\`
- dev: \`<command>\`
- build: \`<command>\`
- lint: \`<command>\`
- test: \`<command>\`
- minimum validation before done: \`<command>\`, \`<command>\`
- if no reliable automated test exists, say so explicitly and describe the manual validation performed

## Local Rules

TODO: Replace this section with project-specific rules.

- project-specific constraints, conventions, and exceptions
- product, infra, auth, or data-handling constraints that matter often

## Done Criteria

TODO: Replace this section with completion expectations for this repository.

- what a good final response should mention here
- review, release, or documentation expectations that should not be skipped
EOF
}

create_agents_md() {
  local path
  path="${TARGET_DIR}/AGENTS.md"
  write_file "${path}"
  render_agents_md > "${path}"
  printf '[agent-kit] wrote %s\n' "${path}"
}

create_claude_md() {
  local path
  path="${TARGET_DIR}/CLAUDE.md"
  write_file "${path}"
  render_claude_md > "${path}"
  printf '[agent-kit] wrote %s\n' "${path}"
}

main() {
  local target

  if [[ "$#" -eq 0 ]]; then
    usage >&2
    exit 1
  fi

  target=""

  while [[ "$#" -gt 0 ]]; do
    case "$1" in
      --force)
        FORCE=1
        ;;
      agents|claude|all|list)
        if [[ -n "${target}" ]]; then
          fail "target already set to ${target}"
        fi
        target="$1"
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        fail "unknown argument: $1"
        ;;
    esac
    shift
  done

  case "${target}" in
    agents)
      create_agents_md
      ;;
    claude)
      create_claude_md
      ;;
    all)
      create_agents_md
      create_claude_md
      ;;
    list)
      printf '%s\n' agents claude all
      ;;
    *)
      usage >&2
      exit 1
      ;;
  esac
}

main "$@"
