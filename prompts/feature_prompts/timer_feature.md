# Prompt: Timer Feature Development

## When to Use
ใช้ prompt นี้เมื่อต้องการ build, modify, หรือ extend timer-related functionality

## Context to Load First
ก่อนใช้ prompt นี้ อ่านไฟล์ต่อไปนี้:
- `memory/architecture.md` — Timer state machine และ drift correction strategy
- `plans/phase_1_timer.md` — Timer phase requirements
- `rules/coding_standards.md` — TypeScript และ Zustand patterns
- `rules/testing_rules.md` — Timer testing guidelines

---

## Prompt Template

```
I'm working on the Pomodoro application's timer feature.

**Context:**
- Architecture: Feature-Sliced Design, Zustand for state, React 19 + TypeScript
- Timer state lives in `src/entities/timer/timer-store.ts`
- Timer uses drift-correcting tick: Date.now() + setTimeout (NOT setInterval)
- Phases: work (25min) → short-break (5min) × 3 → long-break (15min), then cycle repeats
- State machine: idle → running → paused → running → completed

**Task:**
{{DESCRIBE THE TIMER TASK HERE}}

**Constraints:**
- TypeScript strict mode — no `any`, explicit return types on public functions
- Tests must be written alongside implementation using Vitest + fake timers
- No external libraries — only existing stack (React, Zustand, Tailwind)
- Timer must handle visibilitychange (background tab accuracy)

**Files to modify:**
{{LIST THE SPECIFIC FILES}}

**Acceptance criteria:**
{{LIST THE CRITERIA}}

Please implement this following the existing patterns in the codebase.
```

---

## Example Usage

```
I'm working on the Pomodoro application's timer feature.

**Context:**
[same as above]

**Task:**
Add a "skip to next phase" action that immediately completes the current timer phase 
and transitions to the next one (without counting the skipped session as completed).

**Constraints:**
[same as above]

**Files to modify:**
- src/entities/timer/timer-store.ts
- src/features/timer-control/SkipButton.tsx (new file)

**Acceptance criteria:**
- Skip button appears only when timer is running or paused
- Skipped sessions are NOT logged as completed sessions
- Phase transition logic is the same as natural completion
- Unit tests cover: skip from work→short-break, skip from last work→long-break
```

## Notes

- ถ้า Timer behavior เปลี่ยน ให้ update `memory/architecture.md` ด้วย
- Timer accuracy test: ใช้ `vi.useFakeTimers()` + `vi.advanceTimersByTime()`
