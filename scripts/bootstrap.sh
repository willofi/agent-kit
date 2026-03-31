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
case ":\${PATH}:" in
  *":\${AGENT_KIT_PATH}/bin:"*) ;;
  *) export PATH="\${AGENT_KIT_PATH}/bin:\${PATH}" ;;
esac
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
  printf '%s\n' "${shell_block}" >> "${rc_file}"

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
