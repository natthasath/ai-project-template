# Prompt: Bug Investigation

## When to Use
ใช้เมื่อพบ bug ที่ root cause ยังไม่ชัดเจน

---

## Prompt Template

```
I'm investigating a bug in the Pomodoro application.

**Bug description:**
{{DESCRIBE WHAT'S WRONG}}

**Steps to reproduce:**
1. {{STEP 1}}
2. {{STEP 2}}
3. {{STEP 3}}

**Expected behavior:**
{{WHAT SHOULD HAPPEN}}

**Actual behavior:**
{{WHAT ACTUALLY HAPPENS}}

**Environment:**
- Browser: {{Chrome/Firefox/Safari + version}}
- OS: {{Windows/Mac/Linux}}
- App state when bug occurs: {{e.g., "after 3 Pomodoros, timer in paused state"}}

**What I've already checked:**
{{LIST THINGS ALREADY INVESTIGATED}}

**Relevant files (suspected):**
{{LIST FILES}}

**Please help me:**
1. Identify the most likely root cause
2. Suggest specific things to add (console.logs, debugger, tests) to confirm
3. Propose a fix once root cause is confirmed
```

---

## Common Bug Categories in Pomodoro Apps

| Category | Typical Cause | Where to Look |
|---|---|---|
| Timer inaccuracy | Missing drift correction, setInterval instead of setTimeout | `entities/timer/timer-store.ts` |
| Timer pauses in background | Browser throttling, no visibilitychange handler | `entities/timer/timer-store.ts` |
| State not persisting | Write-through not implemented, Dexie transaction error | `entities/session/`, `entities/task/` |
| Notification not firing | Permission 'denied', AudioContext suspended | `features/notification/` |
| Re-render performance | Broad Zustand selector, missing memo | Component using `useTimerStore()` |
| Phase transition bug | Off-by-one in cycle count | `entities/timer/timer-store.ts` |
