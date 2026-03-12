---
name: ticket-to-tests
description: Turn user stories or tickets into QA test cases, then generate unit/e2e/integration tests (Copilot)
agent: agent
tools: ['search/codebase']
argument-hint: "paste user story or ticket; optionally say 'and generate unit tests' or 'and generate e2e' or 'all test types'"
---

Turn a **user story or ticket** into a full **QA test case list** so QAs can validate the scenario, then (if the user asks) **generate unit, e2e, and/or integration tests** from those cases.

---

## Part 1: QA test cases from the ticket

1. **Input** – The user provides a user story, ticket description, or acceptance criteria (pasted or in chat). If not provided, ask for it.

2. **Produce a test case list** – From the ticket, derive a **complete set of test cases** that QAs can use to validate the scenario. For each test case provide:
   - **ID** (e.g. TC-01, TC-02)
   - **Title** – Short, clear scenario name
   - **Type** – Unit / Integration / E2E (suggest which level is appropriate)
   - **Preconditions** – What must be true before the test (e.g. user logged in, data exists)
   - **Steps** – Numbered steps to execute (what the QA or automation does)
   - **Expected result** – What should happen after the steps
   - **Priority** – Critical / High / Medium / Low (or P1/P2/P3)
   - **Edge/negative cases** – Include boundary conditions, invalid input, error paths, and permission/security checks where relevant

3. **Coverage** – Ensure the list:
   - Covers **happy path** and main acceptance criteria
   - Covers **edge cases** (empty input, limits, duplicates, etc.)
   - Covers **error and validation** (invalid data, unauthorised access, etc.)
   - Is **actionable** – a QA can execute each case manually or hand it to automation

4. **Output format** – Use a clear structure (e.g. markdown table or headings). Example:

   | ID    | Title | Type | Steps | Expected | Priority |
   |-------|--------|------|-------|----------|----------|
   | TC-01 | …      | E2E  | 1. …  | …        | Critical |

   Or use sections per test case with **Preconditions**, **Steps**, **Expected result**.

---

## Part 2: Generate test code (when the user asks)

5. **When the user asks** (e.g. "generate unit tests from these", "write e2e for TC-01 to TC-05", "generate all test types"):
   - Use the **test case list** from Part 1 (or the cases the user points to).
   - **Search the codebase** for existing test patterns:
     - Unit: `*.test.*`, `*.spec.*`, `describe`/`it`, Jest/Vitest/Mocha style
     - E2E: Playwright, Cypress, Puppeteer, etc. – file layout and helpers
     - Integration: API tests, DB tests, test fixtures – match project style
   - Use [.github/copilot-instructions.md](.github/copilot-instructions.md) for code style.

6. **Generate**:
   - **Unit tests** – One or more test files that assert the behaviour in the test cases (functions, components, hooks). Match project test runner and mocking style.
   - **E2E tests** – Scenarios that follow the test case steps (login, navigate, fill form, assert). Match project E2E framework and page/selectors pattern.
   - **Integration tests** – API or service-level tests that verify flows end-to-end within the system (e.g. HTTP calls, DB). Match project integration test layout and setup.

7. **Output** – Propose concrete test files or snippets. Apply or suggest edits in chat. Map each generated test to the **test case ID(s)** (e.g. "covers TC-01, TC-02") so QA and dev can trace.

8. **Verify** – Tell the user to run the **test** task (or `npm test` / E2E script) to confirm the new tests pass. If something fails, help them fix it.

---

## Summary

- **Always:** From ticket/user story → **QA test case list** (complete, step-by-step, with edge and negative cases).
- **If requested:** From that list → **unit**, **e2e**, and/or **integration** test code that matches the repo and maps back to the test case IDs.
