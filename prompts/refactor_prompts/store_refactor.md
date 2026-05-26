# Prompt: Zustand Store Refactor

## When to Use
ใช้เมื่อ store มี actions มากเกินไป, state shape ผิด, หรือ performance issues จาก broad subscriptions

---

## Prompt Template

```
I need to refactor a Zustand store in the Pomodoro application.

**Store to refactor:**
{{FILE PATH}}

**Problem:**
{{e.g., "TimerStore has grown to 15 actions, hard to reason about", 
  "Components subscribing to whole store causing unnecessary re-renders"}}

**Current store structure:**
{{PASTE CURRENT STATE INTERFACE}}

**Desired outcome:**
{{e.g., "Split into TimerStore + SessionStore", "Add selector helpers to prevent re-renders"}}

**Constraints:**
- All existing store consumers must continue working
- TypeScript types must remain strict
- No behavior changes — internal restructure only
- Add computed selectors where beneficial

**Please:**
1. Identify issues in current store design
2. Propose new structure
3. Show migration path (how to update consumers)
4. Identify which tests need updating
```
