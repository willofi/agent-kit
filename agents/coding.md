# Coding Guidelines

Use the host project's primary language, framework, and tooling unless the task explicitly calls for a change. Project-local conventions should beat generic preferences.

## Language And Tooling

- Prefer the stack already used by the project.
- When TypeScript is available, use strict types and avoid `any` unless the boundary is genuinely dynamic.
- Model the domain with names and types, not with comments or generic wrappers.
- Add dependencies only when they remove real repeated pain.

## Code Organization

- Keep files cohesive and responsibilities explicit.
- Separate rendering, state coordination, domain logic, and external I/O where the project has those layers.
- Prefer small interfaces and directional data flow.
- Co-locate code that changes together.
- Avoid circular dependencies.

## Frontend And State

If the project uses React:

- use functional components
- keep components focused on rendering and interaction
- move growing logic out of the view layer

For shared state:

- use the project's existing state strategy first
- if Zustand is already present, keep stores small and domain-oriented
- keep derived values derived
- make side effects easy to trace

## Services And Backend

- Validate inputs at system boundaries.
- Keep business rules separate from transport, persistence, and third-party integrations.
- Make failure paths and async flows easy to follow.

## Implementation Preferences

- Prefer guard clauses over deep nesting.
- Prefer clear branching over compressed expressions.
- Use domain names, not implementation-detail names.
- Make invalid states hard to represent.
- Match the local style unless it is clearly harmful.

## Testing

- Test behavior, not implementation trivia.
- Cover domain logic and state transitions first.
- Add integration or UI tests where regressions are easy to miss.
- Do not use mocking to hide weak design.

## Avoid

- patterns that fight the host codebase for no clear gain
- giant shared state containers spanning unrelated domains
- business logic buried inside UI templates or transport handlers
- utility files that become junk drawers
- abstractions so generic that they erase meaning

The target is a codebase where a teammate can find the logic, trace the data flow, and change the feature without touching unrelated layers.
