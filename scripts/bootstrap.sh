#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${HOME}/.agent-kit"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_REPO="$(cd "${SCRIPT_DIR}/.." && pwd)"

log() {
  printf '[bootstrap] %s\n' "$1"
}

fail() {
  printf '[bootstrap] error: %s\n' "$1" >&2
  exit 1
}

detect_rc_file() {
  case "$(basename "${SHELL:-}")" in
    zsh)
      printf '%s/.zshrc' "${HOME}"
      ;;
    bash)
      if [[ -f "${HOME}/.bashrc" ]]; then
        printf '%s/.bashrc' "${HOME}"
      else
        printf '%s/.bash_profile' "${HOME}"
      fi
      ;;
    *)
      printf '%s/.profile' "${HOME}"
      ;;
  esac
}

sync_repo() {
  log "Syncing current checkout into ${TARGET_DIR}"

  if command -v rsync >/dev/null 2>&1; then
    mkdir -p "${TARGET_DIR}"
    rsync -a --delete \
      --exclude '.git' \
      --exclude '.idea' \
      --exclude '.DS_Store' \
      "${SOURCE_REPO}/" "${TARGET_DIR}/"
    return
  fi

  log "rsync not found; using tar fallback"
  rm -rf "${TARGET_DIR}"
  mkdir -p "${TARGET_DIR}"

  tar -C "${SOURCE_REPO}" \
    --exclude='.git' \
    --exclude='.idea' \
    --exclude='.DS_Store' \
    -cf - . | tar -C "${TARGET_DIR}" -xf -
}

build_shell_block() {
  local begin_marker
  local end_marker

  begin_marker="# >>> agent-kit >>>"
  end_marker="# <<< agent-kit <<<"

  cat <<EOF2
${begin_marker}
export AGENT_KIT_PATH="${TARGET_DIR}"

ai-context() {
  if [[ ! -d "\${AGENT_KIT_PATH}" ]]; then
    printf '[agent-kit] missing: %s\n' "\${AGENT_KIT_PATH}" >&2
    return 1
  fi

  printf 'Agent context: %s\n\n' "\${AGENT_KIT_PATH}"
  find \
    "\${AGENT_KIT_PATH}/agents" \
    "\${AGENT_KIT_PATH}/prompts" \
    "\${AGENT_KIT_PATH}/rules" \
    "\${AGENT_KIT_PATH}/cursor" \
    -maxdepth 1 -type f | sort
}

ai-cat() {
  if [[ "\$#" -eq 0 ]]; then
    printf 'usage: ai-cat <relative-path> [<relative-path> ...]\n' >&2
    return 1
  fi

  local relative_path
  local target_path

  for relative_path in "\$@"; do
    target_path="\${AGENT_KIT_PATH}/\${relative_path}"

    if [[ ! -f "\${target_path}" ]]; then
      printf '[agent-kit] missing: %s\n' "\${target_path}" >&2
      return 1
    fi

    printf '\n===== %s =====\n\n' "\${relative_path}"
    cat "\${target_path}"
    printf '\n'
  done
}

ai-pack() {
  if [[ "\$#" -eq 0 ]]; then
    printf 'usage: ai-pack <preset> [target-path ...]\n' >&2
    printf 'available presets: frontend, review, review-strict, refactor, debug, architecture\n' >&2
    return 1
  fi

  local preset
  local section_label
  local target

  preset="\$1"
  section_label=""
  shift

  case "\${preset}" in
    list|--list|-l)
      printf 'available presets:\n'
      printf '%s\n' \
        'frontend' \
        'review' \
        'review-strict' \
        'refactor' \
        'debug' \
        'architecture'
      return 0
      ;;
    frontend)
      ai-cat \
        agents/core.md \
        agents/coding.md \
        agents/frontend.md || return 1
      section_label='Frontend targets:'
      ;;
    review)
      ai-cat \
        agents/core.md \
        agents/coding.md \
        prompts/review.md \
        rules/naming.md || return 1
      section_label='Review targets:'
      ;;
    review-strict)
      ai-cat \
        agents/core.md \
        agents/coding.md \
        prompts/review.md \
        rules/naming.md \
        rules/git.md || return 1
      section_label='Review targets:'
      ;;
    refactor)
      ai-cat \
        agents/core.md \
        agents/coding.md \
        prompts/refactor.md || return 1
      section_label='Refactor targets:'
      ;;
    debug)
      ai-cat \
        agents/core.md \
        agents/coding.md \
        prompts/debug.md || return 1
      section_label='Debug targets:'
      ;;
    architecture)
      ai-cat \
        agents/core.md \
        agents/architecture.md || return 1
      section_label='Architecture targets:'
      ;;
    *)
      printf '[agent-kit] unknown preset: %s\n' "\${preset}" >&2
      printf 'available presets: frontend, review, review-strict, refactor, debug, architecture\n' >&2
      return 1
      ;;
  esac

  if [[ "\$#" -gt 0 ]]; then
    printf '\n%s\n' "\${section_label}"

    for target in "\$@"; do
      printf -- '- %s\n' "\${target}"
    done

    printf '\n'
  fi
}

ai-scaffold() {
  "\${AGENT_KIT_PATH}/scripts/scaffold-project-docs.sh" "\$@"
}
${end_marker}
EOF2
}

configure_shell() {
  local rc_file
  local begin_marker
  local end_marker
  local legacy_begin_marker
  local legacy_end_marker
  local shell_block
  local temp_file
  local had_block

  rc_file="$(detect_rc_file)"
  begin_marker="# >>> agent-kit >>>"
  end_marker="# <<< agent-kit <<<"
  legacy_begin_marker="# >>> agent-core >>>"
  legacy_end_marker="# <<< agent-core <<<"
  shell_block="$(build_shell_block)"
  had_block=0

  mkdir -p "$(dirname "${rc_file}")"
  touch "${rc_file}"

  if grep -Fq "${begin_marker}" "${rc_file}" || grep -Fq "${legacy_begin_marker}" "${rc_file}"; then
    had_block=1
  fi

  temp_file="$(mktemp)"
  awk -v begin="${begin_marker}" -v end="${end_marker}" -v legacy_begin="${legacy_begin_marker}" -v legacy_end="${legacy_end_marker}" '
    $0 == begin || $0 == legacy_begin { skip = 1; next }
    ($0 == end || $0 == legacy_end) && skip { skip = 0; next }
    !skip { print }
  ' "${rc_file}" > "${temp_file}"

  mv "${temp_file}" "${rc_file}"
  printf '\n%s\n' "${shell_block}" >> "${rc_file}"

  if [[ "${had_block}" -eq 1 ]]; then
    log "Updated shell configuration in ${rc_file}"
  else
    log "Added shell configuration to ${rc_file}"
  fi
}

main() {
  command -v tar >/dev/null 2>&1 || fail "tar is required"

  sync_repo
  configure_shell

  log "Bootstrap complete"
  log "Restart your shell or run: source $(detect_rc_file)"
  log "Then run: ai-context"
  log "Use ai-cat <path> ... to print docs for assistants that cannot read local files"
  log "Use ai-pack <preset> ... for common task bundles"
  log "Use ai-scaffold <target> to generate project entry files like AGENTS.md"
}

main "$@"
