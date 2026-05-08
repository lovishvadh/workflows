# Figma REST API workflow (no MCP)

Use Figma’s **official REST API** when you don’t have the Figma MCP: fetch files/components as JSON, save them in the repo, then implement using **`docs/style-guidelines.md`** and Copilot.

## 1. Create an access token

1. Figma → **Settings** → **Account** → **Personal access tokens**  
2. Create a token with a clear label (e.g. `vscode-workflows-repo`).  
3. Copy it once and store as **`FIGMA_ACCESS_TOKEN`** (never commit the real value).

Docs: [Figma API authentication](https://www.figma.com/developers/api#access-tokens)

## 2. Get file key and node IDs

From a file URL:

```text
https://www.figma.com/design/AbCdEfGh1234567/My-File?node-id=12-34
```

- **File key:** `AbCdEfGh1234567` (the segment after `/design/`).
- **Node id:** in the URL `node-id=12-34` → API uses `12:34` (replace `-` with `:`).

## 3. Fetch via script (this repo)

From the repo root, with Node **18+**:

```bash
export FIGMA_ACCESS_TOKEN="your_token"

# Full file (large JSON — good for browsing structure)
node scripts/workflows/figma-sync.mjs fetch YOUR_FILE_KEY

# Specific components / frames only (smaller, faster)
node scripts/workflows/figma-sync.mjs fetch YOUR_FILE_KEY "12:34,56:78"
```

Outputs:

- `design/figma/exports/<file_key>-<timestamp>.json`
- `design/figma/latest.json` — always overwritten with the last fetch

## 4. Generate a code stub (optional)

After a fetch, you can emit a minimal React stub (you fill in real markup/styles using style guidelines):

```bash
node scripts/workflows/figma-sync.mjs stub design/figma/latest.json Button src/components/Button.tsx
```

Then refine the component and styles using **`docs/style-guidelines.md`**.

## 5. Build the real component with Copilot

1. Open **`design/figma/latest.json`** (or the nodes export) — Copilot Chat can read structure.  
2. Open **`docs/style-guidelines.md`**.  
3. Run **`/figma-component`** in Copilot Chat (see `.github/prompts/figma-component.prompt.md`) or ask:

   *“Implement `Button` from `design/figma/latest.json` following `docs/style-guidelines.md`.”*

## 6. VS Code tasks

Use **Terminal → Run Task → Figma: fetch full file** after setting env vars in the integrated terminal:

```bash
export FIGMA_ACCESS_TOKEN="..."
export FIGMA_FILE_KEY="YOUR_FILE_KEY"
```

Then run the task (it passes `FIGMA_FILE_KEY` to the script).

## Limits and notes

- **Rate limits:** Figma applies limits per token; cache exports and don’t fetch on every save.  
- **Secrets:** Put `FIGMA_ACCESS_TOKEN` in `.env` (gitignored) or your shell profile — **not** in the repo.  
- **JSON size:** Full files can be huge; prefer **node IDs** for components you’re implementing.  
- **Pixels vs code:** The API returns layout and styles as data; turning that into production CSS/React still requires engineering judgment — use style guidelines + Copilot for consistency.

## Reference

- [Figma REST API reference](https://www.figma.com/developers/api)
