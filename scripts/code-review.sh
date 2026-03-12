#!/usr/bin/env bash
# Run automated code review: ESLint + optional repo rules from .github/code-review-rules.md
# Usage: ./scripts/workflows/code-review.sh [path or file]
# Use "Run Task > Code review" in VS Code. For full Copilot review, use Copilot Chat with @code and repo rules.

set -e
REPO_ROOT="${REPO_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null)}"
cd "$REPO_ROOT"

SCOPE="${1:-.}"
FAILED=0

echo "=== 1. Lint (ESLint) ==="
if [[ -f package.json ]] && grep -q '"lint"' package.json; then
  RUNNER="npm run"
  command -v pnpm &>/dev/null && RUNNER="pnpm run"
  command -v yarn &>/dev/null && RUNNER="yarn run"
  if $RUNNER lint -- "$SCOPE" 2>/dev/null; then
    echo "OK: ESLint"
  else
    FAILED=1
  fi
else
  echo "No lint script in package.json. Add one (e.g. eslint .)."
fi

echo ""
echo "=== 2. Repo rules (.github/code-review-rules.md) ==="
RULES_FILE=".github/code-review-rules.md"
if [[ ! -f "$RULES_FILE" ]]; then
  echo "No $RULES_FILE found. Create it to add custom checks (see workflows README)."
else
  # Lines like "forbid: <regex>" (leading/trailing space trimmed; # at start = comment)
  while IFS= read -r line; do
    line="$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    if [[ "$line" =~ ^forbid:[[:space:]]*(.*) ]]; then
      pattern="$(echo "${BASH_REMATCH[1]}" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
      [[ -z "$pattern" ]] && continue
      if git grep -n -E "$pattern" -- ":(exclude)$RULES_FILE" "$SCOPE" 2>/dev/null; then
        echo "REPO RULE VIOLATION (forbid): $pattern"
        FAILED=1
      fi
    fi
  done < "$RULES_FILE"
  echo "Repo rules checked."
fi

echo ""
echo "=== 3. Copilot / AI review ==="
echo "For full AI review: open Copilot Chat, reference .github/copilot-instructions.md and .github/code-review-instructions.md,"
echo "then run the /code-review slash command or ask: 'Review the changes in this branch against our repo rules.'"
echo "Or use GitHub PR Copilot review when opening the PR."

if [[ $FAILED -eq 1 ]]; then
  echo ""
  echo "Code review found issues. Fix them and re-run."
  exit 1
fi
echo "Automated code review passed."
