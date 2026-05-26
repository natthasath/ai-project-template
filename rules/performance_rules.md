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
// ✅ Zustand selector — subscribe เฉพาะ field ที่ใช้ (ป้องกัน unnecessary re-renders)
const secondsRemaining = useTimerStore(s => s.secondsRemaining)  // re-renders ทุก tick
const status = useTimerStore(s => s.status)                       // re-renders เมื่อ status เปลี่ยนเท่านั้น

// ❌ Bad — subscribe ทั้ง store object
const store = useTimerStore()  // re-renders ทุก tick แม้ component ใช้แค่ status

// ✅ useMemo สำหรับ expensive derivations เท่านั้น (ไม่ใช้ถ้าไม่จำเป็น)
const sortedTasks = useMemo(() => [...tasks].sort(byCreatedAt), [tasks])

// ✅ Timer tick ต้องอยู่ใน store (ไม่ใน component) — ป้องกัน timer lag จาก React rendering
```

## Memory Management

```typescript
// ✅ ล้าง intervals/listeners ทุกครั้งใน cleanup
useEffect(() => {
  const interval = setInterval(tick, 1000)
  return () => clearInterval(interval)  // cleanup!
}, [])

// ✅ Dexie query: ใช้ limit() สำหรับ large collections
const recentSessions = await db.sessions
  .orderBy('startedAt')
  .reverse()
  .limit(100)
  .toArray()

// ❌ อย่า load session history ทั้งหมดในครั้งเดียว (อาจมีหลายพัน records)
const allSessions = await db.sessions.toArray()  // อันตราย
```

## Lazy Loading

```typescript
// ✅ Lazy load routes ที่ไม่ใช่ initial view
const AnalyticsPage = lazy(() => import('@pages/analytics'))
const SettingsPage = lazy(() => import('@pages/settings'))

// Timer page โหลดปกติ (critical path)
import { TimerPage } from '@pages/timer'
```

## IndexedDB Query Optimization

- ใช้ index สำหรับ fields ที่ query บ่อย (`startedAt`, `taskId`, `status`)
- ใช้ `where()` + `between()` สำหรับ date range queries
- ไม่ใช้ `.filter()` กับ large collections — ทำให้ต้อง scan ทั้งตาราง
- Batch writes ด้วย `db.transaction()` เมื่อต้องการ write หลาย records พร้อมกัน

## Web Vitals Targets

| Metric | Target |
|---|---|
| First Contentful Paint (FCP) | < 1.5s |
| Largest Contentful Paint (LCP) | < 2.5s |
| Total Blocking Time (TBT) | < 200ms |
| Cumulative Layout Shift (CLS) | < 0.1 |
| Interaction to Next Paint (INP) | < 200ms |
