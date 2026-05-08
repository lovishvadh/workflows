# Demo & presentation: VS Code + GitHub Copilot workflows

Use this document for a live demo and talk aligned with your abstract (platform approach, tasks, 17 slash commands, ROI, senior-engineer delivery story).

---

## Mind-blowing demo: what audiences actually remember

**Why slash commands can feel “basic”**  
Standing in front of a list of `/commands` feels like a feature tour. The **wow** is not the slash—it is **orchestration**: repo-specific rules, **codebase-aware** Copilot, **saved artifacts** (test files, `PR_DESCRIPTION.md`), and **verification** (Run Task → green terminal / real GitHub). Your story should sound like **delivery infrastructure**, not “we wrapped ChatGPT.”

**What reads as impressive (pick 2–3 in a 15-minute slot)**

| Wow factor | What the room sees | Why it lands |
|------------|-------------------|--------------|
| **Volume + structure** | User story → **15–30 named test cases** (IDs, steps, expected, priority) in under a minute | Humans don’t produce that consistency that fast; QA sees immediate value. |
| **Closure** | Copilot output → **real files on disk** → **Run Task: test** → **passing output** | Proof it isn’t chat vapor—it’s shippable work. |
| **Governance + AI** | **Code review** task fails on a `forbid:` rule → **`/code-review`** proposes fix → **Pre-PR check** passes | Shows **policy encoded in repo** plus AI repair—not vibes. |
| **Security pipeline** | **Vulnerability scan and fix** → terminal shows `audit fix` → **same Pre-PR still green** | Real risk reduction story for leadership. |
| **Ship the artifact** | **`/create-pr`** → save **`PR_DESCRIPTION.md`** → **Create PR** task → **browser opens GitHub** with title + reviewer report | **End-to-end**: idea → checks → PR body reviewers can use. |
| **Browser (optional)** | One **Playwright/Cypress** run (live or **15 s prerecord**) after “generate e2e for TC-01” | Emotional proof—“the machine clicked through the app.” |

**Opening line that reframes the demo**  
*"I'm not here to show you prompts named with slashes. I'm here to show you **ticket → structured QA coverage → optional generated tests → green CI → PR with a reviewer brief**—all in one workspace, with rules that belong to **your** repo."*

---

## 15-minute session — **recommended: “story-to-ship” arc** (mind-blowing track)

**Premise:** One user story becomes **test strategy**, **optional code**, **green verification**, and **a real PR skeleton**—live.

### Timing (total 15:00)

| Time | Segment | What makes it mind-blowing |
|------|---------|----------------------------|
| **0:00–1:30** | **Hook + reframing** | Use the **opening line** above. Problem/solution in **60 seconds**—no feature list. |
| **1:30–6:30** | **Ticket → QA machine** | Paste a **realistic** user story (pre-written). Run **`/ticket-to-tests`**. **Slow scroll** through the **table**: IDs, steps, expected, edge cases. **Say:** *“This is the QA contract generated from the ticket—not a paragraph of fluff.”* Optionally add *“Now generate unit tests for TC-01–TC-03”* and **accept** code into a real test file—**show the file in Explorer**. |
| **6:30–9:30** | **Proof, not chat** | **Run Task → test** (or **Pre-PR check**). Let them see **green** (or a fix loop **once**). **Say:** *“The same IDE that authored the plan verified it.”* |
| **9:30–12:30** | **Reviewer brief → GitHub** | Paste **`git log …`** / **`git diff --stat`** (prepared). **`/create-pr`** → copy output to **`.github/PR_DESCRIPTION.md`** (show split second). **Run Task → Create PR** → **browser opens** GitHub with populated title/body. **Say:** *“Reviewers don’t start blind—they start with a map.”* **Skip browser** if `gh`/`network` risky—show screenshot instead. |
| **12:30–14:00** | **Optional gut punch** | Pick **one**: (a) **Inject `console.log`** → **Code review** task fails → **`/code-review`** fixes → Pre-PR green, OR (b) **Vulnerability scan and fix** clip (prerecord if flaky). |
| **14:00–15:00** | **Land it** | One line: *“Platform = prompts + tasks + rules + verification—not a prettier chat window.”* CTA + thank you. |

### Preparation (non-negotiable for this arc)

- **Demo app repo** with **`npm test`** / **`npm run lint`** that **pass** after your seeded/generated tests (rehearse twice).
- **`gh auth`** + branch pushed so **Create PR** opens a **draft** PR without surprises (use **`Create PR (draft, skip checks)`** if checks would fail live).
- **`PR_DESCRIPTION.md`** path ready; confirm **`create-pr.sh`** picks it up (first line = title).

### If you only have time for **one** wow

Do **`/ticket-to-tests`** (big structured output) **plus** **Run Task: test** green. Skip GitHub. Still stronger than touring slashes.

---

## 15-minute session — compact classic (slash tour)

Use this only if you **cannot** prep a demo app with green tests + `gh` (e.g. last-minute). Otherwise prefer the **[story-to-ship arc](#15-minute-session--recommended-story-to-ship-arc-mind-blowing-track)**.

**Goal:** One crisp story + **two proof points** (tasks + Copilot). Skip everything else.

### Timing (total 15:00)

| Time | Segment | Do / say |
|------|---------|----------|
| **0:00–2:00** | **Hook** | Same friction: inconsistent PRs, ad hoc security, slow reviews. **One sentence solution:** VS Code tasks + `.github` prompts + repo rules = platform, not tribal docs. |
| **2:00–4:00** | **Repo in 90 seconds** | Explorer: flash `.vscode/tasks.json`, `.github/prompts/` (scroll file count—**“17 slash commands”**), open **`code-review-instructions.md`** OR **`copilot-instructions.md`** for 10 seconds (*“rules live in the repo”*). **Do not** walk every file. |
| **4:00–6:30** | **Run Task** | `Terminal → Run Task` → scroll list (Pre-PR check, Full check, Create PR). Run **Pre-PR check** only if your demo repo has `package.json` and it’s reliable; otherwise **scroll only** + *“one click runs the same checks everyone runs.”* |
| **6:30–12:00** | **Copilot Chat (hero)** | Open Chat → type **`/`** → show custom prompts. Run **`/ticket-to-tests`** with a **pre-copied** 5–8 line user story (clipboard). Let first screen of output appear (test case IDs + steps)—**stop after ~90 seconds of generation** if slow. **Say:** *“QA gets cases; devs can generate tests mapped to IDs.”* |
| **12:00–14:00** | **Second slash (pick one)** | **Fast Wi‑Fi:** paste prepared `git log` + `git diff --stat` → **`/create-pr`** → show title + reviewer report snippet. **Slow Wi‑Fi:** show **screenshot** of `/create-pr` output + verbal walkthrough. |
| **14:00–15:00** | **Land the plane** | One metric or outcome (e.g. *“same checks before merge; reviewers get a map”*). **CTA:** *“Copy script into repos; measure time to PR.”* Thank you—**no formal Q&A** unless the format allows overage; invite *“catch me after.”* |

### What to drop in 15 minutes

| Drop | Keep |
|------|------|
| Full walkthrough of all 17 commands | Mention **“17 prompts”** once; show **`/`** menu |
| `/explain`, `/code-review`, `/commit`, `/debug` | Optional **one** if something fails and you need a filler |
| Live **Create PR** + browser | Unless instant; use screenshot |
| Long lessons-learned story | **One** sentence: *“We iterated on real repos.”* |
| Metrics deck | **One** number or **zero**—impact sentence only |

### 15-minute backup (network dies)

1. Show **Run Task** list (offline OK).  
2. Show **`.github/prompts/`** folder (offline OK).  
3. Show **saved screenshots** of `/ticket-to-tests` and `/create-pr` on a slide or second monitor.  
4. Close with CTA in **30 seconds**.

---

## What attendees must leave having seen

| Must-see moment | Why it matters |
|-----------------|----------------|
| **One place for every workflow** | Terminal → Run Task lists Create PR, Pre-PR check, Full check, Security audit, etc.—no tribal knowledge. |
| **Copilot as configured product** | `.github/prompts/*.prompt.md` → slash commands (`/code-review`, `/create-pr`, `/ticket-to-tests`). |
| **Repo-specific AI rules** | Open `.github/code-review-instructions.md` or `copilot-instructions.md`—not generic ChatGPT. |
| **Find → fix → verify** | A slash command that proposes fixes + reminder to run Pre-PR / Full check (or show it narrated). |
| **Story → QA → tests** | `/ticket-to-tests` with a pasted user story → visible test case table + optional test generation. |
| **Story-to-ship closure** (mind-blowing) | Tests on disk → **Run Task: test** green → optional **`PR_DESCRIPTION.md`** + **Create PR** opening GitHub |

---

## Prerequisites (before you go on stage)

### Machine & accounts

- **VS Code** with **GitHub Copilot** and **GitHub Copilot Chat** signed in.
- **GitHub CLI (`gh`)** installed and `gh auth login` completed (for Create PR demo—optional if you skip live PR).
- **Stable network** (Copilot Chat calls the API).

### Repo strategy (pick one)

**Option A — Recommended: “demo app” repo**

Use a tiny Node/TS repo (even a hello-world with `lint`, `test`, `build` scripts) where you have **already copied** this workflow (`./scripts/copy-to-repo.sh /path/to/demo-app`). Then:

- **Pre-PR check**, **Full check**, **Vulnerability scan** behave realistically (pass or fail predictably).
- You avoid explaining “this template repo has no `package.json`.”

**Option B — This `workflows` repo only**

- Great for showing **folder structure**, **all prompt files**, **Run Task** menu (some tasks may exit quickly or skip where no `package.json` exists).
- **Do not** rely on Pre-PR check passing unless you add a minimal `package.json` + scripts for demo.

**Option C — Hybrid (safest for conference Wi‑Fi)**

- **Live:** VS Code UI, tasks list, open `.github/` files, Copilot Chat with `/explain`, `/commit`, `/ticket-to-tests` (no `gh` push).
- **Prerecorded 60–90 s video:** Full check green, Create PR opening in browser—play if live network fails.

---

## Suggested timing (45-minute slot)

| Segment | Time | Content |
|---------|------|---------|
| Hook + problem | 3 min | Same friction everywhere: PR hygiene, security ad hoc, slow review, repo-by-repo tooling. |
| Solution frame | 3 min | VS Code + Copilot as **platform**: tasks + prompts + rules as code. |
| **Live demo** | 18–22 min | Follow **Demo script** below. |
| Outcomes & metrics | 5 min | Point to [Confluence-Leadership-Benefits.md](./Confluence-Leadership-Benefits.md) or 3–4 numbers only. |
| Lessons learned | 4 min | What worked, what you changed, what you’d do next (authentic story). |
| Q&A | 10–12 min | |

For **30-minute** slot: shorten demo to **12 min** (drop optional blocks B–D in the script).

For **15-minute** slot: use the **[story-to-ship arc](#15-minute-session--recommended-story-to-ship-arc-mind-blowing-track)** (mind-blowing) or the [compact classic](#15-minute-session--compact-classic-slash-tour) fallback—do not follow the long script below end-to-end.

---

## Live demo script (screen-by-screen)

**Increase font size** in VS Code (Settings → zoom) so the room can read.

### 1. Orient the repo (2 min)

1. Open VS Code on your **demo repo** (Option A recommended).
2. **Explorer:** Expand `.vscode` → point at `tasks.json` (“every routine action is a named task”).
3. Expand `.github` → show:
   - `copilot-instructions.md`
   - `code-review-instructions.md` (say: “per-repo rules for `/code-review` only”)
   - `code-review-rules.md` (mention `forbid:` patterns for the script)
   - `prompts/` → scroll file list: **“17 slash commands live here.”**

**Say:** *“Configuration as code—same idea as infra as code, but for how engineering works.”*

---

### 2. Run Task: one command for quality (3–4 min)

1. **Terminal → Run Task…** (or `Cmd/Ctrl+Shift+P` → “Tasks: Run Task”).
2. Scroll the list—**don’t read every line**; highlight:
   - **Pre-PR check**
   - **Full check**
   - **Vulnerability scan** / **Vulnerability scan and fix**
   - **Code review (lint + repo rules)**
   - **Create PR** (mention PR_DESCRIPTION flow)

3. Run **Pre-PR check** (or **Full check** if time).

**Expected:** Terminal output shows lint/test/build/audit (or your demo scripts). If something fails, **that’s OK**—say *“we fix before merge; Pre-PR catches it here.”*

**Say:** *“No README archaeology—everyone runs the same checks from the same menu.”*

---

### 3. Copilot Chat: slash commands (6–8 min)

Open **Copilot Chat**. Zoom the chat panel if needed.

**Block A — Fast win (always works)**

- Type **`/`** → scroll prompt list. Say *“These are our custom prompts—repo-defined.”*
- Run **`/explain`** on a small file (or selected function). Let it produce 2–3 sentences, then stop.

**Block B — Your abstract headline**

- Run **`/create-pr`**:
  - If you have network time: paste output of `git log main..HEAD --oneline` and `git diff main...HEAD --stat` (prepare in a scratch buffer).
  - Otherwise: paste **pre-copied** sample output you prepared earlier.
- Show first lines of response: **title + description + reviewer report** sections.

**Say:** *“Reviewers get a map before they open files—that’s the throughput story.”*

**Block C — QA / ticket story (differentiator)**

- Run **`/ticket-to-tests`** with a **short prepared user story** (10–15 lines), e.g.:

  *“As a customer, I want to reset my password via email so that I can regain access without calling support. Acceptance: email sent within 60s, link expires in 24h, invalid token shows error.”*

- Scroll to the **test case list** (IDs, steps, expected). Optionally say *“generate unit tests for TC-01–TC-03”* if time and network allow.

**Say:** *“Same artifact for QA sign-off and for automation—traceability by design.”*

**Block D — Optional (if time + network)**

- **`/code-review`** on a tiny selection → show it referencing repo rules (point at `code-review-instructions.md` on screen briefly).
- OR **`/commit`** after selecting a few lines of diff—show Conventional Commit suggestions.

---

### 4. Close the loop (1–2 min)

1. Open **`scripts/copy-to-repo.sh`** (or show README section)—**one script copies this bundle into any repo.**

2. **Closing line:** *“Standardize one workflow per quarter, measure before/after, treat Copilot config like product code—and you scale habits, not heroes.”*

---

## Backup plan if Copilot or network fails

| Failure | Fallback |
|---------|----------|
| Chat timeout | Show **pre-exported** screenshots or short recording of `/create-pr` and `/ticket-to-tests` responses. |
| `gh` not auth’d | Skip Create PR; describe “would open PR with body from PR_DESCRIPTION.md.” |
| Tasks fail | Narrate intended behaviour; show **green run** from recording. |
| No time | Only sections **1**, **2** (tasks), **3 Block A + C** (slash list + ticket-to-tests). |

---

## Presentation slide outline (optional deck)

1. **Title** — Standardizing VS Code + Copilot workflows @ scale  
2. **The friction** — PR hygiene, security ad hoc, slow review, inconsistent repos (one visual).  
3. **Reframe** — IDE + Copilot as **shared platform**, not individual preference.  
4. **Three pillars** — (1) VS Code tasks (2) `.github` prompts & instructions (3) scripts + verify.  
5. **Screenshot** — Run Task menu (blur secrets if any).  
6. **Screenshot** — `.github/prompts` file list (17 files).  
7. **Live or screenshot** — `/ticket-to-tests` output (test case table).  
8. **Live or screenshot** — `/create-pr` reviewer report section.  
9. **Metrics** — 1 slide: 3 bullets max from leadership doc (time to PR, review, security).  
10. **Lessons learned** — What worked / changed / next.  
11. **Call to action** — One workflow per quarter; measure; config as code.  
12. **Q&A**

---

## Demo checklist (night before)

- [ ] Demo repo has workflow copied; `npm run lint` / `test` / `build` behave as expected (or you accept failure narrative).
- [ ] Copilot Chat works; **`/`** shows custom prompts.
- [ ] Prepared **user story** text for `/ticket-to-tests` in clipboard.
- [ ] Prepared **`git log` / `git diff --stat`** for `/create-pr` (or frozen sample).
- [ ] VS Code zoom level tested on projector / sharing screen.
- [ ] `gh auth status` OK if showing Create PR.
- [ ] Backup slides or video on USB / offline.

---

## Speaker notes — alignment sound bites (ETS / enterprise)

Use when bridging to strategy:

- **Modernization:** Same developer experience in every repo that adopts the bundle.  
- **Security & reliability:** Checks and audits **before** merge, not only in production.  
- **Developer productivity:** Less time on ceremony, more on product value.  
- **Scale:** Standards beat heroics; onboarding isn’t “ask Sarah how we PR here.”  
- **Platform / shared services:** Prompts and tasks are **internal shared services** for engineering.

---

*Companion docs: [README.md](../README.md) (full reference), [Confluence-Leadership-Benefits.md](./Confluence-Leadership-Benefits.md) (quantified narrative).*
