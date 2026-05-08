# Style guidelines (design system)

Use this file as the **single source of truth** for how UI should look and behave in code. Link your Figma files here so engineers and Copilot align implementation with design.

## Figma sources

| Area | Figma URL | File key (for API / scripts) |
|------|-----------|-------------------------------|
| Design system / components | `https://www.figma.com/design/XXXXXXXX/` | *(paste key)* |
| Product / feature screens | | |

To get **file key**: open the file in the browser — the URL contains `/design/<file_key>/`.

## Brand tokens

Document tokens your app uses (sync manually or via design ops). Example:

| Token | Value | Usage |
|-------|-------|--------|
| `--color-primary` | `#0066CC` | Primary actions, links |
| `--color-surface` | `#FFFFFF` | Cards, modals |
| `--font-body` | system-ui, sans-serif | Body text |
| `--space-unit` | `8px` | Spacing scale (8, 16, 24, …) |
| `--radius-md` | `8px` | Buttons, inputs |

## Typography

| Role | Size | Weight | Figma text style name |
|------|------|--------|----------------------|
| Display | | | |
| Heading 1 | | | |
| Body | | | |
| Caption | | | |

## Components

Map Figma component names to code locations (update when you add components):

| Figma name | Code path | Notes |
|------------|-----------|--------|
| Button | `src/components/Button.tsx` | Variants: primary, secondary |
| | | |

## Layout & breakpoints

| Breakpoint | Min width | Layout notes |
|------------|-----------|--------------|
| Mobile | | |
| Tablet | | |
| Desktop | | |

## Accessibility

- Focus visible styles: …
- Minimum contrast: WCAG AA for text
- Touch targets: min 44×44 px where applicable

## Motion

- Duration tokens: …
- Prefer `prefers-reduced-motion` for large motion

## How this ties to Figma API workflow

1. Run **`node scripts/workflows/figma-sync.mjs fetch <file_key>`** (see [Figma-API-Workflow.md](./Figma-API-Workflow.md)) to export JSON under `design/figma/`.
2. Generate stubs or ask Copilot **`/figma-component`** using the export + **this file** so implementation matches tokens and naming above.

---

*Customize per product; keep links to Figma and tokens current.*
