# System Design — Pomodoro Application

## Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                     Browser (Client Only)                │
│                                                         │
│  ┌─────────┐  ┌──────────┐  ┌──────────┐  ┌─────────┐ │
│  │  Pages  │  │ Widgets  │  │ Features │  │Entities │ │
│  │         │  │          │  │          │  │         │ │
│  │ /timer  │  │ Timer    │  │ timer-   │  │ Timer   │ │
│  │/analytics  │ Widget  │  │ control  │  │ Store   │ │
│  │/settings│  │ TaskList │  │ task-mgr │  │ Task    │ │
│  └────┬────┘  └────┬─────┘  └────┬─────┘  │ Store   │ │
│       │            │             │         │ Session │ │
│       └────────────┴─────────────┤         │ Store   │ │
│                                  │         └────┬────┘ │
│                                  │              │      │
│                         ┌────────▼──────────────▼────┐ │
│                         │      Zustand Stores         │ │
│                         │  (In-Memory Application     │ │
│                         │       State)                │ │
│                         └────────────┬────────────────┘ │
│                                      │                  │
│                         ┌────────────▼────────────────┐ │
│                         │    Persistence Layer         │ │
│                         │  ┌──────────┐ ┌──────────┐  │ │
│                         │  │ Dexie.js │ │ local-   │  │ │
│                         │  │(IndexedDB│ │ Storage  │  │ │
│                         │  │Sessions  │ │(Settings)│  │ │
│                         │  │  Tasks)  │ └──────────┘  │ │
│                         │  └──────────┘               │ │
│                         └────────────────────────────┘ │
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │              Browser APIs (No Server)             │  │
│  │  Web Notifications  │  Web Audio  │  Page Vis.   │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

## Data Flow

```
User Action (click / keyboard)
    ↓
Feature Component (timer-control, task-manager)
    ↓
Store Action (TimerStore.start(), TaskStore.addTask())
    ↓
State Update (Zustand immer-style set())
    ↓
React Re-render (only subscribed components)
    ↓
Side Effects (SessionRepository.save(), NotificationService.show())
    ↓
Persistence (Dexie.js writes to IndexedDB)
```

## Module Dependency Rules (FSD)

```
Allowed imports (top can import from bottom):
  app ──→ pages ──→ widgets ──→ features ──→ entities ──→ shared

Forbidden:
  shared → anything (shared is pure)
  entities → features (entities don't know about specific user interactions)
  Cross-feature imports (features/timer-control → features/task-manager is FORBIDDEN)
    Use entities as the shared data layer instead
```

## Key Technical Decisions

| Decision | Choice | Alternative Considered |
|---|---|---|
| Timer mechanism | setTimeout + Date.now() drift correction | setInterval (inaccurate) |
| State management | Zustand | Redux, MobX, Context |
| Persistence | Dexie.js + localStorage | SQLite WASM, PouchDB |
| Styling | Tailwind CSS v4 | CSS Modules, styled-components |
| Architecture | Feature-Sliced Design | Atomic Design, Domain-Driven |

Full rationale: see `docs/decisions/` ADRs
