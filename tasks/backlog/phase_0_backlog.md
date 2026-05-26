# Phase 0 Backlog — Project Setup

## TSK-0-001 — Initialize Vite + React + TypeScript project

**Priority:** High  
**Estimate:** 1 Pomodoro  
**Status:** Backlog

**Description:**  
รัน `npm create vite@latest pomodoro-app -- --template react-ts` และ configure initial settings

**Acceptance Criteria:**
- [ ] `npm run dev` เปิดได้ที่ localhost:5173
- [ ] TypeScript strict mode เปิดใน tsconfig.json
- [ ] ลบ boilerplate files (App.css, assets/react.svg ฯลฯ)

---

## TSK-0-002 — Configure ESLint (flat config) + Prettier

**Priority:** High  
**Estimate:** 1 Pomodoro  
**Status:** Backlog

**Description:**  
ตั้งค่า ESLint v9 flat config พร้อม TypeScript, React, import-order rules และ Prettier integration

**Acceptance Criteria:**
- [ ] `npm run lint` ผ่านบน empty project
- [ ] Prettier format ทำงานใน VSCode (on save)
- [ ] ESLint + Prettier ไม่ conflict กัน (ใช้ `eslint-config-prettier`)

---

## TSK-0-003 — Configure Tailwind CSS v4

**Priority:** High  
**Estimate:** 1 Pomodoro  
**Status:** Backlog

**Description:**  
ติดตั้ง Tailwind CSS v4 และ configure design tokens ตาม `rules/ui_ux_rules.md`

**Acceptance Criteria:**
- [ ] Tailwind classes ทำงานใน components
- [ ] Custom design tokens กำหนดไว้ใน CSS config
- [ ] Dark mode class strategy ทำงาน

---

## TSK-0-004 — Set up Vitest + Testing Library

**Priority:** High  
**Estimate:** 1 Pomodoro  
**Status:** Backlog

**Acceptance Criteria:**
- [ ] `npm test` รันได้ (แม้ไม่มี test files)
- [ ] jsdom environment configured
- [ ] Coverage report generate ได้

---

## TSK-0-005 — Set up Playwright

**Priority:** Medium  
**Estimate:** 1 Pomodoro  
**Status:** Backlog

**Acceptance Criteria:**
- [ ] `npm run test:e2e` รันได้
- [ ] Configured สำหรับ Chrome, Firefox, Safari
- [ ] Test หนึ่งอันที่ verify page loads

---

## TSK-0-006 — Create FSD folder structure

**Priority:** High  
**Estimate:** 1 Pomodoro  
**Status:** Backlog

**Description:**  
สร้าง folder structure ตาม Feature-Sliced Design ใน `memory/architecture.md` พร้อม index.ts re-exports

**Acceptance Criteria:**
- [ ] ทุก layer มี folder: app, pages, widgets, features, entities, shared
- [ ] ทุก folder มี `index.ts` สำหรับ public exports
- [ ] Path aliases (`@app`, `@shared` ฯลฯ) ทำงานใน vite.config.ts และ tsconfig.json

---

## TSK-0-007 — Configure Git hooks (Husky + lint-staged)

**Priority:** High  
**Estimate:** 1 Pomodoro  
**Status:** Backlog

**Acceptance Criteria:**
- [ ] Pre-commit: lint + typecheck บน staged files
- [ ] Pre-push: full test suite
- [ ] Hooks ทำงานบน Windows (PowerShell) และ Mac/Linux

---

## TSK-0-008 — Set up GitHub Actions CI

**Priority:** Medium  
**Estimate:** 1 Pomodoro  
**Status:** Backlog

**Acceptance Criteria:**
- [ ] CI รัน lint + typecheck + tests บน every push
- [ ] CI รัน Playwright E2E บน PRs
- [ ] Build artifact สร้างได้สำเร็จ
