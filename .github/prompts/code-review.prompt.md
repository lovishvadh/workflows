---
name: code-review
description: Review code, fix issues, and verify everything still works (Copilot)
agent: agent
tools: ['search/codebase']
---

Perform a **code review** of the code the user is asking about, **propose or apply fixes**, and **ensure everything still works**.

1. **Use this repo's rules** – Read and apply (each repo can have its own):
   - [.github/code-review-instructions.md](.github/code-review-instructions.md) – **Repo-specific AI code review rules** (what to check, severity, conventions). If this file exists, follow it first.
   - [.github/copilot-instructions.md](.github/copilot-instructions.md) (commit style, code style, no secrets)
   - [.github/code-review-rules.md](.github/code-review-rules.md) (forbidden patterns; script uses these too)

2. **Review and fix**:
   - List issues: consistency, `forbid:` violations, error handling, naming, security, missing tests.
   - For each issue, **propose a concrete fix**: exact code edits, snippets, or file changes. Apply edits in chat when possible so the user can accept them.
   - Suggest a Conventional Commits-style commit message for the change.

3. **Verify** – After the user applies your fixes:
   - Tell them to run the **Pre-PR check** or **Full check** task (lint, test, build). If anything fails, help them fix the failure (e.g. fix a test or adjust the code) and re-run until everything passes.
   - Confirm: "Everything still works" only after they report that the check passed or you help them resolve any failures.

**Output**: Summary (pass / needs changes) → issues with file/line → concrete fix for each → commit message suggestion → "Run **Pre-PR check** (or **Full check**) to verify; if something breaks, share the error and I’ll help fix it."

If the user shared a selection, focus on that; otherwise review the current file or ask what to review.
