---
name: api-review
description: Review API design for consistency and best practices (Copilot)
agent: agent
tools: ['search/codebase']
---

**Review** the API the user is asking about (new or changed endpoints, function signatures, request/response shapes, or client API).

1. **Use repo context** – Search the codebase for existing API patterns:
   - How routes/handlers are defined and how errors are returned
   - Naming (e.g. REST resources, RPC-style, or graph)
   - Auth, validation, and response format
   - Use [.github/copilot-instructions.md](.github/copilot-instructions.md) for style.

2. **Review for**:
   - **Consistency** – Same patterns as the rest of the codebase (status codes, error shape, pagination)
   - **REST/design norms** – If applicable: HTTP methods, idempotency, resource naming, status code choice
   - **Error handling** – Clear errors, appropriate codes, no leaking internals
   - **Versioning** – If the project versions APIs, suggest how this change fits
   - **Safety** – Auth on sensitive operations, input validation, rate limiting if relevant

3. **Output** – Provide:
   - Short verdict (e.g. "Looks good" / "Needs changes")
   - Bullet list of specific suggestions with file/line or snippet
   - Concrete improvements (e.g. "Return 404 here", "Add request validation for X")
   - Optional: small code or spec snippets for the suggested shape

4. **Verify** – If the user applies your suggestions, they should run the **Pre-PR check** or **Full check** task to ensure nothing is broken.

Focus on what the user pointed at (file, selection, or "this API"). No need to refactor unrelated code unless it's part of the same API surface.
