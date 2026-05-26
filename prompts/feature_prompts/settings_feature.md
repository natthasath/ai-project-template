# Prompt: Settings Feature

## When to Use
ใช้เมื่อต้องการ build หรือแก้ไข settings form, settings persistence, หรือ settings integration

---

## Prompt Template

```
I'm working on the settings system for the Pomodoro application.

**Context:**
- Settings persisted in localStorage with prefix 'pomodoro_'
- Settings schema in memory/architecture.md (timer, notifications, appearance sections)
- Changing timer durations should update idle TimerStore immediately
- Changing theme injects CSS custom property --color-accent at :root
- showProgressInTitle: updates document.title in TimerStore tick callback

**Validation ranges:**
- workDuration: 1–60 min (default: 25)
- shortBreakDuration: 1–30 min (default: 5)  
- longBreakDuration: 5–60 min (default: 15)
- longBreakInterval: 2–8 Pomodoros (default: 4)
- volume: 0–100 (default: 70)

**Task:**
{{DESCRIBE THE SETTINGS TASK}}

**Constraints:**
- Form validation: show inline errors under each field (not alert popups)
- Volume slider: debounce 300ms, preview sound on change
- "Reset to defaults" requires confirmation dialog
- Settings changes take effect immediately (no save button needed for toggles)
  Exception: timer duration changes require explicit save (affects running behavior)

**Files to modify:**
{{LIST FILES}}
```
