# Prompt: Timer Accuracy Debug

## When to Use
ใช้เมื่อ timer ไม่แม่นยำ, drift เกิน ±500ms, หรือหยุดทำงานใน background tab

---

## Prompt Template

```
The Pomodoro timer has an accuracy problem.

**Specific issue:**
{{e.g., "Timer loses ~5 seconds after switching tabs", "Timer drifts 2 seconds per minute"}}

**Test scenario:**
- Timer state when issue occurs: {{running/paused/background}}
- Browser: {{Chrome/Firefox/Safari}}
- Tab visibility: {{foreground/background}}

**Expected:** Timer accurate to ±100ms over full 25-minute session
**Actual:** {{describe the drift}}

**Current implementation location:** `src/entities/timer/timer-store.ts`

**Please help diagnose:**
1. Is this a visibilitychange issue or a fundamental drift issue?
2. Is the drift-correction code (`Date.now()` comparison) working correctly?
3. Is the setTimeout being cleared and re-scheduled properly on pause/resume?

**Debugging steps to add:**
```typescript
// Add to timer tick function temporarily
console.log({
  expected: Date.now() - startTime,
  actual: (totalDuration - secondsRemaining) * 1000,
  drift: /* calculate */
})
```
```
