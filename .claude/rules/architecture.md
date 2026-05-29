---
description: Feature-Sliced Design (FSD) layer rules — import direction, module boundaries, what goes where
paths:
  - src/**
---

# Architecture Rules — Feature-Sliced Design (FSD)

## Layer Structure

```
src/
├── app/        — app setup, routing, global providers, root styles
├── pages/      — page-level components, route definitions
├── features/   — user-facing feature modules (timer, tasks, notifications, analytics, settings)
├── entities/   — core domain objects (session, task, settings)
└── shared/     — reusable utilities, UI components, types, constants
```

## Import Direction Rules (บังคับเด็ดขาด)

Layer บนสามารถ import จาก layer ล่างได้ แต่ **ห้าม import ย้อนขึ้น**

```
app → pages → features → entities → shared
 ✅ pages import จาก features
 ✅ features import จาก entities
 ✅ features import จาก shared
 ❌ shared import จาก features       ← ห้าม
 ❌ entities import จาก features     ← ห้าม
 ❌ features import จาก pages        ← ห้าม
```

**กฎที่สำคัญที่สุด:**

```typescript
// ❌ ห้าม — feature import จาก feature อื่น (cross-feature import)
// src/features/tasks/ui/task-list.tsx
import { useTimerStore } from '@features/timer'

// ✅ ถูก — ถ้าต้องการ share ข้าม features ให้ย้ายไป entities หรือ shared
import { useTimerStore } from '@entities/timer'
```

---

## แต่ละ Layer ใส่อะไร

### `app/`
- Router setup (`react-router-dom`)
- Global providers (QueryClient, ThemeProvider)
- Global styles และ CSS reset
- App entry point

```
src/app/
├── providers/      — context providers รวมกัน
├── router/         — route definitions
└── styles/         — global CSS, Tailwind base
```

### `pages/`
- Page-level components — compose features เข้าด้วยกัน
- ไม่มี business logic ของตัวเอง
- ไม่ query data โดยตรง — รับจาก features

```
src/pages/
├── timer/          — TimerPage.tsx
├── analytics/      — AnalyticsPage.tsx (lazy loaded)
└── settings/       — SettingsPage.tsx (lazy loaded)
```

### `features/`
- User-facing functionality พร้อม UI
- มี store, hooks, components, และ API calls ของตัวเอง
- **ห้าม import จาก feature อื่น** — ถ้าต้องการ share ให้ย้ายไป `entities/` หรือ `shared/`

```
src/features/
├── timer/
│   ├── model/      — store, hooks (useTimer)
│   ├── ui/         — TimerWidget, TimerControls, PhaseIndicator
│   └── index.ts    — public API (export เฉพาะสิ่งที่ต้องการให้ layer บน import)
├── tasks/
├── notifications/
├── analytics/
└── settings/
```

### `entities/`
- Core domain objects และ business rules
- Types, interfaces, constants สำหรับ domain
- Store ที่ share ข้าม features ได้
- **ไม่มี UI** — ไม่มี React components

```
src/entities/
├── timer/
│   ├── timer.types.ts     — TimerStatus, TimerPhase, TimerConfig
│   ├── timer-store.ts     — Zustand store (shared state)
│   └── index.ts
├── task/
│   ├── task.types.ts      — Task, TaskStatus, TaskPriority
│   └── index.ts
├── session/
│   ├── session.types.ts   — Session, SessionStatus
│   └── index.ts
└── settings/
    ├── settings.types.ts  — UserSettings, ThemeMode
    └── index.ts
```

### `shared/`
- Reusable ทั่วไป ไม่ผูกกับ domain ใดๆ
- **ห้ามมี business logic** — generic เท่านั้น

```
src/shared/
├── ui/             — Button, Input, Modal, ProgressRing (generic components)
├── lib/            — formatTime, cn, debounce (utilities)
├── types/          — Id, Nullable, DeepPartial (generic types)
├── constants/      — TIMER_DURATIONS, BREAKPOINTS
└── config/         — env variables, app config
```

---

## Path Aliases (tsconfig)

```typescript
// ใช้ @ aliases เสมอ — ห้ามใช้ relative path ข้าม layers
import { Button } from '@shared/ui'           // ✅
import { useTimerStore } from '@entities/timer' // ✅
import { TimerWidget } from '@features/timer'  // ✅

import { Button } from '../../../shared/ui'   // ❌ ห้าม
```

---

## Public API — index.ts

ทุก feature และ entity ต้องมี `index.ts` ที่ export เฉพาะสิ่งที่ต้องการให้ layer บน import

```typescript
// src/features/timer/index.ts
export { TimerWidget } from './ui/timer-widget'
export { useTimer } from './model/use-timer'
// ไม่ export internal implementation details
```

```typescript
// ❌ ห้าม import ลึกเข้าไปใน feature
import { TimerWidget } from '@features/timer/ui/timer-widget'

// ✅ import ผ่าน public API เท่านั้น
import { TimerWidget } from '@features/timer'
```

---

## Zustand Store Placement

| Store | Layer | เหตุผล |
|---|---|---|
| `useTimerStore` | `entities/timer` | shared ข้าม features (tasks ต้องการรู้ timer status) |
| `useTaskStore` | `entities/task` | shared ข้าม features |
| `useSettingsStore` | `entities/settings` | shared ทั้ง app |
| `useAnalyticsStore` | `features/analytics` | ใช้เฉพาะ analytics feature |

กฎ: ถ้า store ถูกใช้โดยมากกว่า 1 feature → ย้ายไป `entities/`
