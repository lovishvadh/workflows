#!/usr/bin/env bash
# Run dependency and optional static security checks.
# Usage: ./scripts/workflows/security-audit.sh [--fix]
# Uses npm/pnpm/yarn audit. Optionally run Semgrep if available (npx semgrep).

set -e
REPO_ROOT="${REPO_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null)}"
cd "$REPO_ROOT"

FIX=""
[[ "${1:-}" == "--fix" ]] && FIX="--fix"

echo "=== Dependency audit ==="
if [[ -f package.json ]]; then
  if command -v pnpm &>/dev/null; then
    pnpm audit 2>/dev/null || true
  elif command -v yarn &>/dev/null; then
    yarn audit 2>/dev/null || true
  else
    npm audit 2>/dev/null || true
  fi
else
  echo "No package.json; skipping dependency audit."
fi

echo ""
echo "=== Optional: Semgrep (install with: npx semgrep --help) ==="
if command -v npx &>/dev/null; then
  if npx semgrep scan --config auto $FIX 2>/dev/null; then
    echo "Semgrep completed."
  else
    echo "Semgrep not run or found. Install: npm install -g semgrep (or use npx semgrep scan --config auto)"
  fi
else
  echo "npx not available; skipping Semgrep."
fi

echo ""
echo "Security audit finished. Review any findings above."
