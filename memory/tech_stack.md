---
name: tech-stack
description: Technology choices ที่ตัดสินใจแล้วและเหตุผลสำหรับ Pomodoro Application
metadata:
  type: project
---

# Tech Stack Decisions

## Confirmed Stack

| Layer | Technology | Version | Decision Date |
|---|---|---|---|
| Framework | React | 19.x | 2026-05-26 |
| Language | TypeScript | 5.x | 2026-05-26 |
| Build | Vite | 6.x | 2026-05-26 |
| State | Zustand | 5.x | 2026-05-26 |
| Styling | Tailwind CSS | 4.x | 2026-05-26 |
| Storage | Dexie.js (IndexedDB) | 4.x | 2026-05-26 |
| Testing | Vitest + @testing-library/react | latest | 2026-05-26 |
| E2E | Playwright | latest | 2026-05-26 |
| Linting | ESLint (flat config) + Prettier | latest | 2026-05-26 |

## Key Rationale

### Zustand over Redux/Context
- Redux: too much boilerplate for a single-user app
- Context: re-render performance issues with high-frequency timer updates (every second)
- Zustand: minimal API, built-in devtools, easy timer subscription pattern

### Dexie.js over localStorage
- localStorage: 5 MB limit — insufficient for long-term session history
- Dexie.js: wraps IndexedDB with a clean Promise API, supports complex queries needed for analytics

### Tailwind CSS v4 over CSS Modules
- CSS Modules: good isolation but slow iteration for design exploration
- Tailwind v4: utility-first speeds up prototyping; v4 uses native CSS cascade layers (no PostCSS dependency)

## Rejected Options

| Technology | Reason for Rejection |
|---|---|
| Next.js | Server-side features unnecessary for offline-first client app |
| Redux Toolkit | Overkill for simple timer + task state |
| MobX | Learning curve, decorator syntax friction |
| SvelteKit | Team unfamiliar — risk too high for MVP |
| SQLite (WASM) | Dexie.js sufficient; WASM adds complexity |

**Why:** All decisions bias toward minimal dependencies and fast iteration.
**How to apply:** When suggesting new packages, first check if an existing stack member can do the job. [[project-overview]]
