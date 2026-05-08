---
name: figma-component
description: Implement UI from Figma export JSON following style guidelines (Copilot)
agent: agent
tools: ['search/codebase']
argument-hint: "component name or path to latest.json"
---

Implement or refine a **UI component** from **Figma export data** in this repo, following **`docs/style-guidelines.md`**.

1. **Inputs** – The user points to:
   - **`design/figma/latest.json`** (or another export from `scripts/workflows/figma-sync.mjs fetch`), and/or
   - A **component name** to find in the JSON (search `document` tree for `COMPONENT`, `FRAME`, or matching `name`).

2. **Style rules** – Read and apply **[docs/style-guidelines.md](docs/style-guidelines.md)**:
   - Colors, typography, spacing tokens
   - Component naming alignment with the guidelines table
   - Accessibility notes from the guidelines

3. **Implementation** – Produce **production-quality** React (or the framework used in this repo—detect from existing components):
   - Match layout intent from Figma node data where reasonable (sizes, auto-layout hints).
   - Prefer **design tokens** and CSS variables from style guidelines over hard-coded hex values when listed.
   - Use existing **Button**, **Input**, or design-system imports if the codebase already has them (use codebase search).

4. **Output** – Concrete code edits or full file content; map **Figma component name → file path** consistent with style-guidelines component table. Remind the user to run **lint** and **test** tasks after edits.

If no export exists, tell them to run **`node scripts/workflows/figma-sync.mjs fetch <file_key>`** first (see **docs/Figma-API-Workflow.md**).
