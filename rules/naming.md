# Naming Conventions

Use names that reveal intent, not shorthand known only to the original author.

## Core Conventions

- `camelCase` for variables, functions, object properties, and local helpers
- `PascalCase` for components, types, interfaces, classes, and enums
- `UPPER_SNAKE_CASE` for compile-time constants and environment variables

## Practical Rules

- Prefer full words over unclear abbreviations.
- Name by domain meaning, not temporary implementation detail.
- Avoid vague placeholders such as `data`, `item`, `value`, or `handler` when a more specific name exists.
- Boolean names should read like facts or questions, such as `isReady`, `hasAccess`, or `shouldRetry`.
- Collections should be plural.

## Example

```ts
const retryCount = 3;
const isFeatureEnabled = true;

function buildRequestPayload() {}

interface UserProfile {}

const API_TIMEOUT_MS = 5_000;
```

## Avoid

- single-letter names outside tiny, obvious scopes
- overloaded names reused for different concepts
- misleading names that age badly after refactors
- inconsistent acronym usage

Good naming should reduce the need for comments.
