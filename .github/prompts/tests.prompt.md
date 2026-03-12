---
name: tests
description: Generate unit or integration tests for current file or selection (Copilot)
agent: agent
tools: ['search/codebase']
---

Generate **unit or integration tests** for the code the user is asking about (current file, selection, or specified module).

1. **Use this repo's patterns** – Search the codebase for existing tests (e.g. `describe(`, `it(`, `test(`, `*.test.*`, `*.spec.*`) and match:
   - Test runner and style (Jest, Vitest, Mocha, etc.)
   - File naming and location
   - Assertion style and setup/teardown
   - Use [.github/copilot-instructions.md](.github/copilot-instructions.md) for code style.

2. **Coverage** – Generate tests that cover:
   - Main happy path and typical usage
   - Important edge cases and error paths
   - Key branches and boundary conditions
   - Mock or stub external deps the same way the rest of the project does

3. **Output** – Propose concrete test code (full file or snippet). Apply or suggest edits in chat so the user can accept them. If the user shared a selection, focus tests on that; otherwise cover the main behavior of the file.

4. **Verify** – Tell the user to run the **test** task (or `npm test` / project test command) to confirm the new tests pass. If something fails, help them fix it.

If the project has no tests yet, suggest a minimal test setup that fits the stack (e.g. Jest for Node/React, Vitest for Vite) and then generate the tests.
