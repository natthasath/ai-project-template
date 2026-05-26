# Phase 7: Polish & Accessibility

**Status:** 🔲 Not Started  
**Target:** 2026-07-08  
**Depends on:** All previous phases complete  
**Goal:** ทำให้ app พร้อม ship — accessible, performant, และ polished

## Accessibility Checklist

- [ ] Focus management: focus trap ใน modals, focus restore เมื่อ modal ปิด
- [ ] ARIA live region สำหรับ timer countdown (`aria-live="polite"`)
- [ ] ARIA labels ครบทุก icon button
- [ ] Color contrast ≥ 4.5:1 (AA) ทุก text/background combination
- [ ] Keyboard navigation ครอบคลุมทุก interactive element
- [ ] Skip navigation link สำหรับ screen reader users
- [ ] axe-core audit: zero critical/serious violations

## Performance Checklist

- [ ] Bundle analysis: `npm run build -- --report` — ไม่มี chunk > 100 KB
- [ ] Lazy load Analytics page (code splitting)
- [ ] Memoize expensive computations (`useMemo`, `useCallback` เมื่อจำเป็น)
- [ ] Lighthouse Performance ≥ 90
- [ ] No layout shifts (CLS < 0.1)

## UX Polish

- [ ] Loading states สำหรับ IndexedDB operations
- [ ] Error boundaries ครอบ major sections
- [ ] Toast notifications สำหรับ success/error feedback
- [ ] Smooth transitions ระหว่าง timer phases
- [ ] Empty states ที่มี guidance (ไม่ใช่แค่ "No data")
- [ ] Keyboard shortcut reference modal (? key)

## PWA Setup

- [ ] `manifest.json` พร้อม icons (192×192, 512×512)
- [ ] Service Worker สำหรับ offline support (Vite PWA plugin)
- [ ] "Add to Home Screen" support บน mobile browsers

## Deliverables

- `src/shared/ui/toast/` — Toast component + useToast hook
- `src/shared/ui/error-boundary/` — ErrorBoundary wrapper
- `public/manifest.json` + PWA assets
- `src/app/styles/` — global animations, transitions
