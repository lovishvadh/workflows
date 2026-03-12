# Code review rules (automated checks)

This file is used by the **Code review** workflow script. Add one pattern per line.

## Format

- `forbid: <regex>` – Fail if any file in the repo matches the regex (e.g. disallow patterns).
- Lines starting with `#` or empty are ignored.

## Examples

```markdown
# Disallow console.log in production code (allow in tests)
forbid: console\.log\(

# Disallow raw eval
forbid: \beval\s*\(

# Require error handling (example: fail if fetch without catch)
# forbid: fetch\s*\([^)]+\)\s*(?!\.catch)
```

Add rules that match your team’s standards. The script runs `git grep` with these patterns; keep regexes compatible with `grep -E`.
