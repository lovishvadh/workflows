---
name: upgrade-dep
description: Guide dependency upgrade and suggest code/config changes (Copilot)
agent: agent
tools: ['search/codebase']
argument-hint: "package name or package@version (e.g. react@19 or lodash)"
---

Help the user **upgrade a dependency** (e.g. a major version bump) and keep the project working.

1. **Input** – The user provides the **package name** (and optionally version, e.g. `react@19` or `lodash`). If not provided, ask which dependency they want to upgrade.

2. **Search** – Use codebase search to find:
   - Where the package is used (imports, require, config)
   - Lockfile or manifest (package.json, etc.) that declares the dependency
   - Tests or docs that reference the old API

3. **Breaking changes** – From your knowledge of the package (or common major-version patterns), list:
   - **Breaking changes** that likely affect this repo
   - **Affected files** or call sites
   - **Config or build** changes (e.g. new peer deps, new options)

4. **Fix** – Propose concrete updates:
   - Version change in package.json (or equivalent)
   - Code changes at each affected call site (imports, API usage, types)
   - Config changes (tsconfig, bundler, etc.) if needed
   Apply or suggest edits in chat so the user can apply them.

5. **Verify** – Tell the user to run **Pre-PR check** (or **Full check**): install deps (`npm install` / `pnpm install`), then run lint, tests, and build. If something fails (e.g. type errors, test failures), help them fix it and re-run.

Use [.github/copilot-instructions.md](.github/copilot-instructions.md) for package manager and code style.
