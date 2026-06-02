# Backend Guidelines

Load this file when the task involves API design, database schema changes,
authentication, background jobs, or server-side logic.

Use the host project's backend stack, validation library, ORM/query layer, and
test runner unless the task explicitly calls for a change.

## Boundaries

- Keep route handlers thin; put business rules in services or domain modules.
- Validate incoming data at system boundaries with the project's existing tool.
- Keep request handling stateless unless the product needs coordination state.

## Data And Persistence

- Use the existing typed ORM or query builder when available.
- Track persistent schema changes through the project's migration process.
- Be explicit about transactions, especially across multiple writes.
- Avoid N+1 query paths; use pagination for collection endpoints.

## API Contracts

- For REST, follow resource naming and HTTP method conventions.
- For GraphQL, RPC, queues, or jobs, follow the established contract style.
- Keep error response shapes consistent and meaningful.

## Security

- Give database users and API keys only the permissions they need.
- Treat raw query inputs as injection risks even when an ORM is present.
- Never return passwords, hashes, tokens, secrets, or internal-only identifiers.

## Testing

- Prioritize API-to-database integration tests for persistence behavior.
- Fake third-party services at their boundary so tests stay deterministic.
