#!/usr/bin/env/bash
# Copy VS Code + Copilot workflow into a target repo.
# Usage: ./scripts/copy-to-repo.sh /path/to/your/repo

set -e
WORKFLOWS_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:?Usage: $0 /path/to/target/repo}"

if [[ ! -d "$TARGET" ]]; then
  echo "Error: Target is not a directory: $TARGET"
  exit 1
fi

echo "Copying workflow from $WORKFLOWS_ROOT to $TARGET (VS Code + Copilot only)"
cp -r "$WORKFLOWS_ROOT/.vscode" "$TARGET/"
cp "$WORKFLOWS_ROOT/.editorconfig" "$TARGET/"
mkdir -p "$TARGET/.github"
cp "$WORKFLOWS_ROOT/.github/copilot-instructions.md" "$TARGET/.github/"
cp "$WORKFLOWS_ROOT/.github/code-review-rules.md" "$TARGET/.github/" 2>/dev/null || true
cp "$WORKFLOWS_ROOT/.github/code-review-instructions.md" "$TARGET/.github/" 2>/dev/null || true
mkdir -p "$TARGET/.github/prompts"
for f in "$WORKFLOWS_ROOT/.github/prompts/"*.prompt.md; do
  [[ -f "$f" ]] && cp "$f" "$TARGET/.github/prompts/"
done

mkdir -p "$TARGET/scripts/workflows"
for f in "$WORKFLOWS_ROOT/scripts/workflows/"*.sh "$WORKFLOWS_ROOT/scripts/workflows/"*.js "$WORKFLOWS_ROOT/scripts/workflows/"*.mjs; do
  [[ -f "$f" ]] || continue
  cp "$f" "$TARGET/scripts/workflows/"
  chmod +x "$TARGET/scripts/workflows/$(basename "$f")" 2>/dev/null || true
done

mkdir -p "$TARGET/docs"
for f in "$WORKFLOWS_ROOT/docs/style-guidelines.md" "$WORKFLOWS_ROOT/docs/Figma-API-Workflow.md" "$WORKFLOWS_ROOT/docs/Integrated-Workflow.md"; do
  [[ -f "$f" ]] && cp "$f" "$TARGET/docs/"
done
mkdir -p "$TARGET/design/figma"
[[ -f "$WORKFLOWS_ROOT/design/figma/.gitkeep" ]] && cp "$WORKFLOWS_ROOT/design/figma/.gitkeep" "$TARGET/design/figma/" 2>/dev/null || true
cp "$WORKFLOWS_ROOT/.env.example" "$TARGET/" 2>/dev/null || true

echo "Done. Next steps:"
echo "  1. Edit $TARGET/.vscode/tasks.json (lint/test/build commands for your repo)"
echo "  2. Edit $TARGET/.vscode/launch.json if your test runner differs"
echo "  3. Edit $TARGET/.github/code-review-instructions.md (per-repo AI code review rules for /code-review)"
echo "  4. Edit $TARGET/.github/copilot-instructions.md with repo-specific rules"
echo "  5. Customize .github/code-review-rules.md (forbid: patterns for the script)"
echo "  6. For Figma: copy .env.example to .env, set FIGMA_ACCESS_TOKEN, see docs/Figma-API-Workflow.md"
echo "     End-to-end flow (story → ship): docs/Integrated-Workflow.md"
echo "  7. Commit and push so the team gets recommended extensions on open"
echo "  Run Task: Create PR, Pre-PR check, Figma: fetch, Code review, etc."
echo "  In Copilot Chat: /code-review, /figma-component, /ticket-to-tests, etc."
