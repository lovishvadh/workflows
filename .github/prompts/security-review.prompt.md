---
name: security-review
description: Security review, fix issues, and verify everything still works (Copilot)
agent: agent
tools: ['search/codebase']
---

Perform a **security review** of the code or API the user is asking about, **fix the issues**, and **verify everything still works**.

1. **Use repo context** – Apply [.github/copilot-instructions.md](.github/copilot-instructions.md) and security patterns in the codebase.

2. **Find and fix**:
   - **Check for**: Hardcoded secrets, unvalidated input (injection, XSS), missing auth on sensitive endpoints, sensitive data in logs, unsafe dependencies or usage (eval, etc.), weak rate limiting/CORS/headers.
   - **For each finding**: Give a TODO list by priority (high / medium / low) with file/line or snippet, then **propose a concrete fix** (exact code changes, config, or steps). Apply or suggest edits so the user can apply them.

3. **Verify** – After fixes are applied:
   - Tell the user to run the **Pre-PR check** or **Full check** task. If lint, tests, or build fail, help them fix the breakage and re-run until everything passes.
   - Confirm everything still works only after the check passes.

**Output**: Verdict → TODO list with severity → concrete fix for each (code or steps) → "Run **Pre-PR check** (or **Full check**) to verify; if something breaks, share the error and I’ll help fix it."

Focus on what the user pointed at (file, selection, or API); use codebase search to match existing auth/validation patterns.
