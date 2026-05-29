---
description: Error handling patterns — ErrorBoundary, async errors, user-facing messages, ห้าม expose internals
paths:
  - src/**
---

# Error Handling Rules

## หลักการ

1. **User เห็น friendly message** — ไม่เห็น stack trace, error codes, หรือ internal details
2. **Developer เห็น context ครบ** — log เก็บ error จริงๆ ไว้ debug (production logging)
3. **App ไม่ crash** — ทุก async operation และ boundary มี error handler
4. **Fail gracefully** — ถ้า feature หนึ่งพัง feature อื่นยังทำงานได้

---

## ErrorBoundary

ทุก route และ feature ที่สำคัญต้องมี ErrorBoundary ครอบ

```typescript
// ✅ ครอบ page-level ทุก route
function App() {
  return (
    <Routes>
      <Route path="/" element={
        <ErrorBoundary fallback={<PageError />}>
          <TimerPage />
        </ErrorBoundary>
      } />
    </Routes>
  )
}

// ✅ ครอบ feature ที่ isolate ได้ (ถ้า analytics พัง timer ยังทำงานได้)
function TimerPage() {
  return (
    <>
      <TimerWidget />
      <ErrorBoundary fallback={<FeatureError feature="tasks" />}>
        <TaskList />
      </ErrorBoundary>
    </>
  )
}
```

### Fallback Component

```typescript
// ✅ friendly message + retry button
function PageError({ error, resetErrorBoundary }: FallbackProps) {
  return (
    <div role="alert">
      <h2>เกิดข้อผิดพลาด</h2>
      <p>กรุณาลองใหม่อีกครั้ง ถ้ายังพังให้ reload หน้า</p>
      <button onClick={resetErrorBoundary}>ลองใหม่</button>
    </div>
  )
}

// ❌ ห้าม expose error details ต่อ user
function BadError({ error }: { error: Error }) {
  return <p>{error.message}</p>   // อาจมี internal info
  return <p>{error.stack}</p>     // ห้ามเด็ดขาด
}
```

---

## Async Error Handling

### IndexedDB Operations (Dexie)

```typescript
// ✅ ทุก Dexie operation ต้องมี try-catch
async function saveSession(session: Session): Promise<void> {
  try {
    await db.sessions.add(session)
  } catch (error) {
    if (error instanceof Dexie.BulkError) {
      // handle duplicate key
    }
    throw new StorageError('บันทึก session ไม่สำเร็จ', { cause: error })
  }
}

// ❌ ห้าม — async โดยไม่มี error handler
async function saveSession(session: Session) {
  await db.sessions.add(session)   // ถ้าพัง error หายเงียบ
}
```

### Web APIs (Notifications, Audio)

```typescript
// ✅ API ที่อาจ fail ต้องมี fallback
async function requestNotificationPermission(): Promise<boolean> {
  try {
    const result = await Notification.requestPermission()
    return result === 'granted'
  } catch {
    return false  // permission denied หรือ API ไม่รองรับ — ไม่ crash
  }
}
```

### JSON Parse

```typescript
// ✅ ใช้ safe parse wrapper เสมอ
function safeJsonParse<T>(raw: string): T | null {
  try {
    return JSON.parse(raw) as T
  } catch {
    return null
  }
}

// ❌ ห้าม
const data = JSON.parse(raw)   // ถ้า raw ไม่ใช่ JSON → crash
```

---

## Custom Error Classes

สร้าง custom errors สำหรับแต่ละ domain เพื่อให้ catch แยกประเภทได้

```typescript
// src/shared/lib/errors.ts

export class StorageError extends Error {
  constructor(message: string, options?: ErrorOptions) {
    super(message, options)
    this.name = 'StorageError'
  }
}

export class ValidationError extends Error {
  constructor(message: string, public field?: string) {
    super(message)
    this.name = 'ValidationError'
  }
}

export class TimerError extends Error {
  constructor(message: string) {
    super(message)
    this.name = 'TimerError'
  }
}
```

```typescript
// ✅ catch แยกตาม error type
try {
  await importData(file)
} catch (error) {
  if (error instanceof ValidationError) {
    setFieldError(error.field, error.message)  // แสดงใต้ field
  } else if (error instanceof StorageError) {
    showToast('นำเข้าข้อมูลไม่สำเร็จ กรุณาลองใหม่')
  } else {
    throw error  // re-throw unexpected errors
  }
}
```

---

## User-Facing Error Messages

```typescript
// ✅ ภาษาที่ user เข้าใจ บอกว่าต้องทำอะไรต่อ
'บันทึกไม่สำเร็จ กรุณาลองใหม่'
'ไฟล์ข้อมูลไม่ถูกต้อง กรุณาตรวจสอบไฟล์แล้วนำเข้าใหม่'
'เบราว์เซอร์ไม่รองรับ notification กรุณาอนุญาตการแจ้งเตือนในการตั้งค่า'

// ❌ ห้ามแสดงต่อ user
'DexieError: Failed to execute transaction'
'TypeError: Cannot read property of undefined at timer-store.ts:42'
'QuotaExceededError: The quota has been exceeded'
```

### Error Display Pattern

| สถานการณ์ | วิธีแสดง |
|---|---|
| Form validation | Inline ใต้ field (ไม่ใช่ toast) |
| Action ล้มเหลว (save, delete) | Toast notification สั้นๆ |
| Feature ทั้งหมดพัง | Fallback UI + retry button |
| Page crash | ErrorBoundary fallback |
| ไม่มีข้อมูล | Empty state + CTA (ไม่ใช่ error) |

---

## Zustand Store Error State

```typescript
// ✅ เก็บ error state ใน store สำหรับ async operations
interface TaskStore {
  tasks: Task[]
  isLoading: boolean
  error: string | null          // user-facing message เท่านั้น
  loadTasks: () => Promise<void>
  clearError: () => void
}

const useTaskStore = create<TaskStore>((set) => ({
  tasks: [],
  isLoading: false,
  error: null,
  loadTasks: async () => {
    set({ isLoading: true, error: null })
    try {
      const tasks = await db.tasks.toArray()
      set({ tasks, isLoading: false })
    } catch {
      set({ error: 'โหลดข้อมูลไม่สำเร็จ', isLoading: false })
    }
  },
  clearError: () => set({ error: null }),
}))
```

---

## สิ่งที่ห้าม

- ❌ `catch (e) {}` — catch แล้วเงียบ (silent failure)
- ❌ แสดง `error.message` หรือ `error.stack` ต่อ user โดยตรง
- ❌ `console.error` เป็น error handling เดียว (ต้องมี user feedback ด้วย)
- ❌ `throw new Error('something went wrong')` — message ไม่ specific พอสำหรับ debug
- ❌ Async function ใน `useEffect` โดยไม่มี error handler ครอบ
