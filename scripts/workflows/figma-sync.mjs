#!/usr/bin/env node
/**
 * Figma REST API helper — fetch files/nodes without MCP.
 * Requires Node 18+ (native fetch).
 *
 * Usage:
 *   export FIGMA_ACCESS_TOKEN="your_token"
 *   node scripts/workflows/figma-sync.mjs fetch <file_key> [comma-separated_node_ids]
 *   node scripts/workflows/figma-sync.mjs stub <export.json> <ComponentName> <output.tsx>
 *
 * Examples:
 *   node scripts/workflows/figma-sync.mjs fetch AbCdEfGh1234567
 *   node scripts/workflows/figma-sync.mjs fetch AbCdEfGh1234567 "12:34,56:78"
 *   node scripts/workflows/figma-sync.mjs stub design/figma/latest.json Button src/components/Button.tsx
 */

import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function figmaGET(relPath) {
  const token = process.env.FIGMA_ACCESS_TOKEN;
  if (!token) {
    console.error("Missing FIGMA_ACCESS_TOKEN. Export it or add to .env and source before running.");
    process.exit(1);
  }
  const url = `https://api.figma.com/v1/${relPath}`;
  const res = await fetch(url, {
    headers: { "X-Figma-Token": token },
  });
  const text = await res.text();
  if (!res.ok) {
    console.error(`Figma API ${res.status}: ${text}`);
    process.exit(1);
  }
  return JSON.parse(text);
}

async function cmdFetch(fileKey, nodeIdsArg) {
  let data;
  if (nodeIdsArg && String(nodeIdsArg).trim()) {
    const ids = String(nodeIdsArg)
      .split(",")
      .map((s) => s.trim())
      .filter(Boolean)
      .map((id) => encodeURIComponent(id))
      .join(",");
    data = await figmaGET(`files/${fileKey}/nodes?ids=${ids}`);
  } else {
    data = await figmaGET(`files/${fileKey}`);
  }

  const root = process.env.REPO_ROOT || process.cwd();
  const outDir = path.join(root, "design", "figma", "exports");
  fs.mkdirSync(outDir, { recursive: true });
  const stamp = new Date().toISOString().replace(/[:.]/g, "-");
  const filePath = path.join(outDir, `${fileKey}-${stamp}.json`);
  const payload = JSON.stringify(data, null, 2);
  fs.writeFileSync(filePath, payload);

  const latestPath = path.join(root, "design", "figma", "latest.json");
  fs.writeFileSync(latestPath, payload);

  console.log(`Wrote ${filePath}`);
  console.log(`Updated ${latestPath}`);
}

function cmdStub(jsonPath, componentName, outTsxPath) {
  const root = process.env.REPO_ROOT || process.cwd();
  const absJson = path.isAbsolute(jsonPath) ? jsonPath : path.join(root, jsonPath);
  if (!fs.existsSync(absJson)) {
    console.error(`File not found: ${absJson}`);
    process.exit(1);
  }
  const base = path.basename(absJson);
  const raw = fs.readFileSync(absJson, "utf8");
  let nodeHint = "";
  try {
    const data = JSON.parse(raw);
    const firstName =
      data.nodes &&
      Object.values(data.nodes)[0] &&
      Object.values(data.nodes)[0].document &&
      Object.values(data.nodes)[0].document.name;
    if (firstName) nodeHint = `\n * Figma node name hint: ${firstName}`;
  } catch {
    /* ignore */
  }

  const comp = componentName.replace(/[^a-zA-Z0-9_]/g, "") || "Component";
  const outAbs = path.isAbsolute(outTsxPath) ? outTsxPath : path.join(root, outTsxPath);
  fs.mkdirSync(path.dirname(outAbs), { recursive: true });

  const tsx = `/**
 * Component stub — replace with real markup/styles per docs/style-guidelines.md
 * Source export: ${base}${nodeHint}
 */
import React from "react";

export interface ${comp}Props {
  className?: string;
  children?: React.ReactNode;
}

export function ${comp}(props: ${comp}Props) {
  const { className, children } = props;
  return (
    <div className={className} data-figma-component="${comp}" data-source="figma-stub">
      {children}
    </div>
  );
}
`;

  fs.writeFileSync(outAbs, tsx);
  console.log(`Wrote ${outAbs}`);
}

const [, , cmd, a, b, c] = process.argv;

if (cmd === "fetch") {
  if (!a) {
    console.error('Usage: figma-sync.mjs fetch <file_key> ["node_ids comma-separated"]');
    process.exit(1);
  }
  cmdFetch(a, b).catch((e) => {
    console.error(e);
    process.exit(1);
  });
} else if (cmd === "stub") {
  if (!a || !b || !c) {
    console.error("Usage: figma-sync.mjs stub <export.json> <ComponentName> <output.tsx>");
    process.exit(1);
  }
  cmdStub(a, b, c);
} else {
  console.error(`Commands: fetch | stub

  fetch <file_key> [node_ids]
  stub <jsonPath> <ComponentName> <out.tsx>

Set FIGMA_ACCESS_TOKEN in the environment.`);
  process.exit(1);
}
