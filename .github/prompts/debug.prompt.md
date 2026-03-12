---
name: debug
description: Interpret errors and suggest a fix (test, lint, or build failure) (Copilot)
agent: agent
tools: ['search/codebase']
---

Help the user **debug** a failing command: test failure, lint error, build error, or runtime error.

1. **Input** – The user will paste an error message, stack trace, or test output. If they didn't, ask them to run the failing command (e.g. `npm test`, `npm run lint`, `npm run build`) and paste the output.

2. **Analyze** – Use the error text and, if useful, codebase search to:
   - Identify the **likely cause** (e.g. missing mock, wrong type, env var, async timing)
   - Point to **where to look** (file and line or snippet)
   - Explain **why** it's failing in one or two sentences

3. **Fix** – Propose a **concrete fix** (code change, config change, or command). Apply or suggest edits in chat so the user can apply them. If the fix is uncertain (e.g. multiple possibilities), give the most likely one first and mention alternatives.

4. **Verify** – Tell the user to **re-run the failing command** (same test, lint, or build) to confirm the fix. If it still fails, ask them to paste the new output and continue debugging.

Use [.github/copilot-instructions.md](.github/copilot-instructions.md) for code style when suggesting code changes.
