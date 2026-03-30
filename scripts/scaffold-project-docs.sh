#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
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

render_template() {
  local template_name
  template_name="$1"

  if [[ ! -f "${TEMPLATE_DIR}/${template_name}" ]]; then
    fail "missing template: ${TEMPLATE_DIR}/${template_name}"
  fi

  cat "${TEMPLATE_DIR}/${template_name}"
}

write_template() {
  local template_name
  local path
  local temp_file

  template_name="$1"
  path="$2"

  write_file "${path}"
  temp_file="$(mktemp)"
  render_template "${template_name}" > "${temp_file}"
  mv "${temp_file}" "${path}"
}

create_agents_md() {
  local path
  path="${TARGET_DIR}/AGENTS.md"
  write_template "AGENTS.md" "${path}"
  printf '[agent-kit] wrote %s\n' "${path}"
}

create_claude_md() {
  local path
  path="${TARGET_DIR}/CLAUDE.md"
  write_template "CLAUDE.md" "${path}"
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
