# Testing Rules

## Principles

1. **Test behavior, not implementation** — tests ต้องไม่ break เมื่อ refactor internal code โดยไม่เปลี่ยน behavior
2. **Arrange-Act-Assert** — ทุก test ต้องมีโครงสร้างชัดเจน
3. **One assertion per concept** — ไม่ยัด unrelated assertions ใน test เดียว
4. **Descriptive names** — ชื่อ test อ่านแล้วรู้ว่า behavior คืออะไรโดยไม่ดู code

## Test Categories

### Unit Tests (Vitest)
- **What:** Store actions, utility functions, data transformations
- **Location:** Co-located กับ source file (`timer-store.test.ts` อยู่ถัดจาก `timer-store.ts`)
- **Run time:** < 100ms ต่อ test

### Component Tests (Vitest + Testing Library)
- **What:** Component rendering, user interactions, state changes
- **Location:** Co-located กับ component
- **Rule:** ใช้ `userEvent` ไม่ใช่ `fireEvent` สำหรับ user interactions

### Integration Tests (Vitest + Testing Library)
- **What:** Feature flows ที่ cross หลาย components/stores
- **Location:** `src/features/<feature>/__tests__/`
- **Rule:** ใช้ real stores, mock เฉพาะ external (IndexedDB, notifications, time)

### E2E Tests (Playwright)
- **What:** Critical user journeys ตั้งแต่ต้นจนจบ
- **Location:** `tests/e2e/`
- **Rule:** รันบน real browser, ไม่ mock anything

## Mocking Policy

```typescript
// ✅ Mock: External systems at the boundary
vi.mock('@shared/lib/db')           // IndexedDB
vi.mock('@features/notification')   // OS notifications
vi.useFakeTimers()                   // Time/Date

// ✅ Mock: Web APIs ที่ไม่มีใน jsdom
vi.stubGlobal('Notification', MockNotification)
vi.stubGlobal('AudioContext', MockAudioContext)

// ❌ Don't mock: Internal stores, utilities, components
// ❌ Don't mock: Things you own — test them directly
```

## Timer Testing

```typescript
// ✅ Good — test with fake timers + wall clock
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
// Format: describe("ComponentName / StoreName") > it("should <behavior> when <condition>")

describe('TimerStore', () => {
  it('should transition to short-break phase after 1 completed work session', () => { ... })
  it('should transition to long-break phase after 4 completed work sessions', () => { ... })
  it('should reset cycle count after long break completes', () => { ... })
})
```

## Coverage Requirements

- `src/entities/` — ≥ 90% branch coverage
- `src/features/` — ≥ 80% branch coverage
- `src/shared/lib/` — ≥ 90% branch coverage
- `src/shared/ui/` — ≥ 70% line coverage
- Exclude from coverage: `src/app/`, `*.types.ts`, `index.ts` (re-exports)
