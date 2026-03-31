#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMP_DIRS=()

cleanup() {
  local directory

  if [[ "${#TEMP_DIRS[@]}" -eq 0 ]]; then
    return
  fi

  for directory in "${TEMP_DIRS[@]}"; do
    rm -rf "${directory}"
  done
}

make_temp_dir() {
  local directory

  directory="$(mktemp -d)"
  TEMP_DIRS+=("${directory}")
  printf '%s\n' "${directory}"
}

log() {
  printf '[test] %s\n' "$1"
}

fail() {
  printf '[test] error: %s\n' "$1" >&2
  exit 1
}

check_file() {
  local path

  path="$1"

  [[ -f "${path}" ]] || fail "missing expected file: ${path}"
}

run_syntax_checks() {
  log "Running bash syntax checks"

  bash -n "${REPO_ROOT}/scripts/bootstrap.sh"
  bash -n "${REPO_ROOT}/scripts/scaffold-project-docs.sh"
  bash -n "${REPO_ROOT}/scripts/test.sh"
  bash -n "${REPO_ROOT}/bin/ai-context"
  bash -n "${REPO_ROOT}/bin/ai-cat"
  bash -n "${REPO_ROOT}/bin/ai-pack"
  bash -n "${REPO_ROOT}/bin/ai-scaffold"
}

run_zsh_smoke_test() {
  local tmp_home
  local tmp_project
  local architecture_output

  tmp_home="$(make_temp_dir)"
  tmp_project="$(make_temp_dir)"

  log "Running zsh bootstrap smoke test"
  HOME="${tmp_home}" SHELL=/bin/zsh bash "${REPO_ROOT}/scripts/bootstrap.sh" >/dev/null

  HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-pack list >/dev/null'
  architecture_output="$(HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-pack architecture')"

  [[ "${architecture_output}" == *"===== agents/coding.md ====="* ]] || \
    fail "architecture preset should include agents/coding.md"

  (
    cd "${tmp_project}"
    HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-scaffold all >/dev/null'
  )

  check_file "${tmp_project}/AGENTS.md"
  check_file "${tmp_project}/CLAUDE.md"
  grep -Fq '<path-or-area>' "${tmp_project}/AGENTS.md" || \
    fail "scaffolded AGENTS.md should keep generic placeholders"
}

run_posix_smoke_test() {
  local tmp_home

  tmp_home="$(make_temp_dir)"

  log "Running POSIX shell bootstrap smoke test"
  HOME="${tmp_home}" SHELL=/bin/sh bash "${REPO_ROOT}/scripts/bootstrap.sh" >/dev/null

  HOME="${tmp_home}" /bin/sh -c '. "$HOME/.profile"; ai-context >/dev/null; ai-pack list >/dev/null'
}

main() {
  trap cleanup EXIT

  run_syntax_checks
  run_zsh_smoke_test
  run_posix_smoke_test

  log "All checks passed"
}

main "$@"
