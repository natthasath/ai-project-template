# ADR-003: Data Persistence Strategy

**Status:** Accepted  
**Date:** 2026-05-26

## Context

Application ต้องการ persist data หลาย types ที่มีลักษณะต่างกัน:
- Settings: เล็ก, อ่านบ่อย, ต้องการทันทีตอน startup
- Tasks: medium size, CRUD operations, ต้องการ querying
- Sessions: เพิ่มขึ้นเรื่อยๆ, ต้องการ date range queries สำหรับ analytics

## Decision

ใช้ **ชั้น persistence แยกตาม data type:**

| Data | Storage | Why |
|---|---|---|
| Settings | localStorage | Synchronous read on startup, small size (<1KB) |
| Tasks | IndexedDB via Dexie.js | CRUD + querying, survives storage pressure |
| Sessions | IndexedDB via Dexie.js | Grows unboundedly, needs date range index |

## Why Not localStorage for Everything?

- 5MB quota — session history สำหรับ heavy user (10 sessions/day × 365 days = 3,650 sessions) จะ exceed
- Synchronous API บล็อก main thread สำหรับ large reads
- ไม่รองรับ indexed queries สำหรับ analytics

## Why Not a Single Persistence Solution (e.g., Dexie for All)?

- Settings ต้องการ synchronous access ตอน app initialize
  (ถ้าใช้ IndexedDB → ต้องรอ async → flash of wrong theme/duration)
- localStorage สำหรับ settings เป็น established pattern ที่ simple และ reliable

## Write Strategy: Write-Through

Write เข้า IndexedDB ทุกครั้งที่ store action ทำงาน (ไม่ batch):

```typescript
// ใน TaskStore action:
addTask: async (task) => {
  set(state => ({ tasks: [...state.tasks, task] }))  // immediate UI update
  await db.tasks.add(task)                             // async persist
}
```

Rationale:
- App ขนาดนี้ write frequency ต่ำพอ — ไม่จำเป็นต้อง batch
- Simpler code, ไม่มี risk ของ data loss ถ้า browser crash ระหว่าง batch window

## Consequences

- **Positive:** Settings available synchronously on startup (no flash)
- **Positive:** Tasks/sessions survive storage pressure eviction better than localStorage
- **Negative:** Two different storage APIs ต้องเข้าใจ
- **Mitigation:** Abstract behind Repository pattern (`TaskRepository`, `SessionRepository`)
