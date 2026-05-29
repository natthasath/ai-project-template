# ADR-001: Technology Stack Selection

**Status:** Accepted  
**Date:** 2026-05-26  
**Deciders:** Development Team

## Context

ต้องเลือก technology stack สำหรับ client-side Pomodoro web application ที่ต้อง:
- ทำงาน offline ได้
- ไม่ต้องการ backend
- Maintainable โดย developer คนเดียวในระยะยาว
- มี ecosystem ที่แข็งแรงสำหรับ TypeScript

## Decision

ใช้ **React 19 + TypeScript + Vite + Zustand + Tailwind CSS v4 + Dexie.js**

## Rationale

### React 19
- Component model เหมาะกับ timer UI ที่ update บ่อย
- React 19's concurrent features ช่วย timer rendering smoothness
- Ecosystem ใหญ่ — testing tools, components, devtools

### Vite
- Fast HMR — critical สำหรับ UI iteration
- Native ESM — no CommonJS overhead
- Built-in TypeScript support — no separate config

### Zustand
- Single shared state ที่ accessible จากทุก component layer
- Selector-based subscriptions ป้องกัน unnecessary re-renders
- ง่ายกว่า Redux/MobX มาก สำหรับ app ขนาดนี้
- Middleware: devtools, persist

### Tailwind CSS v4
- Utility-first ทำให้ prototype เร็วขึ้น
- v4 ใช้ native CSS cascade layers — ไม่ต้องการ PostCSS plugin chain
- Excellent IDE support (Tailwind IntelliSense)

### Dexie.js
- Wraps IndexedDB ด้วย clean Promise API
- รองรับ complex queries ที่จะต้องการในส่วน analytics
- localStorage ไม่เพียงพอ (5MB limit, synchronous)

## Alternatives Rejected

| Alternative | Reason |
|---|---|
| Next.js | SSR/SSG features unnecessary, adds complexity |
| Vue 3 | เท่ากัน technically แต่ ecosystem เล็กกว่า React สำหรับ tooling |
| Svelte | ดีในทางทฤษฎี แต่ ecosystem/testing tools น้อยกว่า |
| Redux | Boilerplate มากเกินสำหรับ app ขนาดนี้ |
| PouchDB | Overkill, designed for sync with CouchDB |

## Consequences

- **Positive:** Fast iteration, strong typing, minimal configuration
- **Negative:** Zustand ไม่มี built-in immer integration (ต้อง install ถ้าต้องการ)
- **Neutral:** Tailwind v4 ยังใหม่ — API อาจมี breaking changes ในอนาคต
