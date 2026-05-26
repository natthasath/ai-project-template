# Prompt: Notification & Audio System

## When to Use
ใช้เมื่อต้องการ build หรือแก้ไข browser notifications หรือ audio alerts

---

## Prompt Template

```
I'm working on the notification and audio system for the Pomodoro application.

**Context:**
- Uses Web Notifications API (no library) — permission must be requested after user gesture
- Uses Web Audio API (no external audio files) — OscillatorNode for sound synthesis
- iOS Safari: AudioContext must be created on user gesture (click), not on load
- Notification states: 'default' → request, 'granted' → show, 'denied' → show in-app toast
- Audio: use GainNode for fade-out to prevent click noise on oscillator stop

**Platform quirks to handle:**
- iOS: AudioContext.state might be 'suspended' — call audioCtx.resume() in user gesture
- Firefox: Notification API available but requires HTTPS (localhost is fine for dev)
- Background tabs: Notifications still fire, audio depends on browser policy

**Task:**
{{DESCRIBE THE NOTIFICATION/AUDIO TASK}}

**Constraints:**
- No external audio files — generate all sounds with Web Audio API
- Permission prompt must NOT fire on page load
- Must degrade gracefully: if notifications denied, show in-app toast instead
- Test with mocked Notification API and mocked AudioContext

**Files to modify:**
{{LIST FILES}}
```

---

## Sound Design Reference

```
Work Complete:   OscillatorNode (sine, 880Hz → 1100Hz, 0.3s) + GainNode (fade out)
Break Complete:  OscillatorNode (sine, 440Hz, 0.5s) + GainNode (fade out)
Long Break:      OscillatorNode (triangle, 220Hz → 330Hz, 1.0s) + GainNode (slow fade)
```
