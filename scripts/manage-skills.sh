#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENT_KIT_PATH="${AGENT_KIT_PATH:-$(cd "${SCRIPT_DIR}/.." && pwd)}"
SKILL_DIR="${AGENT_KIT_PATH}/skills"
TARGET_ROOT="$(pwd)"
FORCE=0
PROJECT=0

usage() {
  cat <<'EOF'
usage:
  ai-skill list
  ai-skill install <skill> <codex|claude|all> [--project] [--force]

examples:
  ai-skill install sdd-workflow codex
  ai-skill install sdd-workflow claude
  ai-skill install sdd-workflow all --project
EOF
}

fail() {
  printf '[agent-kit] error: %s\n' "$1" >&2
  exit 1
}

list_skills() {
  if [[ ! -d "${SKILL_DIR}" ]]; then
    fail "missing skills directory: ${SKILL_DIR}"
  fi

  find "${SKILL_DIR}" -mindepth 2 -maxdepth 2 -name SKILL.md -print | \
    sed "s#^${SKILL_DIR}/##; s#/SKILL.md\$##" | \
    sort
}

require_skill() {
  local skill_name
  local source_path

  skill_name="$1"
  source_path="${SKILL_DIR}/${skill_name}"

  [[ -f "${source_path}/SKILL.md" ]] || fail "unknown skill: ${skill_name}"
}

personal_target_path() {
  local skill_name
  local tool

  skill_name="$1"
  tool="$2"

  case "${tool}" in
    codex)
      printf '%s/skills/%s\n' "${CODEX_HOME:-${HOME}/.codex}" "${skill_name}"
      ;;
    claude)
      printf '%s/.claude/skills/%s\n' "${HOME}" "${skill_name}"
      ;;
    *)
      fail "unsupported tool: ${tool}"
      ;;
  esac
}

project_target_path() {
  local skill_name
  local tool

  skill_name="$1"
  tool="$2"

  case "${tool}" in
    codex)
      printf '%s/.codex/skills/%s\n' "${TARGET_ROOT}" "${skill_name}"
      ;;
    claude)
      printf '%s/.claude/skills/%s\n' "${TARGET_ROOT}" "${skill_name}"
      ;;
    *)
      fail "unsupported tool: ${tool}"
      ;;
  esac
}

target_path() {
  local skill_name
  local tool

  skill_name="$1"
  tool="$2"

  if [[ "${PROJECT}" -eq 1 ]]; then
    project_target_path "${skill_name}" "${tool}"
  else
    personal_target_path "${skill_name}" "${tool}"
  fi
}

assert_can_install() {
  local path

  path="$1"

  if [[ -e "${path}" && "${FORCE}" -ne 1 ]]; then
    fail "${path} already exists. Re-run with --force to replace it."
  fi
}

copy_skill() {
  local source_path
  local target_path_value

  source_path="$1"
  target_path_value="$2"

  rm -rf "${target_path_value}"
  mkdir -p "$(dirname "${target_path_value}")"
  cp -R "${source_path}" "${target_path_value}"
  printf '[agent-kit] installed %s\n' "${target_path_value}"
}

install_skill() {
  local skill_name
  local tool
  local source_path
  local codex_target
  local claude_target

  skill_name="$1"
  tool="$2"
  source_path="${SKILL_DIR}/${skill_name}"

  require_skill "${skill_name}"

  case "${tool}" in
    codex|claude)
      assert_can_install "$(target_path "${skill_name}" "${tool}")"
      copy_skill "${source_path}" "$(target_path "${skill_name}" "${tool}")"
      ;;
    all)
      codex_target="$(target_path "${skill_name}" codex)"
      claude_target="$(target_path "${skill_name}" claude)"
      assert_can_install "${codex_target}"
      assert_can_install "${claude_target}"
      copy_skill "${source_path}" "${codex_target}"
      copy_skill "${source_path}" "${claude_target}"
      ;;
    *)
      fail "unsupported install target: ${tool}"
      ;;
  esac
}

main() {
  local command
  local skill_name
  local tool

  if [[ "$#" -eq 0 ]]; then
    usage >&2
    exit 1
  fi

  command="$1"
  shift

  case "${command}" in
    list)
      if [[ "$#" -ne 0 ]]; then
        fail "list does not accept arguments"
      fi
      list_skills
      ;;
    install)
      if [[ "$#" -lt 2 ]]; then
        usage >&2
        exit 1
      fi

      skill_name="$1"
      tool="$2"
      shift 2

      while [[ "$#" -gt 0 ]]; do
        case "$1" in
          --project)
            PROJECT=1
            ;;
          --force)
            FORCE=1
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

      install_skill "${skill_name}" "${tool}"
      ;;
    -h|--help)
      usage
      ;;
    *)
      fail "unknown command: ${command}"
      ;;
  esac
}

main "$@"
