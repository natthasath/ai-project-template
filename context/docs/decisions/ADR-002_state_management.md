# ADR-002: State Management Strategy

**Status:** Accepted  
**Date:** 2026-05-26

## Context

Timer state ต้องการ high-frequency updates (ทุกวินาที) และต้องแชร์ระหว่างหลาย components ทำให้ต้องตัดสินใจว่าจะ manage state อย่างไร

## Decision

ใช้ **Zustand stores แบบแยกตาม domain** ไม่ใช่ single monolithic store:

1. `TimerStore` — ephemeral timer state (ไม่ persist)
2. `TaskStore` — task list + active task (sync กับ IndexedDB)
3. `SessionStore` — session history (sync กับ IndexedDB)
4. `SettingsStore` — user preferences (sync กับ localStorage)

## Rationale

### ทำไมต้องแยก stores?
- `TimerStore` updates ทุกวินาที — ถ้ารวมกับ `TaskStore`, task components จะ re-render ทุกวินาทีโดยไม่จำเป็น
- แยก concerns ทำให้ test แต่ละ store ง่ายขึ้น
- แต่ละ store มี persistence strategy ต่างกัน

### ทำไมไม่ใช้ React Context?
- Context ไม่มี built-in selector mechanism — ทุก consumer re-renders เมื่อ context เปลี่ยน
- Timer state ที่ update 60+ ครั้งต่อนาทีจะทำให้ทุก component ที่ใช้ Context re-render

### ทำไมไม่ใช้ Redux?
- Action creators + reducers + selectors = 4x boilerplate สำหรับผลลัพธ์เดียวกัน
- Redux DevTools ดี แต่ Zustand ก็มี devtools middleware
- ความซับซ้อนไม่ justify สำหรับ single-user app

## Store Communication

Stores communicate ผ่าน **subscriptions** ไม่ใช่ direct imports:

```typescript
// SessionStore subscribes to TimerStore
useTimerStore.subscribe(
  state => state.status,
  (status, prevStatus) => {
    if (prevStatus === 'running' && status === 'completed') {
      useSessionStore.getState().logSession(...)
    }
  }
)
```

## Consequences

- **Positive:** Granular subscriptions → minimal re-renders
- **Positive:** Each store independently testable
- **Negative:** Cross-store coordination ต้องผ่าน subscription pattern (slightly more complex)
- **Mitigation:** Document subscription patterns ใน `context/memory/architecture.md`
