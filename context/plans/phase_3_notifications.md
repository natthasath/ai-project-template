# Phase 3: Notifications & Audio

**Status:** 🔲 Not Started  
**Target:** 2026-06-14  
**Depends on:** Phase 1 complete  
**Goal:** แจ้งเตือน user เมื่อ timer phases เปลี่ยน ทั้ง OS notification และ audio

## Objectives

1. Implement Web Notifications API wrapper
2. Implement Web Audio API sound engine (no external files)
3. Create `NotificationService` singleton
4. Request notification permission gracefully (not on page load)
5. Support: timer complete, break start, long break start sounds
6. Volume control + mute toggle

## Audio Design

```
Work Complete  → "ding-ding" (high pitch, 2 tones)
Break Complete → "dong"      (low pitch, 1 tone, gentle)
Long Break     → "gong"      (sustained low pitch)
```
เสียงทั้งหมดสร้างด้วย Web Audio API OscillatorNode — ไม่ต้องโหลดไฟล์เสียงภายนอก

## Notification Content

| Event | Title | Body |
|---|---|---|
| Work complete | "Time for a break! 🍵" | "Pomodoro #{n} complete. Take a {duration} min break." |
| Short break end | "Back to work! 💪" | "Break's over. Ready for Pomodoro #{n}?" |
| Long break end | "Back to work! 🚀" | "Long break complete. Starting a new cycle." |

## Deliverables

- `src/features/notification/` — NotificationService, AudioEngine, useNotification hook
- `src/shared/lib/audio/` — oscillator helpers, sound presets
- Integration กับ TimerStore `onPhaseComplete` callback

## Acceptance Criteria

- [ ] Notification permission prompt แสดงหลัง user click start ครั้งแรก (ไม่ใช่ตอน load)
- [ ] OS notification ปรากฏเมื่อ timer complete (แม้ tab เป็น background)
- [ ] Audio เล่นได้ใน Chrome, Firefox, Safari
- [ ] Mute toggle ทำงานทันที (mid-session)
- [ ] ไม่มี audio glitch เมื่อ sounds overlap

## Notes

- iOS Safari: Web Audio ต้องถูก trigger จาก user gesture ครั้งแรก — ต้องสร้าง AudioContext ใน click handler
- Notification permission: 'default' → request, 'granted' → use, 'denied' → show in-app toast แทน
- ใช้ GainNode สำหรับ fade-out ของ oscillator แทนการ stop() กะทันหัน (ป้องกัน click noise)
