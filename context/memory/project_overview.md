---
name: project-overview
description: เป้าหมาย ขอบเขต และ success criteria ของ Pomodoro Application
metadata:
  type: project
---

# Project Overview — Pomodoro Application

## Vision

แอปพลิเคชัน Pomodoro timer แบบ offline-first ที่ช่วยให้ผู้ใช้งานจัดการ focus sessions, ติดตาม tasks, และวิเคราะห์รูปแบบ productivity ของตัวเอง โดยไม่ต้องส่งข้อมูลใดๆ ออกไปภายนอก

## Core Features (MVP)

1. **Timer Engine** — Pomodoro (25 min), Short Break (5 min), Long Break (15 min) พร้อม auto-cycle
2. **Task Management** — สร้าง/แก้ไข/ลบ tasks, กำหนด estimated Pomodoros, track progress
3. **Session Logging** — บันทึก completed/interrupted sessions พร้อม timestamp และ notes
4. **Notifications** — OS-level notifications และ audio alerts เมื่อ timer หมด
5. **Settings** — ปรับ timer durations, notification preferences, audio on/off

## Extended Features (Post-MVP)

6. **Analytics Dashboard** — charts ของ daily/weekly/monthly productivity trends
7. **Tags & Categories** — จัดกลุ่ม tasks ด้วย tags
8. **Data Export** — export session history เป็น CSV/JSON
9. **Themes** — dark/light mode พร้อม custom color schemes
10. **Keyboard Shortcuts** — shortcut ครบทุก action

## Success Criteria

- User สามารถเริ่ม/หยุด/reset timer ได้ภายใน 2 clicks หรือ keyboard shortcut
- Session history ยังคงอยู่หลัง browser refresh
- Timer ทำงานถูกต้องแม้ browser tab ถูก minimize
- ผ่าน Lighthouse score ≥ 90 ทุก category
- ผ่าน axe accessibility audit (zero critical violations)

## Out of Scope

- User accounts / authentication
- Cloud sync / multi-device
- Team features / shared sessions
- Mobile native apps (web only)
- Monetization / premium features

**Why:** เน้นความเรียบง่าย privacy-first และ zero-dependency infrastructure เพื่อให้ maintain ง่าย
**How to apply:** ปฏิเสธ feature requests ที่ต้องการ backend หรือ external API โดยอัตโนมัติ
