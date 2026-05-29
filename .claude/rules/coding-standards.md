---
description: มาตรฐาน TypeScript, React, Zustand สำหรับ Pomodoro app
paths:
  - src/**
  - tests/**
---

# Coding Standards

## TypeScript

```typescript
// ✅ ดี — ระบุ return type ชัดเจนบน public functions
export function formatTime(seconds: number): string { ... }

// ❌ ห้าม — implicit any
function processData(data: any) { ... }

// ✅ ดี — discriminated union แทน boolean flags
type TimerStatus = 'idle' | 'running' | 'paused' | 'completed'

// ✅ ดี — readonly สำหรับ data ที่ไม่ควร mutate
interface Task { readonly id: string; title: string }

// ✅ ดี — satisfies operator สำหรับ typed constants
const DEFAULT_SETTINGS = {
  workDuration: 25,
  shortBreakDuration: 5,
} satisfies Partial<UserSettings>
```

## React Components

```typescript
// ✅ named export, typed props, ไม่ใช้ default export
export interface TimerWidgetProps { className?: string }
export function TimerWidget({ className }: TimerWidgetProps) { ... }

// ❌ ห้าม default export
export default function TimerWidget() { ... }

// ✅ early return สำหรับ loading/empty states
function TaskList() {
  const tasks = useTaskStore(s => s.tasks)
  if (tasks.length === 0) return <EmptyState />
  return <ul>...</ul>
}
```

## File Naming

```
// ไฟล์: kebab-case
timer-widget.tsx   use-timer.ts   format-time.ts

// Component: PascalCase ตรงกับชื่อไฟล์
// timer-widget.tsx → export function TimerWidget

// Test files: อยู่ถัดจากไฟล์ต้นทาง
timer-store.ts  →  timer-store.test.ts
```

## Import Order

```typescript
// 1. React
// 2. External packages
// 3. Internal @-aliased paths (เรียงตามตัวอักษรภายใน layer)
// 4. Relative paths (เฉพาะภายใน module เดียวกัน)
import { useEffect } from 'react'
import { create } from 'zustand'
import { formatTime } from '@shared/lib/format-time'
import { TimerStatus } from './timer.types'
```

## Zustand Store Pattern

```typescript
interface TimerStore {
  status: TimerStatus
  secondsRemaining: number
  start: () => void
  pause: () => void
  reset: () => void
}

export const useTimerStore = create<TimerStore>((set) => ({
  status: 'idle',
  secondsRemaining: 25 * 60,
  start: () => set({ status: 'running' }),
  pause: () => set({ status: 'paused' }),
  reset: () => set({ status: 'idle', secondsRemaining: 25 * 60 }),
}))
```

## Forbidden Patterns

- ❌ `console.log` ใน production code
- ❌ `// @ts-ignore` หรือ `// @ts-nocheck`
- ❌ `!` non-null assertion โดยไม่มี comment อธิบาย
- ❌ `useEffect` สำหรับ data transformation
- ❌ Inline styles (`style={{ }}`) — ใช้ Tailwind classes เสมอ
- ❌ Magic numbers — ต้อง extract เป็น named constant
