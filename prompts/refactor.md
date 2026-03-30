# Refactor Guidelines

Load this file when the task is behavior-preserving cleanup — improving structure, readability, or maintainability without changing what the code does.

## Before Touching Code

- Identify the main problems: complexity, duplication, poor naming, unclear flow.
- Call out any behavior that is ambiguous before assuming it is safe to rewrite.
- If a refactor could change observable behavior, say so explicitly and get confirmation.

## Priorities, In Order

1. Readability — can a teammate follow this without asking questions?
2. Control flow — reduce nesting, flatten conditionals, remove dead branches.
3. Naming — rename when the current name is misleading or too vague.
4. Duplication — extract only when it genuinely reduces cognitive load, not just line count.
5. Performance — only when the gain is real, measurable, and low-risk.

## Constraints

- Preserve existing behavior unless a bug is clearly identified.
- Prefer small, obvious abstractions over clever frameworks.
- Keep changes focused — do not refactor adjacent code unless it is directly in the way.
- Avoid speculative architecture. Refactor for today's use case, not hypothetical future ones.

## Output Format

1. Brief diagnosis: what is wrong and why it matters.
2. Refactored code.
3. What changed and why — one line per meaningful change.
4. Any risks, edge cases, or follow-up improvements worth flagging.

## When To Stop

If the refactor requires understanding business context you do not have, stop and ask. A wrong refactor is worse than messy code.
