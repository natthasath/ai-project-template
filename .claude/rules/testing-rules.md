---
description: นโยบาย testing, mocking, coverage สำหรับ Vitest + Playwright
paths:
  - src/**
  - tests/**
---

# Testing Rules

## หลักการ

1. **Test behavior ไม่ใช่ implementation** — tests ต้องไม่ break เมื่อ refactor internal code
2. **Arrange-Act-Assert** — ทุก test ต้องมีโครงสร้างชัดเจน
3. **One assertion per concept** — ไม่ยัด unrelated assertions ใน test เดียว
4. **Descriptive names** — ชื่อ test อ่านแล้วรู้ behavior โดยไม่ดู code

## ประเภท Tests

### Unit Tests (Vitest)
- **ทดสอบ:** Store actions, utility functions, data transformations
- **ตำแหน่ง:** Co-located กับ source file (`timer-store.test.ts` ถัดจาก `timer-store.ts`)
- **เวลา:** < 100ms ต่อ test

### Component Tests (Vitest + Testing Library)
- **ทดสอบ:** Component rendering, user interactions
- **กฎ:** ใช้ `userEvent` ไม่ใช่ `fireEvent`

### Integration Tests (Vitest + Testing Library)
- **ทดสอบ:** Feature flows ที่ cross หลาย components/stores
- **ตำแหน่ง:** `src/features/<feature>/__tests__/`
- **กฎ:** ใช้ real stores, mock เฉพาะ external (IndexedDB, notifications, time)

### E2E Tests (Playwright)
- **ทดสอบ:** Critical user journeys ตั้งแต่ต้นจนจบ
- **ตำแหน่ง:** `tests/e2e/`
- **กฎ:** real browser, ไม่ mock anything

## Mocking Policy

```typescript
// ✅ Mock: External systems เท่านั้น
vi.mock('@shared/lib/db')           // IndexedDB
vi.mock('@features/notification')   // OS notifications
vi.useFakeTimers()                   // Time/Date
vi.stubGlobal('Notification', MockNotification)

// ❌ ห้าม mock: Internal stores, utilities, components ที่เราเขียนเอง
```

## Timer Testing

```typescript
it('decrements seconds remaining by 1 each tick', () => {
  vi.useFakeTimers()
  const { start } = useTimerStore.getState()
  start()
  vi.advanceTimersByTime(1000)
  expect(useTimerStore.getState().secondsRemaining).toBe(25 * 60 - 1)
})
```

## Test Description Format

```typescript
describe('TimerStore', () => {
  it('should transition to short-break after 1 completed work session', () => { ... })
  it('should transition to long-break after 4 completed work sessions', () => { ... })
})
```

## Coverage Requirements

- `src/entities/` — ≥ 90% branch coverage
- `src/features/` — ≥ 80% branch coverage
- `src/shared/lib/` — ≥ 90% branch coverage
- `src/shared/ui/` — ≥ 70% line coverage
- Exclude: `src/app/`, `*.types.ts`, `index.ts` (re-exports)
