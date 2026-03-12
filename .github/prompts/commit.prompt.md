---
name: commit
description: Suggest Conventional Commits-style commit messages from the diff (Copilot)
agent: agent
tools: ['search/codebase']
---

Suggest **1–3 commit message options** in Conventional Commits format for the changes the user is about to commit.

1. **Get the diff** – If the user hasn't provided it, ask them to paste the output of:
   - `git diff --staged` (staged changes), or
   - `git diff` (unstaged changes), or
   - A short summary of what changed (files and purpose)

2. **Use repo style** – Follow [.github/copilot-instructions.md](.github/copilot-instructions.md) for commit format:
   - Format: `type(scope): description`
   - Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
   - Lowercase description, imperative mood, no period at the end

3. **Output** – Give 1–3 options, from most to least specific. Optionally add a short body (blank line then paragraph) for the preferred one if the change warrants it. If scope is ambiguous, pick a reasonable one or offer alternatives.

Example format:
```
feat(auth): add login with email verification
fix(api): correct status code for validation errors
```
