---
name: changelog
description: Draft changelog or release notes from commits (Copilot)
agent: agent
tools: ['search/codebase']
---

Generate a **draft changelog or release notes** from the commit history.

1. **Input** – The user should provide:
   - The **base ref** (e.g. `main`, `develop`, or a tag like `v1.0.0`). If not given, use `main`.
   - Optionally paste the output of `git log BASE..HEAD --oneline` or `git log BASE..HEAD --pretty=format:"%s"` so you have exact commit messages.

2. **Use repo style** – Follow [.github/copilot-instructions.md](.github/copilot-instructions.md): commits are in Conventional Commits form (feat, fix, docs, etc.). Group and format the changelog accordingly.

3. **Output** – Produce a markdown changelog with:
   - **Grouping by type** – e.g. "## Features", "## Bug fixes", "## Documentation", "## Chore"
   - **User-facing entries** – One line per change (or per logical group), in plain language (not raw commit messages unless they're already clear)
   - **Optional** – Version heading (e.g. "## [Unreleased]" or "## 1.2.0") if the user specified a version

4. **Tone** – Suitable for release notes: clear, concise, and useful for someone reading "what changed" without reading the repo. Skip internal or trivial commits if they add noise.

If the user didn't paste the log, ask them to run `git log main..HEAD --oneline` (or their base) and paste it, or describe the release range.
