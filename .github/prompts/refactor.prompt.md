---
name: refactor
description: Refactor selected code to match codebase patterns (Copilot)
agent: agent
tools: ['search/codebase']
---

**Refactor** the code the user selected (or the current file) so it **matches patterns used elsewhere** in the codebase.

1. **Use this repo's rules** – Read [.github/copilot-instructions.md](.github/copilot-instructions.md) (code style, error handling, no secrets). Search the codebase for similar code (same layer, same kind of feature) and identify:
   - Error-handling style (e.g. try/catch, result types, custom errors)
   - API and naming patterns (e.g. how async is used, how modules are split)
   - Structure (e.g. where validation lives, how config is passed)

2. **Refactor** – Align the selected code to those patterns:
   - Propose concrete edits (snippets or full replacements). Apply or suggest edits in chat so the user can accept them.
   - Preserve behavior; only change structure, naming, and style to match the rest of the repo.
   - If something is ambiguous (e.g. two valid patterns), pick one and say why, or offer both options.

3. **Verify** – After the user applies your changes, tell them to run the **Pre-PR check** (or **Full check**) task. If lint, tests, or build fail, help them fix the failure and re-run until everything passes.

**Output**: Short summary of what you changed and why → concrete code changes → "Run **Pre-PR check** to verify; if something breaks, share the error and I'll help fix it."
