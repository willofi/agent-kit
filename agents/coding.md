# Coding Guidelines

Use the host project's primary language, framework, and tooling unless the task explicitly calls for a change. Project-local conventions override these defaults.

## Language And Tooling

- Prefer the stack already present in the project.
- When TypeScript is available, use strict types and avoid `any` unless the boundary is genuinely dynamic.
- Model the domain with names and types, not with comments or generic wrappers.
- Add dependencies only when they remove real repeated pain.

## Code Organization

- Keep files cohesive and responsibilities explicit.
- Separate domain logic, external I/O, and transport concerns where the project has those layers.
- Prefer small interfaces and directional data flow.
- Co-locate code that changes together.
- Avoid circular dependencies.

## Implementation Preferences

- Prefer guard clauses over deep nesting.
- Prefer clear branching over compressed expressions.
- Use domain names, not implementation-detail names.
- Make invalid states hard to represent.
- Match the local style unless it is clearly harmful.

## Services And Backend

- Validate inputs at system boundaries.
- Keep business rules separate from transport, persistence, and third-party integrations.
- Make failure paths and async flows easy to follow.
- Return meaningful errors — not just status codes.

## Testing

- Test behavior, not implementation trivia.
- Cover domain logic and state transitions first.
- Add integration tests where regressions are easy to miss.
- Do not use mocking to hide weak design.
- If no reliable automated test exists, say so and describe the manual validation performed.

## Avoid

- patterns that fight the host codebase for no clear gain
- business logic buried inside transport handlers or UI templates
- utility files that become junk drawers
- abstractions so generic that they erase meaning
- mixing formatting churn with behavior changes

The target is a codebase where a teammate can find the logic, trace the data flow, and change the feature without touching unrelated layers.
