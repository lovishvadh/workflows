# Repository instructions for GitHub Copilot

Use these guidelines when suggesting code in this repository.

## Commit messages

- Use Conventional Commits: `type(scope): description` (e.g. `feat(auth): add login`, `fix(api): correct status code`).
- Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert.

## Code style

- Follow existing patterns in the file and in the codebase.
- Prefer small, focused functions and clear naming.
- Add or update tests when changing behavior.
- Do not add secrets, API keys, or credentials.

## Before suggesting

- Prefer the same error-handling and logging style as the rest of the project.
- Match existing formatting (this repo uses EditorConfig and format-on-save).
- When adding dependencies, use the same package manager and version style as the project.
