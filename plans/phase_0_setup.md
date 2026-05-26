# Phase 0: Project Setup

**Status:** 🔲 Not Started  
**Target:** 2026-05-27  
**Goal:** สร้าง project scaffold ที่พร้อมสำหรับ development ตั้งแต่วันแรก

## Objectives

1. Initialize Vite + React + TypeScript project
2. Configure ESLint (flat config) + Prettier
3. Configure Tailwind CSS v4
4. Set up Vitest + Testing Library
5. Set up Playwright (E2E)
6. Create FSD folder structure ใน `src/`
7. Configure `tsconfig.json` path aliases
8. Set up Git hooks (Husky + lint-staged)
9. Write initial CLAUDE.md และ README.md
10. Verify CI passes on empty project

## Deliverables

- `package.json` พร้อม scripts: `dev`, `build`, `preview`, `test`, `test:e2e`, `lint`, `typecheck`
- `src/` structure ตาม FSD architecture (empty modules, index.ts re-exports)
- `.github/workflows/ci.yml` — lint + typecheck + test on push
- `vite.config.ts` พร้อม aliases และ test config

## Acceptance Criteria

- [ ] `npm run dev` เปิด browser ได้โดยไม่มี error
- [ ] `npm run build` สำเร็จโดยไม่มี TypeScript errors
- [ ] `npm test` รัน (แม้ยังไม่มี test cases)
- [ ] `npm run lint` ผ่านโดยไม่มี warnings

## Notes

- ใช้ `npm create vite@latest` เป็น base
- ตั้ง `"strict": true` ใน tsconfig ตั้งแต่ต้น — เปลี่ยนทีหลังยาก
- Path aliases: `@app`, `@pages`, `@widgets`, `@features`, `@entities`, `@shared`
