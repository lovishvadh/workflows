---
name: create-pr
description: Generate PR description and reviewer report for a given target branch (Copilot)
agent: agent
tools: ['search/codebase']
argument-hint: "target branch (e.g. main or develop)"
---

Generate a **pull request description and reviewer report** so the team can open a PR that’s easy to review.

**Input:** The user may provide the **target branch** (e.g. `main`, `develop`). If not, use `main`. They may also paste the output of `git diff TARGET...HEAD --stat` or `git log TARGET..HEAD --oneline` (or the full diff) so you can analyze changes accurately.

**If they didn’t paste the diff:** Ask them to run:
```bash
git log main..HEAD --oneline
git diff main...HEAD --stat
```
(or replace `main` with their target branch) and paste the output, or share the list of changed files. You can also use codebase search to infer recent changes.

**Output:** Produce a single markdown document ready to use as the PR body, in this order:

1. **PR title (first line)**  
   One line, Conventional Commits style (e.g. `feat(auth): add login flow`). This will be used as the PR title.

2. **Description**  
   - What changed (short summary)
   - Why (goal, ticket if any)
   - How to test / verify

3. **Reviewer report**  
   Make the PR easier to review by adding:
   - **Summary of changes** – Bullet list of main changes (areas touched, not every file).
   - **Key files to review** – List 5–10 most important files with one line each on what to look at.
   - **Risk areas** – Anything subtle, breaking, or security-sensitive.
   - **Checklist for reviewer** – Short list (e.g. “Logic in X”, “Error handling in Y”, “Tests updated”).
   - **Testing done** – What was run (lint, tests, manual) and any caveats.

Use [.github/copilot-instructions.md](.github/copilot-instructions.md) for commit/PR style. Write in clear, concise markdown so the reviewer can scan quickly.

**After you output:** Tell the user to either:
- Save the whole output (including the first line as title) to **`.github/PR_DESCRIPTION.md`** and run the **Create PR** task, or  
- Copy the body (everything except the first line) into the GitHub PR form and use the first line as the title.

The **Create PR** task will use `.github/PR_DESCRIPTION.md` if it exists (first line = title, rest = body).
