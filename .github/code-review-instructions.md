# AI Code Review rules (this repo only)

This file is used **only** by the **`/code-review`** Copilot command. Add repo-specific rules so the AI reviews against your team’s standards. Other repos can have different content.

## What to put here

- **What to check:** e.g. “Always check error handling for async functions”, “Ensure new API routes have auth”.
- **Severity:** How to treat issues (e.g. “Block PR on X”, “Warn on Y”).
- **Conventions:** Naming, file layout, patterns this repo follows (e.g. “Use our `apiClient` for all HTTP calls”).
- **Must-have:** e.g. “New features must have tests”, “Changes to `lib/auth` need a security note”.
- **Out of scope:** What the reviewer can ignore (e.g. “Don’t comment on formatting; Prettier handles it”).

## Example (customize per repo)

```markdown
- **Auth:** All new routes under `/api` must use the shared `requireAuth` middleware.
- **Errors:** Use our `AppError` class; never throw raw strings.
- **Tests:** New or changed behavior must have unit tests; mention if only manual testing was done.
- **Secrets:** No new env vars without updating .env.example and the deployment doc.
- **Severity:** Treat missing error handling as "must fix"; style nits as "optional".
```

Keep this file focused so `/code-review` stays consistent for this repo.
