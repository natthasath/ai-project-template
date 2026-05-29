---
description: Bundle budget, rendering performance, IndexedDB optimization
paths:
  - src/**
---

# Performance Rules

## Bundle Size Budget

| Chunk | Budget |
|---|---|
| Initial bundle | ≤ 150 KB gzipped |
| Analytics chunk (lazy) | ≤ 80 KB gzipped |
| Total app | ≤ 250 KB gzipped |

ตรวจสอบด้วย `npm run build -- --report` หลังเพิ่ม dependency ใหม่ทุกครั้ง

## Rendering Performance

```typescript
// ✅ Subscribe เฉพาะ field ที่ใช้ — ป้องกัน unnecessary re-renders
const secondsRemaining = useTimerStore(s => s.secondsRemaining)
const status = useTimerStore(s => s.status)

// ❌ Subscribe ทั้ง store object
const store = useTimerStore()  // re-renders ทุก tick

// ✅ useMemo เฉพาะ expensive derivations
const sortedTasks = useMemo(() => [...tasks].sort(byCreatedAt), [tasks])

// ✅ Timer tick ต้องอยู่ใน store ไม่ใช่ใน component
```

## Memory Management

```typescript
// ✅ ล้าง intervals/listeners ใน cleanup เสมอ
useEffect(() => {
  const interval = setInterval(tick, 1000)
  return () => clearInterval(interval)
}, [])

// ✅ ใช้ limit() สำหรับ large Dexie collections
const recentSessions = await db.sessions
  .orderBy('startedAt').reverse().limit(100).toArray()

// ❌ อย่า load ทั้งหมดในครั้งเดียว
const allSessions = await db.sessions.toArray()
```

## Lazy Loading

```typescript
// ✅ Lazy load routes ที่ไม่ใช่ initial view
const AnalyticsPage = lazy(() => import('@pages/analytics'))
const SettingsPage = lazy(() => import('@pages/settings'))

// Timer page โหลดปกติ (critical path)
```

## IndexedDB Optimization

- ใช้ index สำหรับ fields ที่ query บ่อย (`startedAt`, `taskId`, `status`)
- ใช้ `where()` + `between()` สำหรับ date range queries
- ไม่ใช้ `.filter()` กับ large collections
- Batch writes ด้วย `db.transaction()`

## Web Vitals Targets

| Metric | Target |
|---|---|
| FCP | < 1.5s |
| LCP | < 2.5s |
| TBT | < 200ms |
| CLS | < 0.1 |
| INP | < 200ms |
