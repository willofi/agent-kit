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
  bash -n "${REPO_ROOT}/scripts/manage-skills.sh"
  bash -n "${REPO_ROOT}/scripts/scaffold-project-docs.sh"
  bash -n "${REPO_ROOT}/scripts/test.sh"
  bash -n "${REPO_ROOT}/bin/ai-context"
  bash -n "${REPO_ROOT}/bin/ai-cat"
  bash -n "${REPO_ROOT}/bin/ai-pack"
  bash -n "${REPO_ROOT}/bin/ai-scaffold"
  bash -n "${REPO_ROOT}/bin/ai-skill"
}

run_zsh_smoke_test() {
  local tmp_home
  local tmp_project
  local tmp_partial_project
  local architecture_output
  local backend_output
  local context_output
  local preset_output
  local scaffold_list_output
  local skill_list_output
  local sdd_output

  tmp_home="$(make_temp_dir)"
  tmp_project="$(make_temp_dir)"
  tmp_partial_project="$(make_temp_dir)"

  log "Running zsh bootstrap smoke test"
  HOME="${tmp_home}" SHELL=/bin/zsh bash "${REPO_ROOT}/scripts/bootstrap.sh" >/dev/null

  preset_output="$(HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-pack list')"
  [[ "${preset_output}" == *"backend"* ]] || \
    fail "preset list should include backend"
  [[ "${preset_output}" == *"sdd"* ]] || \
    fail "preset list should include sdd"

  architecture_output="$(HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-pack architecture')"
  backend_output="$(HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-pack backend')"
  sdd_output="$(HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-pack sdd')"
  context_output="$(HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-context')"
  scaffold_list_output="$(HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-scaffold list')"
  skill_list_output="$(HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-skill list')"

  [[ "${architecture_output}" == *"===== agents/coding.md ====="* ]] || \
    fail "architecture preset should include agents/coding.md"
  [[ "${backend_output}" == *"===== agents/backend.md ====="* ]] || \
    fail "backend preset should include agents/backend.md"
  [[ "${backend_output}" == *"===== agents/coding.md ====="* ]] || \
    fail "backend preset should include agents/coding.md"
  [[ "${sdd_output}" == *"===== agents/architecture.md ====="* ]] || \
    fail "sdd preset should include agents/architecture.md"
  [[ "${sdd_output}" == *"===== agents/sdd.md ====="* ]] || \
    fail "sdd preset should include agents/sdd.md"
  [[ "${context_output}" == *"agents/sdd.md"* ]] || \
    fail "ai-context should list agents/sdd.md"
  [[ "${scaffold_list_output}" == *"all"* ]] || \
    fail "ai-scaffold list should include all creatable target"
  [[ "${skill_list_output}" == *"sdd-workflow"* ]] || \
    fail "ai-skill list should include sdd-workflow"

  (
    cd "${tmp_project}"
    HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-scaffold all >/dev/null'
  )

  check_file "${tmp_project}/AGENTS.md"
  check_file "${tmp_project}/CLAUDE.md"
  grep -Fq 'Until then, inspect the repo directly' "${tmp_project}/AGENTS.md" || \
    fail "scaffolded AGENTS.md should remain usable before customization"
  grep -Fq 'agents/backend.md' "${tmp_project}/AGENTS.md" || \
    fail "scaffolded AGENTS.md should mention backend shared docs"
  grep -Fq 'Load task-specific shared docs from `AGENTS.md`' "${tmp_project}/CLAUDE.md" || \
    fail "scaffolded CLAUDE.md should defer task-specific shared docs to AGENTS.md"
  grep -Fq 'agents/sdd.md' "${tmp_project}/AGENTS.md" || \
    fail "scaffolded AGENTS.md should mention sdd shared docs"
  grep -Fq 'agents/sdd.md' "${tmp_project}/CLAUDE.md" || \
    fail "scaffolded CLAUDE.md should mention sdd shared docs"

  printf 'existing claude file\n' > "${tmp_partial_project}/CLAUDE.md"
  (
    cd "${tmp_partial_project}"
    if HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-scaffold all >/dev/null 2>&1'; then
      fail "ai-scaffold all should fail when any target exists"
    fi
  )
  [[ ! -e "${tmp_partial_project}/AGENTS.md" ]] || \
    fail "ai-scaffold all should not partially write AGENTS.md when CLAUDE.md exists"

  HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-skill install sdd-workflow codex >/dev/null'
  check_file "${tmp_home}/.codex/skills/sdd-workflow/SKILL.md"

  if HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-skill install sdd-workflow codex >/dev/null 2>&1'; then
    fail "ai-skill install should fail when target exists"
  fi

  HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-skill install sdd-workflow codex --force >/dev/null'
  check_file "${tmp_home}/.codex/skills/sdd-workflow/SKILL.md"

  printf 'existing claude skill\n' > "${tmp_home}/.claude-preexisting"
  mkdir -p "${tmp_home}/.claude/skills/sdd-workflow"
  printf 'existing skill\n' > "${tmp_home}/.claude/skills/sdd-workflow/SKILL.md"
  rm -rf "${tmp_home}/.codex/skills/sdd-workflow"
  if HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-skill install sdd-workflow all >/dev/null 2>&1'; then
    fail "ai-skill install all should fail when any target exists"
  fi
  [[ ! -e "${tmp_home}/.codex/skills/sdd-workflow" ]] || \
    fail "ai-skill install all should not partially install codex when claude exists"

  (
    cd "${tmp_project}"
    HOME="${tmp_home}" /bin/zsh -c '. "$HOME/.zshrc"; ai-skill install sdd-workflow all --project >/dev/null'
  )
  check_file "${tmp_project}/.codex/skills/sdd-workflow/SKILL.md"
  check_file "${tmp_project}/.claude/skills/sdd-workflow/SKILL.md"
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
