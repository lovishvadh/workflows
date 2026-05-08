#!/usr/bin/env bash
# Run the full suite of checks before opening a PR: lint, test, typecheck, audit.
# Usage: ./scripts/workflows/pre-pr-check.sh
# Exits with 0 only if all enabled steps pass.

set -e
REPO_ROOT="${REPO_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null)}"
cd "$REPO_ROOT"

RUNNER="npm run"
command -v pnpm &>/dev/null && RUNNER="pnpm run"
command -v yarn &>/dev/null && RUNNER="yarn run"

FAILED=0

run() {
  local name="$1"
  local cmd="$2"
  if [[ -z "$cmd" ]]; then return; fi
  echo "--- $name ---"
  if eval "$cmd"; then
    echo "OK: $name"
  else
    echo "FAILED: $name"
    FAILED=1
  fi
}

if [[ ! -f package.json ]]; then
  echo "No package.json found. Run your project's check commands manually."
  exit 0
fi

if grep -q '"lint"' package.json; then
  run "lint" "$RUNNER lint"
fi
if grep -q '"test"' package.json; then
  run "test" "$RUNNER test"
fi
if grep -q '"typecheck"' package.json; then
  run "typecheck" "$RUNNER typecheck"
fi
if grep -q '"build"' package.json; then
  run "build" "$RUNNER build"
fi

echo "--- dependency audit (high/critical) ---"
if npm audit --audit-level=high 2>/dev/null; then
  echo "OK: audit"
else
  echo "FAILED: audit (fix or run with --audit-level=critical to allow high)"
  FAILED=1
fi

if [[ $FAILED -eq 1 ]]; then
  echo "Pre-PR check failed. Fix the issues above before opening a PR."
  exit 1
fi
echo "Pre-PR check passed."
