# Phase 5: Settings

**Status:** 🔲 Not Started  
**Target:** 2026-06-21  
**Depends on:** Phase 3, Phase 4 complete  
**Goal:** ให้ user ปรับแต่ง timer durations, notification preferences, และ appearance

## Settings Schema

```typescript
interface UserSettings {
  timer: {
    workDuration: number        // minutes, default: 25, range: 1–60
    shortBreakDuration: number  // minutes, default: 5,  range: 1–30
    longBreakDuration: number   // minutes, default: 15, range: 5–60
    longBreakInterval: number   // Pomodoros, default: 4, range: 2–8
    autoStartBreaks: boolean    // default: false
    autoStartWork: boolean      // default: false
  }
  notifications: {
    browserEnabled: boolean     // default: true
    soundEnabled: boolean       // default: true
    volume: number              // 0–100, default: 70
    soundTheme: 'classic' | 'digital' | 'soft'
  }
  appearance: {
    theme: 'system' | 'light' | 'dark'
    accentColor: string         // hex, default: '#e63946'
    showProgressInTitle: boolean // default: true (shows "23:45 - Pomodoro" in tab title)
  }
}
```

## Deliverables

- `src/entities/settings/` — SettingsStore, Settings types, defaults
- `src/features/settings-editor/` — SettingsForm, all form sections
- `src/pages/settings/` — Settings page
- Integration: timer durations sync ไปยัง TimerStore เมื่อ save settings

## Acceptance Criteria

- [ ] Settings persist หลัง page reload
- [ ] เปลี่ยน timer durations แล้ว timer ที่ idle จะ update ทันที
- [ ] เปลี่ยน theme แล้ว UI เปลี่ยนทันทีโดยไม่ต้อง reload
- [ ] Volume slider preview เสียงได้ (debounced 300ms)
- [ ] Reset to defaults button ทำงานถูกต้อง
- [ ] Form validation: ตรวจสอบ range ของทุก numeric field

## Notes

- Settings page ใช้ collapsible sections (Timer / Notifications / Appearance)
- showProgressInTitle: update `document.title` ทุก tick ใน TimerStore
- accentColor: inject เป็น CSS custom property `--color-accent` ที่ `:root`
