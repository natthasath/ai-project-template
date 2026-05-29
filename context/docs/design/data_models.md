# Data Models — Pomodoro Application

## Core Types

### Timer (In-Memory Only)

```typescript
type TimerPhase = 'work' | 'short-break' | 'long-break'
type TimerStatus = 'idle' | 'running' | 'paused' | 'completed'

interface TimerState {
  phase: TimerPhase
  status: TimerStatus
  secondsRemaining: number
  totalSeconds: number          // full duration of current phase
  cycleCount: number            // work sessions completed in current cycle (0-3)
  totalPomodorosToday: number   // incremented on work session complete
  lastTickTime: number | null   // Date.now() at last tick (for drift correction)
  activeTaskId: string | null
}
```

### Task (Persisted to IndexedDB)

```typescript
interface Task {
  id: string                              // crypto.randomUUID()
  title: string                           // 1–200 chars, HTML-stripped
  estimatedPomodoros: number              // 1–20
  completedPomodoros: number              // auto-incremented
  status: 'pending' | 'active' | 'completed'
  tags: string[]                          // each tag max 30 chars
  notes: string                           // 0–2000 chars, HTML-stripped
  createdAt: Date
  updatedAt: Date
  completedAt: Date | null
}
```

### Session (Persisted to IndexedDB)

```typescript
interface Session {
  id?: number                             // auto-increment (Dexie)
  taskId: string | null                   // null if no active task
  phase: 'work' | 'short-break' | 'long-break'
  status: 'completed' | 'interrupted'
  startedAt: Date
  completedAt: Date
  durationSeconds: number                 // actual, may differ from configured
  notes: string                           // optional user note
}
```

### UserSettings (Persisted to localStorage)

```typescript
interface UserSettings {
  timer: {
    workDuration: number           // default: 25
    shortBreakDuration: number     // default: 5
    longBreakDuration: number      // default: 15
    longBreakInterval: number      // default: 4
    autoStartBreaks: boolean       // default: false
    autoStartWork: boolean         // default: false
  }
  notifications: {
    browserEnabled: boolean        // default: true
    soundEnabled: boolean          // default: true
    volume: number                 // default: 70 (0–100)
    soundTheme: 'classic' | 'digital' | 'soft'  // default: 'classic'
  }
  appearance: {
    theme: 'system' | 'light' | 'dark'   // default: 'system'
    accentColor: string                   // default: '#e63946'
    showProgressInTitle: boolean          // default: true
  }
}
```

## Database Schema (Dexie.js v4)

```typescript
// IndexedDB database: 'PomodoroApp'
// Version 1

sessions: {
  ++id,           // auto-increment primary key
  taskId,         // indexed (query sessions by task)
  startedAt,      // indexed (date range queries for analytics)
  completedAt,    // indexed
  phase,          // not indexed (low cardinality, filter in JS)
  status          // not indexed (filter in JS)
}

tasks: {
  ++id,           // auto-increment primary key (internal)
  &uuid,          // unique index on UUID string id
  status,         // indexed (filter active/pending/completed)
  createdAt,      // indexed (sort order)
  completedAt     // indexed (analytics)
}
```

## Data Lifecycle

```
Task:    created → pending → active → completed → [never deleted by default]
Session: started → completed | interrupted → [archived after 1 year optional]
Settings: created on first load → updated on change → never deleted
```
