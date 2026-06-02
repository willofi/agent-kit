# agent-kit Kiro-Style SDD Design

## Summary

Introduce `agents/sdd.md` as the single source of truth for the SDD protocol,
then reference it from repo entry files, downstream templates, Cursor rules,
README, and the `ai-pack sdd` preset.

## Requirements Mapping

- `REQ-001` to `REQ-006`: covered by `agents/sdd.md`.
- `REQ-007`: covered by thin adapters in `AGENTS.md`, `CLAUDE.md`,
  `templates/*`, and `cursor/rules.md`.
- `REQ-008`: covered by `bin/ai-pack`.
- `REQ-009`: covered by template edits only; scaffold targets remain unchanged.
- `REQ-010`: covered by README and `scripts/test.sh` updates.

## Approach

- Add `agents/sdd.md` with concise, tool-neutral rules for:
  - when to use SDD versus Quick Fix
  - `requirements.md` content and EARS examples
  - `design.md` content
  - `tasks.md` content and checkbox tracking
  - implementation gate and drift handling
- Keep `agents/core.md` and `agents/coding.md` as general engineering guidance.
  Add only a short SDD trigger to `core.md`.
- Reduce adapter duplication:
  - keep `AGENTS.md` as the repo-local source of truth
  - make `CLAUDE.md` a thin adapter that defers to `AGENTS.md` and shared docs
  - make `cursor/rules.md` a thin adapter
  - keep scaffolded templates standalone but shorter
- Add `sdd` to `ai-pack` without changing `ai-scaffold` targets.
- Update smoke tests to prevent preset, template, and context drift.

## Interfaces

- New shared doc: `agents/sdd.md`
- New preset: `ai-pack sdd`
- Existing scaffold creation targets remain: `agents`, `claude`, `all`.
  `list` remains a meta-command that prints creatable targets.
- New dogfood spec artifacts:
  - `specs/agent-kit-sdd/requirements.md`
  - `specs/agent-kit-sdd/design.md`
  - `specs/agent-kit-sdd/tasks.md`

## Validation

- Run `bash scripts/test.sh`.
- The test suite should verify:
  - shell syntax for changed scripts
  - `ai-pack list` includes `sdd`
  - `ai-pack sdd` includes `agents/architecture.md` and `agents/sdd.md`
  - scaffolded `AGENTS.md` and `CLAUDE.md` mention `agents/sdd.md`
  - `ai-context` lists `agents/sdd.md`

## Risks

- Over-forcing SDD can slow down small fixes. The protocol keeps an explicit
  Quick Fix path.
- Duplicating protocol text across adapters can drift. The full protocol lives
  in `agents/sdd.md`; adapters only reference it.
- Tool-specific `.kiro` scaffolding could make agent-kit less tool-neutral. This
  pass intentionally does not add it.
