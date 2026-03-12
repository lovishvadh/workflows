---
name: docs
description: Generate or update JSDoc, TSDoc, or README for the target (Copilot)
agent: agent
tools: ['search/codebase']
---

Generate or **update documentation** for the code the user is asking about (current file, selected function/class, or module).

1. **Use repo style** – Search the codebase for existing JSDoc, TSDoc, or README style:
   - Tag usage (@param, @returns, @example, etc.)
   - Level of detail and tone
   - Use [.github/copilot-instructions.md](.github/copilot-instructions.md) for conventions.

2. **Produce** (as appropriate for the target):
   - **JSDoc/TSDoc** – For the main exports, functions, or classes: purpose, params, return value, throws, and a short example if helpful
   - **README section** – For a folder or package: what it does, how to use it, main entry points, and any env or config
   - **API summary** – For an API surface: list of endpoints or public methods with one-line descriptions

3. **Output** – Propose concrete doc text (comments or markdown). Apply or suggest edits in chat. If the file is large, document the most important parts first and optionally list "what else to document."

4. **Verify** – If you added or changed code comments, the user can run the **lint** or **Pre-PR check** task to ensure nothing is broken. No need to run tests for doc-only changes unless the project enforces doc checks.
