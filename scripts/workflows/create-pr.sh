#!/usr/bin/env bash
# Create a PR after running pre-PR checks. Uses GitHub CLI (gh).
# Usage: ./scripts/workflows/create-pr.sh [--skip-checks] [--draft]
# Run from repo root. Requires: gh, and optionally npm/pnpm/yarn for checks.

set -e
REPO_ROOT="${REPO_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null)}"
cd "$REPO_ROOT"

SKIP_CHECKS=false
DRAFT=""
BASE_BRANCH="${PR_BASE_BRANCH:-}"
while [[ $# -gt 0 ]]; do
  case $1 in
    --skip-checks)   SKIP_CHECKS=true ;;
    --draft)         DRAFT="--draft" ;;
    --base)          BASE_BRANCH="${2:?--base requires branch name}"; shift ;;
    *)               break ;;
  esac
  shift
done

if ! command -v gh &>/dev/null; then
  echo "Error: GitHub CLI (gh) is required. Install: https://cli.github.com/"
  exit 1
fi

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "Error: Not a git repository."
  exit 1
fi

BRANCH=$(git branch --show-current)
if [[ "$BRANCH" == "main" || "$BRANCH" == "master" ]]; then
  echo "Error: Create a feature branch first. You are on '$BRANCH'."
  exit 1
fi

# Optional: run pre-PR check unless --skip-checks
if [[ "$SKIP_CHECKS" != "true" ]]; then
  if [[ -f "package.json" ]]; then
    echo "Running pre-PR check (lint, test, audit)..."
    RUNNER="npm run"
    command -v pnpm &>/dev/null && RUNNER="pnpm run"
    command -v yarn &>/dev/null && RUNNER="yarn run"
    if grep -q '"lint"' package.json; then $RUNNER lint || true; fi
    if grep -q '"test"' package.json; then $RUNNER test || true; fi
    if grep -q '"typecheck"' package.json; then $RUNNER typecheck || true; fi
    npm audit --audit-level=high 2>/dev/null || true
  fi
fi

# Push current branch
echo "Pushing branch '$BRANCH'..."
git push -u origin "$BRANCH" 2>/dev/null || git push origin "$BRANCH"

# PR body: prefer generated description (from /create-pr Copilot command) then template then --fill
PR_BODY_FILE="${PR_BODY_FILE:-.github/PR_DESCRIPTION.md}"
TEMPLATE=""
for f in .github/PULL_REQUEST_TEMPLATE.md .github/pull_request_template.md; do
  [[ -f "$f" ]] && { TEMPLATE="$f"; break; }
done

BASE_ARGS=""
[[ -n "$BASE_BRANCH" ]] && BASE_ARGS="--base $BASE_BRANCH"

echo "Creating pull request..."
if [[ -f "$PR_BODY_FILE" ]]; then
  # First line = title, rest = body (from /create-pr Copilot command)
  PR_TITLE=$(head -1 "$PR_BODY_FILE" | tr -d '\r')
  BODY_FILE=$(mktemp)
  tail -n +2 "$PR_BODY_FILE" > "$BODY_FILE"
  gh pr create $DRAFT $BASE_ARGS --title "$PR_TITLE" --body-file "$BODY_FILE"
  rm -f "$BODY_FILE"
elif [[ -n "$TEMPLATE" ]]; then
  gh pr create $DRAFT $BASE_ARGS --fill --body-file "$TEMPLATE"
else
  gh pr create $DRAFT $BASE_ARGS --fill
fi

echo "Done. PR created for branch '$BRANCH'."
