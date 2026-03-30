# Frontend Guidelines

Load this file when the task involves React, Next.js, or client-side state management.

## React

- Use functional components only.
- Keep components focused on rendering and interaction.
- Move growing logic out of the view layer into hooks or domain modules.
- Avoid putting business logic inside JSX callbacks.

## Next.js App Router

- Default to Server Components. Use `"use client"` only when interactivity or browser APIs are required.
- Keep `"use client"` boundaries as deep (leaf-level) as possible.
- Do not fetch data inside Client Components when a Server Component can do it.
- Use `loading.tsx` and `error.tsx` at the appropriate route segment level.
- Avoid mixing server and client concerns in the same component file.
- Prefer `generateMetadata` over `<Head>` for SEO.

## State Management

- Use the project's existing state strategy first.
- If Zustand is already present, keep stores small and domain-oriented.
- Keep derived values derived — do not duplicate state.
- Make side effects explicit and easy to trace.
- Do not reach for global state when local state or server state is enough.

## Data Fetching

- Prefer server-side fetching for initial data.
- Use TanStack Query (React Query) when the project already has it — do not introduce a second data-fetching layer.
- Keep query keys predictable and documented at the call site.
- Handle loading, error, and empty states explicitly.

## Styling

- Follow the project's existing styling approach (Tailwind, CSS Modules, etc.).
- Do not introduce a new styling system without a clear reason.
- Keep style co-located with the component unless the project separates them.

## Avoid

- `useEffect` for logic that belongs in event handlers or server-side code
- Client Components wrapping entire pages unnecessarily
- Global state spanning unrelated domains
- Components that own both complex state and complex rendering
