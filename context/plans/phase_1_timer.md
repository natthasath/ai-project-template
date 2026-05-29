# Phase 1: Core Timer Engine

**Status:** 🔲 Not Started  
**Target:** 2026-06-03  
**Depends on:** Phase 0 complete  
**Goal:** สร้าง timer engine ที่ accurate, testable, และ handles browser throttling

## Objectives

1. สร้าง `TimerStore` ด้วย Zustand (state machine pattern)
2. Implement drift-correcting tick mechanism
3. สร้าง `TimerWidget` component พร้อม circular progress ring
4. Handle `visibilitychange` event สำหรับ background tabs
5. สร้าง Timer page
6. Keyboard shortcuts: Space (start/pause), R (reset), N (next phase)

## State Machine

```
idle ──[start]──> running ──[pause]──> paused
                     │                   │
                  [tick]              [resume]──> running
                     │
               [complete]──> (auto-next or idle)
```

## Timer Phases & Cycle Logic

```
Work → Short Break → Work → Short Break → Work → Short Break → Work → Long Break
[1]       [1]       [2]       [2]       [3]       [3]       [4]       [4]
```
หลังจาก Long Break: cycle count reset, กลับไป Work [1]

## Deliverables

- `src/entities/timer/` — TimerStore, Timer types, timer utils
- `src/features/timer-control/` — StartButton, PauseButton, ResetButton, PhaseIndicator
- `src/widgets/timer-widget/` — TimerWidget (ประกอบ features + CircularProgress)
- `src/shared/ui/circular-progress/` — SVG-based circular progress ring
- `src/pages/timer/` — Timer page

## Acceptance Criteria

- [ ] Timer counts down accurately (±100ms over 25 minutes)
- [ ] Timer resumes correctly after browser tab switch
- [ ] Phase transitions fire correctly after 4 work sessions
- [ ] All controls respond to keyboard shortcuts
- [ ] Unit tests cover: tick accuracy, state transitions, cycle logic
- [ ] Component renders without hydration errors

## Notes

- ใช้ `Date.now()` ไม่ใช่ counter increment สำหรับ drift correction
- `visibilitychange` handler ต้อง recalculate seconds based on wall clock
- CircularProgress ใช้ SVG `stroke-dashoffset` animation
