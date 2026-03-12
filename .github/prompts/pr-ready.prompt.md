---
name: pr-ready
description: Get branch PR-ready: find gaps, fix them, and verify everything works (Copilot)
agent: agent
tools: ['search/codebase']
---

Help the user get their **branch ready for a PR** by finding gaps, **fixing them**, and **verifying everything works**.

1. **Use repo rules** – Apply [.github/copilot-instructions.md](.github/copilot-instructions.md) and [.github/code-review-rules.md](.github/code-review-rules.md).

2. **Checklist and fix**:
   - Lint passes → if not, suggest or apply fixes, then they run the **lint** or **Pre-PR check** task.
   - Tests pass → if not, help fix failing tests.
   - No high/critical dependency vulnerabilities → tell them to run **Vulnerability scan and fix** task; if issues remain, help interpret or fix.
   - Commit messages follow Conventional Commits → suggest a message or fix.
   - No secrets in the diff → if found, suggest removal and use env/config.
   - Error handling and no glaring security issues → suggest or apply code fixes.

   For each "not done" item, **provide a concrete fix** (code edit, command, or step). Apply or suggest edits so the user can fix quickly.

3. **Verify** – After fixes:
   - Tell them to run the **Full check** (or **Pre-PR check**) task. If anything fails, help them fix it and re-run until everything passes.
   - Then suggest a PR title and description. Confirm "Ready for PR" only when the check passes.

**Output**: "Ready" / "Not ready" → checklist (done ✅ / to do ❌) with a one-line fix for each to-do → "Run **Full check** to verify; if something breaks, share the error and I’ll help fix it" → optional PR title/description.

If they have uncommitted changes or a branch, reason about what’s changed; if not, ask them to run **Pre-PR check** or **Full check** and share any failures so you can help fix and verify.
