#!/usr/bin/env bash
# Run the full quality suite: pre-PR check + security audit + (if React) memory check.
# Usage: ./scripts/workflows/full-check.sh
# Use before opening a PR or as a single "Run Task" command.

set -e
REPO_ROOT="${REPO_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null)}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_ROOT"

FAILED=0

"$SCRIPT_DIR/pre-pr-check.sh" || FAILED=1
echo ""
"$SCRIPT_DIR/security-audit.sh" || true

if [[ -f package.json ]] && grep -q '"react"' package.json 2>/dev/null; then
  echo ""
  echo "=== React memory-leak check ==="
  if [[ -d src ]]; then
    node "$SCRIPT_DIR/react-memory-check.js" src || FAILED=1
  else
    node "$SCRIPT_DIR/react-memory-check.js" . || FAILED=1
  fi
fi

if [[ $FAILED -eq 1 ]]; then
  echo ""
  echo "Full check failed. Fix the issues above."
  exit 1
fi
echo ""
echo "Full check passed."
