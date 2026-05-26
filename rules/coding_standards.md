# Coding Standards

## TypeScript

```typescript
// ✅ Good — explicit return type on public functions
export function formatTime(seconds: number): string { ... }

// ❌ Bad — implicit any
function processData(data: any) { ... }

// ✅ Good — discriminated union over boolean flags
type TimerStatus = 'idle' | 'running' | 'paused' | 'completed'

// ❌ Bad — boolean flag hell
interface Timer { isRunning: boolean; isPaused: boolean; isCompleted: boolean }

// ✅ Good — readonly for data that shouldn't mutate
interface Task { readonly id: string; title: string }

// ✅ Good — satisfies operator for typed constants
const DEFAULT_SETTINGS = {
  workDuration: 25,
  shortBreakDuration: 5,
} satisfies Partial<UserSettings>
```

## React Components

```typescript
// ✅ Good — named export, typed props, no default export
export interface TimerWidgetProps {
  className?: string
}
export function TimerWidget({ className }: TimerWidgetProps) { ... }

// ❌ Bad — default export (hard to refactor, bad tree-shaking)
export default function TimerWidget() { ... }

// ✅ Good — composition over prop drilling (max 2 levels)
// If props go deeper, use Zustand store or React context

// ✅ Good — early return for loading/empty states
function TaskList() {
  const tasks = useTaskStore(s => s.tasks)
  if (tasks.length === 0) return <EmptyState />
  return <ul>...</ul>
}
```

## File Naming & Organization

```
// Files: kebab-case
timer-widget.tsx
use-timer.ts
format-time.ts

// Components: PascalCase export matching filename
// timer-widget.tsx → export function TimerWidget

// Test files: co-located, .test.ts suffix
timer-store.ts
timer-store.test.ts

// Types: exported from entity index
src/entities/timer/index.ts  ← re-export everything public
```

## Imports

```typescript
// Import order (enforced by ESLint import/order):
// 1. React
// 2. External packages
// 3. Internal @-aliased paths (alphabetical within layer)
// 4. Relative paths (only within same module)

import { useEffect } from 'react'
import { create } from 'zustand'
import { formatTime } from '@shared/lib/format-time'
import { TimerStatus } from './timer.types'
```

## Zustand Store Pattern

```typescript
// ✅ Preferred pattern — actions co-located with state
interface TimerStore {
  status: TimerStatus
  secondsRemaining: number
  start: () => void
  pause: () => void
  reset: () => void
}

export const useTimerStore = create<TimerStore>((set, get) => ({
  status: 'idle',
  secondsRemaining: 25 * 60,
  start: () => set({ status: 'running' }),
  pause: () => set({ status: 'paused' }),
  reset: () => set({ status: 'idle', secondsRemaining: 25 * 60 }),
}))
```

## Forbidden Patterns

- ❌ `console.log` ใน production code (ใช้ structured logger แทน)
- ❌ `// @ts-ignore` หรือ `// @ts-nocheck` (แก้ type error จริงๆ)
- ❌ `!` non-null assertion โดยไม่มี comment อธิบาย
- ❌ `useEffect` สำหรับ data transformation (ทำใน render หรือ useMemo แทน)
- ❌ Inline styles (`style={{ }}`) — ใช้ Tailwind classes เสมอ
- ❌ Magic numbers — extract เป็น named constant
