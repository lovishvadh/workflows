# VS Code + Copilot Workflows

Reusable **VS Code and GitHub Copilot** setup for development teams. Use this in your repos to get **consistent editor behavior**, **shared tasks**, and **automated workflows** (PRs, code review, security, React memory checks). All commands and prompts work in **VS Code with GitHub Copilot** only.

## What’s included

| Item | Purpose |
|------|--------|
| **`.vscode/settings.json`** | Format on save, Copilot defaults, Git behavior, shared editor rules |
| **`.vscode/extensions.json`** | Recommended extensions (Copilot, ESLint, Prettier, GitLens, EditorConfig, etc.) |
| **`.vscode/tasks.json`** | All tasks below: Create PR, Pre-PR check, Code review, Security audit, React memory check, etc. |
| **`.vscode/launch.json`** | Debug configs for tests and current script |
| **`.editorconfig`** | Indent, line endings, trim whitespace (works across editors) |
| **`.github/copilot-instructions.md`** | Repo-level instructions for GitHub Copilot in VS Code |
| **`.github/code-review-rules.md`** | Custom rules for the **Code review** task (forbid patterns via regex) |
| **`.github/code-review-instructions.md`** | **Per-repo AI code review rules** – used only by the **`/code-review`** Copilot command (what to check, severity, conventions) |
| **`.github/prompts/*.prompt.md`** | **Copilot Chat slash commands** – type `/code-review`, `/security-review`, etc. in Copilot Chat to run AI tasks |
| **`scripts/workflows/*.sh`** | Scripts for Create PR, Pre-PR check, Security audit, Code review, Sync branch, Full check |
| **`scripts/workflows/react-memory-check.js`** | React memory-leak pattern checker (useEffect cleanup, subscriptions, timers) |

## Commands you can run in VS Code

Use **Terminal → Run Task** (or `Cmd+Shift+P` → “Tasks: Run Task”) and pick one:

| Task | What it does |
|------|----------------|
| **Create PR** | Pushes branch and opens PR. If `.github/PR_DESCRIPTION.md` exists (from **`/create-pr`** in Chat), uses its first line as title and rest as body; otherwise uses PR template or `gh pr create --fill`. |
| **Create PR (draft, skip checks)** | Same but creates a draft PR and skips lint/test. |
| **Create PR to branch…** | In terminal: `PR_BASE_BRANCH=develop ./scripts/workflows/create-pr.sh` or add a task with `--base develop` to target a specific branch. |
| **Pre-PR check** | Lint + test + typecheck + build + `npm audit` (high/critical). |
| **Full check** | Pre-PR check + security audit + React memory-leak check (if React app). |
| **Code review (lint + repo rules)** | Runs ESLint and checks `.github/code-review-rules.md` (forbid patterns). For AI review, use **`/code-review`** in Copilot Chat. |
| **Security audit** | Dependency audit (npm/pnpm/yarn) + optional Semgrep. |
| **Vulnerability scan** | `npm audit` with clear pass/fail for high/critical. |
| **Vulnerability scan and fix** | Runs `npm audit fix`, then **Pre-PR check** (lint, test, build, audit) so fixes don’t break anything. |
| **React memory-leak check** | Scans for addEventListener/subscribe/setInterval/setTimeout without cleanup in `useEffect`. |
| **Sync branch with main** | Fetch and rebase current branch onto `main`/`master`. |
| **lint** / **test** / **build** / **pre-commit check** | Standard project scripts. |

All of these are **one command** in VS Code.

## Copilot Chat commands (slash commands)

These use **Copilot Chat** to run the task with AI. In the Chat panel, type **`/`** and pick a command (or run **Chat: Run Prompt** from the Command Palette and select one):

| Slash command | What Copilot does |
|---------------|-------------------|
| **`/code-review`** | Reviews against repo rules, **proposes or applies fixes**, then asks you to run **Pre-PR check** / **Full check** and helps fix anything that breaks. |
| **`/security-review`** | Security review (secrets, validation, auth, etc.), **proposes fixes** for each finding, then verifies via **Pre-PR check** / **Full check**. |
| **`/vulnerability-scan`** | Finds vulns in code and deps, **suggests fixes** (and **Vulnerability scan and fix** task for deps), then verifies everything still works. |
| **`/react-memory`** | Finds React memory leaks, **proposes cleanup fixes**, then verifies via **Pre-PR check** / **Full check**. |
| **`/pr-ready`** | PR checklist, **fixes each gap** (lint, test, audit, commits, secrets), then verifies with **Full check** and suggests PR title/description. |
| **`/create-pr`** | Generates a **PR description and reviewer report** for a given target branch. You can paste `git diff main...HEAD --stat` and `git log main..HEAD --oneline` (or your base branch). Output: PR title (first line), description (what/why/how to test), and **reviewer report** (summary, key files, risk areas, checklist). Save the output to `.github/PR_DESCRIPTION.md`, then run the **Create PR** task. |
| **`/tests`** | Generates unit or integration tests for the current file or selection; matches existing test style and runner; suggests running the **test** task to verify. |
| **`/explain`** | Explains the selected code, file, or folder: what it does, how it fits in the repo, where it's used, and related files. No code changes. |
| **`/commit`** | Suggests 1–3 Conventional Commits-style commit messages from the current diff (or staged changes). User can paste `git diff` or `git diff --staged` if needed. |
| **`/refactor`** | Refactors selected code to match patterns used elsewhere in the codebase; proposes concrete edits; reminds you to run **Pre-PR check** to verify. |
| **`/docs`** | Generates or updates JSDoc, TSDoc, or README for the current file/module; follows existing doc style; optionally lists what else to document. |
| **`/debug`** | User pastes an error (test, lint, or build failure). AI suggests likely cause, where to look, and a concrete fix; reminds you to re-run the failing command to verify. |
| **`/changelog`** | From a base ref (e.g. `main`) and commit history: produces a draft changelog or release-notes section grouped by type (feat/fix/etc.) with user-facing summaries. |
| **`/api-review`** | Reviews new or changed API (signatures, routes, request/response) for consistency with the codebase and best practices; suggests improvements; verify with **Pre-PR check**. |
| **`/upgrade-dep`** | For a given dependency (e.g. `react@19`): lists breaking changes and affected files, suggests code/config updates; reminds you to run tests and typecheck. |
| **`/suggest-task`** | From a ticket description or pasted text: outputs a task list (steps, order, files to touch), optional sub-tasks, and risks/dependencies. |

Commands that change code follow **find → fix → verify**: find issues, propose or apply fixes, then have you run **Pre-PR check** or **Full check** and help fix any breakage so **everything still works**. Others (e.g. **`/explain`**, **`/commit`**, **`/changelog`**, **`/suggest-task`**) only explain or generate. Prompt files live in **`.github/prompts/`**; **copy-to-repo** copies all of them into the target repo.

### AI code review rules (per repo)

The **`/code-review`** Copilot command uses **three** sources of rules; the first is **separate per repo**:

1. **`.github/code-review-instructions.md`** (optional) – **Repo-specific rules for AI code review only.** Edit this file in each repo to define what the AI should check, severity (e.g. “must fix” vs “nits”), conventions (e.g. “use our auth middleware”), and must-haves (e.g. “new code must have tests”). Other repos can have completely different content. If the file exists, Copilot follows it first when you run `/code-review`.
2. **`.github/copilot-instructions.md`** – General repo instructions (commit style, code style, no secrets).
3. **`.github/code-review-rules.md`** – Forbidden patterns (`forbid: <regex>`); also used by the **Code review** script.

So: **yes, there is a Copilot command for AI code review (`/code-review`)**, and you can provide **separate rules per repo** by editing **`.github/code-review-instructions.md`** in that repo.

## How to use in a repo

### Option A: Copy into an existing repo

From this repo’s root, run:

```bash
./scripts/copy-to-repo.sh /path/to/your/repo
```

That copies `.vscode/`, `.editorconfig/`, `.github/` (copilot-instructions, code-review-rules, code-review-instructions, and **prompts**), and **`scripts/workflows/`** into the target repo. Tasks and Copilot slash commands work in VS Code with Copilot.

Then:

1. **Adjust `.vscode/tasks.json`** – Ensure `lint` / `test` / `build` match your `package.json` scripts.
2. **Adjust `.vscode/launch.json`** – Match your test runner (Jest, Vitest, Mocha).
3. **Edit `.github/code-review-instructions.md`** – Add **per-repo AI code review rules** for **`/code-review`** (what to check, severity, conventions). Each repo can have different rules.
4. **Edit `.github/code-review-rules.md`** – Add `forbid: <regex>` lines so the Code review **script** fails on patterns you don’t want (e.g. `console\.log`, `eval\s*\(`).
5. **Edit `.github/copilot-instructions.md`** – Add repo-specific conventions for Copilot (commit style, code style, API patterns).

### Option B: Clone and use as reference

Keep this repo as a “workflows” reference and manually add or merge the files above into each repo. Prefer Option A if you want the same setup everywhere and are okay customizing per repo.

## Team workflow with Copilot

1. **Open the repo in VS Code** – VS Code will suggest installing recommended extensions (including GitHub Copilot).
2. **Use Copilot** – Inline completions and chat follow `.github/copilot-instructions.md`; slash commands use `.github/prompts/` and `.github/code-review-instructions.md`.
3. **Run tasks** – **Terminal → Run Task** for **Create PR**, **Pre-PR check**, **Code review**, **Security audit**, **React memory-leak check**, **Sync branch**, etc.
4. **Before PR** – Run **Full check** (or **Pre-PR check**). In Copilot Chat run **`/create-pr`** (optionally with target branch and paste of `git diff main...HEAD --stat`), save the output to **`.github/PR_DESCRIPTION.md`**, then run **Create PR** so the PR has a proper description and reviewer report.
5. **AI code review** – Run **Code review** task for lint + repo rules; in Copilot Chat type **`/code-review`** (or **`/pr-ready`**) for full AI review against repo rules.
6. **Before commit** – Run **pre-commit check**, then commit with a Conventional Commit message.

## Customization ideas

- **Multiple runtimes** – Duplicate tasks in `tasks.json` for `npm`, `pnpm`, `yarn`, or `make`.
- **Monorepos** – Use a VS Code multi-root workspace (`.code-workspace`) and per-folder `.vscode` if needed.
- **Stricter lint** – In `settings.json`, enable `editor.codeActionsOnSave` with `source.fixAll` and `source.organizeImports` (already set in this template).
- **Branch naming** – Add a Copilot instruction in `.github/copilot-instructions.md` to suggest branch names (e.g. `feat/scope-short-description`).
- **Code review rules** – Add more `forbid:` patterns in `.github/code-review-rules.md`; use Copilot instructions for style and architecture.
- **Semgrep** – Install Semgrep and run **Security audit** for static security rules; add custom rules in `.semgrep/`.

## Requirements

- **VS Code** with **GitHub Copilot** (extension: GitHub Copilot, GitHub Copilot Chat). All workflows and AI commands are designed for this setup only.
- **Node/npm** for the default tasks and workflow scripts; change `tasks.json` and `launch.json` for other runtimes.
- **GitHub CLI (`gh`)** for **Create PR**; install from [cli.github.com](https://cli.github.com/).

## License / usage

Use and adapt this setup for your organisation. No license file is included; treat it as internal template code.
