---
description: กฎก่อนเพิ่ม dependency ใหม่ — bundle impact, quality criteria, approved/rejected list
paths:
  - src/**
  - package.json
---

# Dependency Rules

## หลักการ

**ไม่เพิ่ม dependency โดยไม่จำเป็น** — ทุก library ที่เพิ่มคือ:
- Bundle size ที่เพิ่มขึ้น (กระทบ FCP/LCP)
- Attack surface ที่กว้างขึ้น (supply chain risk)
- Maintenance burden ระยะยาว

ถามก่อนเพิ่มทุกครั้งว่า **"เขียนเองได้ไหม?"** ถ้าใช้เวลาไม่เกิน 30 นาที — เขียนเอง

---

## Checklist ก่อนเพิ่ม Dependency

ผ่านทุกข้อก่อนติดตั้ง:

- [ ] **ขนาด** — bundle size impact ≤ 20KB gzipped (ตรวจที่ [bundlephobia.com](https://bundlephobia.com))
- [ ] **ความนิยม** — weekly npm downloads > 100,000 หรือเป็น well-known library
- [ ] **Active maintenance** — มี commit ใน 12 เดือนที่ผ่านมา
- [ ] **Security** — `npm audit` ไม่พบ high/critical vulnerabilities
- [ ] **License** — MIT, Apache 2.0, หรือ BSD เท่านั้น (ห้าม GPL, AGPL ใน production)
- [ ] **TypeScript** — มี type definitions (built-in หรือ `@types/`)
- [ ] **Tree-shakeable** — ถ้า import บางส่วน ส่วนที่ไม่ใช้ถูก exclude ออกจาก bundle

---

## ขั้นตอนเพิ่ม Dependency ใหม่

```bash
# 1. ตรวจขนาดก่อนติดตั้ง
# ไปที่ bundlephobia.com แล้วค้นหาชื่อ package

# 2. ตรวจ security
npm audit

# 3. ติดตั้ง
npm install <package>

# 4. ตรวจ bundle หลังติดตั้ง
npm run build -- --report

# 5. เปรียบเทียบขนาดก่อน/หลัง และ commit พร้อม note ใน commit message
git commit -m "chore: add <package> (<X>KB gzipped) for <reason>"
```

---

## Approved Dependencies

packages ที่ผ่านการประเมินแล้ว สามารถเพิ่มได้โดยไม่ต้องประเมินใหม่

### Core (ติดตั้งแล้ว)

| Package | ใช้สำหรับ | ขนาด |
|---|---|---|
| react + react-dom | UI framework | ~45KB |
| typescript | Type safety | dev only |
| vite | Build tool | dev only |
| zustand | State management | ~3KB |
| dexie | IndexedDB wrapper | ~22KB |
| tailwindcss | Styling | dev only (purged) |

### Testing (ติดตั้งแล้ว)

| Package | ใช้สำหรับ |
|---|---|
| vitest | Unit + component tests |
| @testing-library/react | Component tests |
| @testing-library/user-event | User interaction simulation |
| playwright | E2E tests |

### Pre-approved (ยังไม่ติดตั้ง — ใช้ได้เมื่อถึง phase ที่เกี่ยวข้อง)

| Package | ใช้สำหรับ | Phase |
|---|---|---|
| react-router-dom | Client-side routing | Phase 1 |
| dompurify + @types/dompurify | HTML sanitization | Phase 3 (notifications) |
| recharts | Analytics charts | Phase 6 |
| react-i18next | Internationalization | Phase 7 (ถ้าต้องการ) |
| vite-plugin-pwa | PWA support | Phase 7 |
| zod | Schema validation | Phase 4 |

---

## Rejected Dependencies

ห้ามเพิ่มเด็ดขาด — มีทางเลือกที่ดีกว่าหรือ implement เองได้

| Package | เหตุผล | ทางเลือก |
|---|---|---|
| moment.js | ขนาดใหญ่มาก (67KB) | `date-fns` หรือ `Intl` API |
| lodash (ทั้งหมด) | tree-shaking ไม่ดี | `lodash-es` หรือเขียนเอง |
| axios | ไม่มี backend — ไม่จำเป็น | ไม่มี HTTP calls |
| jquery | ไม่เข้ากับ React | React DOM API |
| bootstrap / material-ui | ใช้ Tailwind อยู่แล้ว | Tailwind + custom components |
| redux / redux-toolkit | overkill สำหรับโปรเจคนี้ | Zustand |
| react-query | ไม่มี server data fetching | Dexie + Zustand |
| styled-components / emotion | ใช้ Tailwind อยู่แล้ว | Tailwind |

---

## DevDependencies vs Dependencies

```bash
# ✅ devDependency — ใช้แค่ตอน build/test ไม่ ship ไปกับ app
npm install --save-dev eslint prettier vitest @types/node

# ✅ dependency — ใช้ตอน runtime
npm install zustand dexie

# ❌ ห้าม — ใส่ devDependency ผิดที่ทำให้ production build พัง
# ❌ ห้าม — ใส่ dependency ผิดที่ทำให้ bundle ใหญ่เกิน
```

---

## Peer Dependencies & Version Conflicts

- ตรวจ peer dependency warnings ทุกครั้งหลัง `npm install`
- ไม่ใช้ `--legacy-peer-deps` เพื่อ bypass warnings โดยไม่เข้าใจ
- Pin version ด้วย exact version (`"1.2.3"` ไม่ใช่ `"^1.2.3"`) สำหรับ packages ที่มี breaking changes บ่อย
- Lock file (`package-lock.json`) ต้อง commit ทุกครั้ง

---

## Security Monitoring

```bash
# รัน audit ทุก sprint
npm audit

# fix อัตโนมัติ (เฉพาะ non-breaking)
npm audit fix

# ถ้ามี critical vulnerability ที่แก้ไม่ได้อัตโนมัติ
# ให้ evaluate เปลี่ยน package หรือ patch ด้วยตัวเอง
```
