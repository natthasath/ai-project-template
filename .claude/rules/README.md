# Rules — คู่มือการใช้งาน

## Rules คืออะไร

ไฟล์ `.md` แต่ละอันในโฟลเดอร์นี้คือชุดกฎที่ Claude ต้องปฏิบัติตามเมื่อทำงานในโปรเจค

**ต่างจาก `CLAUDE.md`** ตรงที่ rules โหลดได้แบบ **conditional** — โหลดเฉพาะเมื่อ Claude กำลังทำงานกับไฟล์ที่ตรงกับ `paths:` ใน frontmatter ไม่ต้องโหลดทุกอย่างเข้า context ตลอดเวลา

> ⚠️ Rules เป็น **guidance** ที่ Claude อ่านและปฏิบัติตาม — ไม่ใช่ enforcement
> ถ้าต้องการบังคับใช้จริงๆ ใช้ `permissions` หรือ `hooks` ใน `settings.json` แทน

---

## วิธีโหลด Rules

### Rules ที่ไม่มี `paths:` — โหลดทุก session

```yaml
---
description: Git workflow และ commit conventions
---
```

โหลดเหมือน `CLAUDE.md` — มีผลตลอดทั้ง session

### Rules ที่มี `paths:` — โหลดเมื่อเปิดไฟล์ที่ตรงกัน

```yaml
---
description: TypeScript และ React coding standards
paths:
  - src/**
  - tests/**
---
```

Claude โหลด rule นี้เมื่อกำลังอ่านหรือแก้ไขไฟล์ใน `src/` หรือ `tests/` เท่านั้น

---

## Rules ที่มีในโปรเจคนี้

| ไฟล์ | โหลดเมื่อ | ครอบคลุม |
|---|---|---|
| `git-conventions.md` | ทุก session | branch naming, commit messages, workflow กับ Claude |
| `architecture.md` | `src/**` | FSD layer rules, import direction, module boundaries, path aliases |
| `coding-standards.md` | `src/**`, `tests/**` | TypeScript, React, Zustand, import order, forbidden patterns |
| `error-handling.md` | `src/**` | ErrorBoundary, async errors, custom error classes, user-facing messages |
| `testing-rules.md` | `src/**`, `tests/**` | Vitest, Playwright, mocking policy, coverage targets |
| `security-rules.md` | `src/**` | input validation, XSS prevention, CSP, storage security |
| `performance-rules.md` | `src/**` | bundle budget, rendering, IndexedDB optimization |
| `dependency-rules.md` | `src/**`, `package.json` | checklist ก่อนเพิ่ม dependency, approved/rejected list |
| `i18n.md` | `src/**`, `public/locales/**` | ห้าม hardcode text, locale constants, Thai-specific formatting |
| `ui-ux-rules.md` | `src/components/**`, `src/features/**`, `src/pages/**`, `src/shared/ui/**` | design tokens, keyboard shortcuts, accessibility, animation |

---

## รายละเอียดแต่ละ Rule

### `git-conventions.md` — โหลดทุก session

กฎที่สำคัญที่สุดในโปรเจค เพราะ Claude Code ไม่ทำ git อัตโนมัติ

ครอบคลุม:
- **Workflow กับ Claude** — checkpoint commit ก่อนให้ Claude ทำงานทุกครั้ง
- **วิธีย้อนกลับ** — `git checkout .`, `git reset --hard HEAD`, `git revert HEAD`
- **Branch naming** — `feature/`, `fix/`, `refactor/`, `docs/`, `chore/`
- **Commit message format** — `<type>(<scope>): <summary>` สูงสุด 72 ตัวอักษร

---

### `coding-standards.md` — โหลดเมื่อแก้ `src/**`

ครอบคลุม:
- **TypeScript** — explicit return types, ห้าม `any`, discriminated unions, `satisfies` operator
- **React** — named exports เท่านั้น, early return pattern, composition over prop drilling
- **File naming** — kebab-case ไฟล์, PascalCase component exports
- **Import order** — React → external → @-aliased → relative
- **Zustand** — actions co-located กับ state, selector pattern
- **Forbidden patterns** — `console.log`, `@ts-ignore`, non-null assertion, inline styles, magic numbers

---

### `testing-rules.md` — โหลดเมื่อแก้ `src/**` หรือ `tests/**`

ครอบคลุม:
- **4 ประเภท tests** — Unit (Vitest), Component (Testing Library), Integration, E2E (Playwright)
- **Mocking policy** — mock เฉพาะ external systems, ห้าม mock internal code
- **Timer testing** — `vi.useFakeTimers()` + `vi.advanceTimersByTime()`
- **Coverage targets** — entities ≥ 90%, features ≥ 80%, shared/lib ≥ 90%

---

### `security-rules.md` — โหลดเมื่อแก้ `src/**`

ครอบคลุม:
- **Input validation** — strip HTML, enforce length บน task title
- **XSS prevention** — ห้าม `dangerouslySetInnerHTML` โดยไม่มี DOMPurify
- **Data import** — validate JSON structure ก่อน write ลง IndexedDB
- **Storage** — ห้ามเก็บ sensitive data ใน localStorage, export ลงเครื่องเท่านั้น
- **CSP** — `default-src 'self'`, `connect-src 'none'`

---

### `performance-rules.md` — โหลดเมื่อแก้ `src/**`

ครอบคลุม:
- **Bundle budget** — initial ≤ 150KB, total ≤ 250KB gzipped
- **Zustand selectors** — subscribe เฉพาะ field ที่ใช้ ป้องกัน unnecessary re-renders
- **Memory management** — ล้าง `setInterval` ใน `useEffect` cleanup เสมอ
- **Lazy loading** — Analytics และ Settings page ต้อง `lazy()`
- **IndexedDB** — ใช้ `.limit()`, หลีกเลี่ยง `.filter()` บน large collections

---

### `ui-ux-rules.md` — โหลดเมื่อแก้ components, features, pages, shared/ui

ครอบคลุม:
- **Design tokens** — สี accent, surface, panel, border, text, muted และ phase colors
- **Keyboard shortcuts** — Space, R, N, T, ?, Escape, Ctrl+,
- **Minimum sizes** — touch target 44×44px, font size ≥ 14px
- **Accessibility** — `aria-label`, `aria-live`, `role="progressbar"`, `role="dialog"`
- **Animation** — 150ms micro-interactions, 300ms transitions, `prefers-reduced-motion`
- **Error states** — inline validation, ErrorBoundary, empty states ต้องมี CTA

---

## เพิ่ม Rule ใหม่

สร้างไฟล์ `.md` ใหม่พร้อม frontmatter:

```markdown
---
description: อธิบายสั้นๆ ว่า rule นี้ใช้สำหรับอะไร
paths:
  - src/features/analytics/**   ← ถ้าต้องการ scope เฉพาะบาง directory
---

# Rule Title

เนื้อหา rule...
```

**เมื่อไหรควรเพิ่ม rule ใหม่:**
- `CLAUDE.md` เริ่มเกิน 200 บรรทัด — แยกบางส่วนออกมาเป็น rule
- มีกฎเฉพาะสำหรับ feature ใหม่ (เช่น analytics, notifications)
- ต้องการ override rule ทั่วไปสำหรับบาง directory

**Subdirectories ก็ได้:** `.claude/rules/frontend/react.md` ถูก discover อัตโนมัติ
