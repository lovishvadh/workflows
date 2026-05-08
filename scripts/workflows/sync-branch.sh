#!/usr/bin/env bash
# Sync current branch with main (or master): fetch and rebase.
# Usage: ./scripts/workflows/sync-branch.sh
# Run from repo root. Ensures you're up to date before creating a PR.

set -e
REPO_ROOT="${REPO_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null)}"
cd "$REPO_ROOT"

MAIN="main"
git show-ref -q refs/heads/master && MAIN="master"

echo "Fetching and rebasing onto $MAIN..."
git fetch origin "$MAIN"
git rebase "origin/$MAIN"
echo "Branch synced with $MAIN."
