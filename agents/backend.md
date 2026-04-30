# Backend Guidelines

Load this file when the task involves API design, database schema changes, authentication, background jobs, or server-side logic.

Use the host project's backend stack, validation library, ORM/query layer, and test runner unless the task explicitly calls for a change.

## Architecture & Logic

- Separation of Concerns: Keep controllers and route handlers thin. Move business rules into service layers or domain modules.
- Stateless Design: Prefer stateless request handling so the service can scale horizontally, unless the product explicitly requires stateful coordination.
- Validation: Validate incoming data at system boundaries with the project's schema or validation tool. In TypeScript projects, use Zod when it is already present or intentionally chosen.

## Database & Type Safety

- Type-Safe Queries: Use the project's existing typed ORM or query builder when available, such as Drizzle, Prisma, Kysely, or the local equivalent.
- Migration First: For persistent schema changes, use the project's migration process to track database evolution.
- Transaction Management: Be explicit about database transactions, especially for operations involving multiple table writes.

## HTTP API Design

- Predictable Endpoints: For REST APIs, follow resource-oriented naming and HTTP method conventions. For GraphQL, RPC, or queues, follow the project's established contract style.
- Error Handling: Use consistent error response structures. Provide meaningful HTTP status codes and error messages.
- Performance: Use pagination for collection endpoints and avoid N+1 query problems by using proper joins or includes.

## Security

- Principle of Least Privilege: Ensure database users and API keys have only the minimum necessary permissions.
- Sanitization: Even with an ORM, be cautious of raw query inputs to prevent SQL injection.
- Sensitive Data: Never return sensitive fields such as passwords, password hashes, tokens, secrets, or internal-only identifiers in API responses.

## Testing

- Test-First Loop: When behavior is clear, write or update the failing test first, then implement the smallest change that makes it pass.
- Integration Tests: Prioritize testing the integration between the API layer and the database for behavior that crosses persistence boundaries.
- External Services: Replace third-party services such as payment gateways and mailers with fakes or mocks at the boundary so tests stay fast and deterministic.
