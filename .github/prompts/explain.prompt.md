---
name: explain
description: Explain code, file, or folder for onboarding and context (Copilot)
agent: agent
tools: ['search/codebase']
---

**Explain** the code the user is asking about (selection, current file, or folder). No code changes.

1. **Scope** – If they shared a selection, explain that. If they shared a file or path, explain that file or folder and how it fits in the repo.

2. **Provide**:
   - **What it does** – Short summary of purpose and main responsibilities
   - **How it fits** – Where it sits in the project (e.g. "API layer", "auth helpers")
   - **Key concepts** – Important types, functions, or patterns used
   - **Where it's used** – Callers or entry points if you can find them via codebase search
   - **Related files** – Point to closely related modules or config (as markdown links or paths)

3. **Tone** – Clear and concise so a new team member or someone switching context can understand quickly. Avoid jargon unless the codebase uses it.

Do not suggest edits or refactors unless the user asks. Focus on explanation only.
