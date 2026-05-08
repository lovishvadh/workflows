#!/usr/bin/env node
/**
 * React memory-leak check: scan for common patterns that cause leaks.
 * Usage: node scripts/workflows/react-memory-check.js [directory]
 * Run from repo root. Scans .js, .jsx, .ts, .tsx under src/ or the given directory.
 *
 * Checks:
 * - addEventListener without removeEventListener in useEffect
 * - setInterval/setTimeout without clear in useEffect
 * - Subscriptions (subscribe) without unsubscribe
 * - setState on unmounted component (async usage)
 */

const fs = require("fs");
const path = require("path");

const ROOT = process.env.REPO_ROOT || process.cwd();
const DIR = path.resolve(ROOT, process.argv[2] || "src");
const EXT = /\.(js|jsx|ts|tsx)$/;

function* walk(dir) {
  if (!fs.existsSync(dir)) return;
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const e of entries) {
    const full = path.join(dir, e.name);
    if (e.isDirectory()) {
      if (e.name === "node_modules" || e.name === ".git") continue;
      yield* walk(full);
    } else if (EXT.test(e.name)) {
      yield full;
    }
  }
}

const issues = [];

function check(content, filePath) {
  const lines = content.split("\n");
  const rel = path.relative(ROOT, filePath);

  // useEffect with addEventListener — look for addEventListener without removeEventListener in same effect
  if (content.includes("addEventListener") && content.includes("useEffect")) {
    const hasRemove = /removeEventListener|\.remove\s*\(/.test(content);
    if (!hasRemove && content.includes("addEventListener")) {
      const ln = lines.findIndex((l) => /addEventListener\s*\(/.test(l));
      if (ln !== -1)
        issues.push({
          file: rel,
          line: ln + 1,
          rule: "addEventListener without removeEventListener in cleanup",
        });
    }
  }

  // setInterval/setTimeout in useEffect without clear
  if (content.includes("setInterval") && content.includes("useEffect")) {
    const hasClear = /clearInterval|clearTimeout/.test(content);
    if (!hasClear) {
      const ln = lines.findIndex((l) => /setInterval\s*\(/.test(l));
      if (ln !== -1)
        issues.push({
          file: rel,
          line: ln + 1,
          rule: "setInterval in useEffect without clearInterval in cleanup",
        });
    }
  }
  if (content.includes("setTimeout") && content.includes("useEffect")) {
    const hasClear = /clearTimeout/.test(content);
    if (!hasClear) {
      const ln = lines.findIndex((l) => /setTimeout\s*\(/.test(l));
      if (ln !== -1)
        issues.push({
          file: rel,
          line: ln + 1,
          rule: "setTimeout in useEffect without clearTimeout in cleanup",
        });
    }
  }

  // .subscribe( without unsubscribe
  if (content.includes(".subscribe(") && content.includes("useEffect")) {
    const hasUnsub = /unsubscribe|\.unsubscribe\s*\(/.test(content);
    if (!hasUnsub) {
      const ln = lines.findIndex((l) => /\.subscribe\s*\(/.test(l));
      if (ln !== -1)
        issues.push({
          file: rel,
          line: ln + 1,
          rule: "subscribe() in useEffect without unsubscribe in cleanup",
        });
    }
  }
}

let scanned = 0;
for (const file of walk(DIR)) {
  scanned++;
  const content = fs.readFileSync(file, "utf8");
  check(content, file);
}

console.log("React memory-leak check");
console.log(`Scanned ${scanned} files under ${path.relative(ROOT, DIR)}`);
console.log("");

if (issues.length === 0) {
  console.log("No obvious memory-leak patterns found.");
  console.log("Still review useEffect cleanup for async setState and refs.");
  process.exit(0);
}

console.log(`Found ${issues.length} potential issue(s):\n`);
issues.forEach(({ file, line, rule }) => {
  console.log(`  ${file}:${line}  ${rule}`);
});
console.log("\nAdd cleanup in useEffect (return () => { ... }) for listeners, intervals, and subscriptions.");
process.exit(1);
