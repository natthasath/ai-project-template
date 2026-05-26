# Phase 8: Testing & QA

**Status:** 🔲 Not Started  
**Target:** 2026-07-12  
**Depends on:** Phase 7 complete  
**Goal:** รับประกัน quality ผ่าน automated tests และ manual QA ก่อน release

## Test Coverage Targets

| Layer | Tool | Target Coverage |
|---|---|---|
| Unit (stores, utils) | Vitest | ≥ 90% |
| Component (rendering, interactions) | Testing Library | ≥ 80% |
| Integration (feature flows) | Testing Library | key paths only |
| E2E (critical user journeys) | Playwright | 100% of journeys |

## Critical E2E Test Scenarios

1. **Happy path** — Start timer → complete 4 Pomodoros → long break triggers
2. **Task flow** — Create task → assign to active session → complete → task progress updates
3. **Settings persistence** — Change work duration → reload → timer shows new duration
4. **Data export/import** — Export data → clear all → import → data restored
5. **Keyboard navigation** — Complete full session using only keyboard
6. **Background tab** — Timer in background tab → return → correct time shown

## Pre-Release QA Checklist

- [ ] Chrome (latest stable)
- [ ] Firefox (latest stable)
- [ ] Safari 17+
- [ ] Edge (latest stable)
- [ ] Chrome on Android (responsive)
- [ ] Safari on iOS (responsive)
- [ ] Screen reader test: NVDA + Chrome, VoiceOver + Safari
- [ ] Slow 3G network simulation (Lighthouse throttling)
- [ ] localStorage full scenario
- [ ] IndexedDB quota exceeded scenario

## Deliverables

- `tests/e2e/` — Playwright test suites
- `src/**/*.test.ts` — Vitest unit/integration tests (co-located)
- Test coverage report (HTML)
- QA sign-off document
