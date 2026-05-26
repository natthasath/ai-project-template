---
name: architecture
description: รูปแบบ architecture, design patterns, และ folder structure ของ application
metadata:
  type: project
---

# Architecture Decisions

## Application Architecture: Feature-Sliced Design (FSD)

โปรเจคใช้ Feature-Sliced Design เพราะแบ่งแยก concerns ได้ชัดเจนและ scale ได้ดีกว่า component-based structure ทั่วไป

```
src/
├── app/              # App-level: providers, router, global styles
│   ├── providers/
│   ├── store/
│   └── styles/
├── pages/            # Page compositions (Timer, Analytics, Settings)
├── widgets/          # Complex independent UI blocks (TimerWidget, TaskList)
├── features/         # User interactions with business value
│   ├── timer-control/      (start/pause/reset)
│   ├── task-manager/       (CRUD tasks)
│   ├── session-logger/     (log completed sessions)
│   ├── notification/       (OS + audio alerts)
│   └── settings-editor/    (update user config)
├── entities/         # Business entities (Timer, Task, Session, Settings)
│   ├── timer/
│   ├── task/
│   ├── session/
│   └── settings/
└── shared/           # Reusable primitives with no business logic
    ├── ui/           (Button, Modal, Badge, ProgressRing)
    ├── lib/          (formatTime, classnames, storage helpers)
    ├── hooks/        (useLocalStorage, useVisibilityTimer)
    └── types/        (global TypeScript types)
```

## State Architecture

```
TimerStore (Zustand)
├── phase: 'work' | 'short-break' | 'long-break'
├── status: 'idle' | 'running' | 'paused' | 'completed'
├── secondsRemaining: number
├── cycleCount: number
└── actions: start(), pause(), reset(), tick(), nextPhase()

TaskStore (Zustand)
├── tasks: Task[]
├── activeTaskId: string | null
└── actions: addTask(), updateTask(), deleteTask(), setActive()

SessionStore (Zustand)
├── sessions: Session[]    ← synced to IndexedDB via Dexie.js
└── actions: logSession(), deleteSession()

SettingsStore (Zustand)
├── durations: { work, shortBreak, longBreak }
├── autoStartBreaks: boolean
├── notifications: { enabled, sound, volume }
└── actions: updateSettings()
```

## Timer Accuracy Strategy

ใช้ `setTimeout` + `Date.now()` drift correction (ไม่ใช่ `setInterval`) เพื่อรับประกัน accuracy แม้ browser throttle background tabs

```
tick() {
  const now = Date.now()
  const drift = now - this.lastTickTime - 1000
  this.secondsRemaining -= 1
  this.lastTickTime = now
  scheduleNext(Math.max(0, 1000 - drift))
}
```

## Data Persistence Layer

- **Zustand** stores hold in-memory state (fast reads for timer UI)
- **Dexie.js** persists Sessions and Tasks to IndexedDB (survives page reload)
- **localStorage** persists Settings (small, synchronous access on startup)
- Sync strategy: write-through on every mutation (no batching needed at this scale)

**Why:** Separation of concerns — timer state is ephemeral, session history is durable
**How to apply:** Timer state never goes to IndexedDB. Session/Task data never stays only in memory. [[tech-stack]]
