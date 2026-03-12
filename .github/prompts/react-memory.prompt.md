---
name: react-memory
description: Find React memory leaks, fix them, and verify everything still works (Copilot)
agent: agent
tools: ['search/codebase']
---

Review the **React** code for **memory leaks**, **propose or apply fixes**, and **verify everything still works**.

1. **Find** – Check for:
   - `useEffect` with `addEventListener` but no `removeEventListener` in cleanup
   - `useEffect` with `setInterval` / `setTimeout` but no `clearInterval` / `clearTimeout` in cleanup
   - Subscriptions (e.g. `.subscribe()`) without `unsubscribe` in cleanup
   - Async operations (fetch then setState) that may run after unmount – suggest AbortController or isMounted
   - Large objects/caches in refs or module scope that are never cleared

   Use [.github/copilot-instructions.md](.github/copilot-instructions.md) and existing cleanup patterns in the codebase.

2. **Fix** – For each finding:
   - Give file/line or snippet, what can leak, and **concrete fix**: e.g. return a cleanup function from `useEffect`, add `removeEventListener` / `clearInterval` / `unsubscribe`, or use AbortController for fetch. Apply or suggest edits in chat so the user can apply them.

3. **Verify** – After the user applies your fixes:
   - Tell them to run the **Pre-PR check** or **Full check** task (and **React memory-leak check** task if they use it). If tests or build fail, help them fix the failure and re-run until everything passes.
   - Confirm everything still works only after the check passes.

**Output**: Summary (no issues / cleanup needed) → each finding with fix (code/snippet) → "Run **Pre-PR check** (or **Full check**) to verify; if something breaks, share the error and I’ll help fix it."

Focus on the file or selection the user shared; use codebase search to match how similar components do cleanup.
