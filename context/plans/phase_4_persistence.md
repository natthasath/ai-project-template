# Phase 4: Data Persistence

**Status:** 🔲 Not Started  
**Target:** 2026-06-17  
**Depends on:** Phase 1, Phase 2 complete  
**Goal:** ให้ข้อมูล sessions และ tasks คงอยู่ข้ามการ refresh และ browser restart

## Objectives

1. Set up Dexie.js database schema
2. Implement `SessionRepository` (CRUD + queries)
3. Implement `TaskRepository` (CRUD + sync with TaskStore)
4. Implement Settings persistence ด้วย localStorage
5. Write migration strategy สำหรับ schema changes
6. Implement data export (JSON, CSV)
7. Implement data import + validation
8. Implement "Clear all data" with confirmation

## Database Schema (Dexie.js)

```typescript
class PomodoroDatabase extends Dexie {
  sessions!: Table<Session>
  tasks!: Table<Task>

  constructor() {
    super('PomodoroApp')
    this.version(1).stores({
      sessions: '++id, taskId, startedAt, completedAt, phase, status',
      tasks:    '++id, status, createdAt, completedAt'
    })
  }
}
```

## Session Data Model

```typescript
interface Session {
  id?: number              // auto-increment
  taskId: string | null    // linked task UUID
  phase: 'work' | 'short-break' | 'long-break'
  status: 'completed' | 'interrupted'
  startedAt: Date
  completedAt: Date
  durationSeconds: number  // actual duration (may differ if interrupted)
  notes: string
}
```

## Deliverables

- `src/shared/lib/db/` — PomodoroDatabase, migrations
- `src/entities/session/` — SessionRepository, Session types
- `src/features/data-export/` — ExportButton, import/export logic
- Integration: SessionStore writes to IndexedDB on every session complete/interrupt

## Acceptance Criteria

- [ ] Sessions และ tasks ยังอยู่หลัง browser restart
- [ ] Export JSON/CSV มีข้อมูลครบถ้วน (sessions + tasks)
- [ ] Import JSON กลับมาได้โดยไม่สูญเสียข้อมูล
- [ ] "Clear all data" ลบข้อมูลใน IndexedDB และ localStorage ทั้งหมด
- [ ] Schema migration v1→v2 ทำได้โดยไม่เสียข้อมูลเดิม (เตรียมไว้สำหรับอนาคต)

## Notes

- ไม่ใช้ `Dexie.waitFor()` — ใช้ async/await ปกติ
- Export timestamp: ISO 8601 format (`Date.toISOString()`)
- Import validation: ตรวจสอบ schema ก่อน import (ป้องกัน malformed data)
- localStorage key prefix: `pomodoro_` เพื่อป้องกัน collision
