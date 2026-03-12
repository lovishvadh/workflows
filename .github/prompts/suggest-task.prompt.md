---
name: suggest-task
description: Break down a ticket or description into a task list (Copilot)
agent: agent
tools: ['search/codebase']
---

Turn a **ticket, requirement, or description** into a clear **task list** the team can execute.

1. **Input** – The user provides:
   - A ticket description, user story, or short paragraph of what needs to be done, or
   - Pasted text or a reference to a file/issue

   If they didn't provide anything, ask for a short description of the goal.

2. **Use repo context** – Optionally use codebase search to:
   - Infer where similar work lives (folders, layers, entry points)
   - Suggest concrete file or module names to touch
   - Align task names with existing patterns (e.g. "Add X in services/, update types in types/")

3. **Output** – Produce a structured task list:
   - **Ordered steps** – In a sensible order (e.g. types first, then impl, then tests, then docs)
   - **Per step** – Short title, one-line description, and optional "files to touch" or "checklist item"
   - **Optional sub-tasks** – If a step is large, break it into 2–3 sub-bullets
   - **Risks or dependencies** – Call out anything that might block (e.g. "Depends on API contract from backend"), or that needs design/decisions first

4. **Format** – Use markdown (numbered list or checklist). Keep it scannable so someone can pick it up and start working.

Example shape:
- 1. Add types for X in `src/types/...`
- 2. Implement Y in `src/services/...` (sub: validate input, call API, handle errors)
- 3. Add tests for Y
- 4. Update README / API docs
- Dependencies: Backend endpoint Z must be ready for step 2.
