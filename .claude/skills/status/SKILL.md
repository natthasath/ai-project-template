---
name: status
description: แสดงภาพรวมสถานะโปรเจค — phase, sprint, git status ในครั้งเดียว
tools:
  - Read
  - Bash
---

แสดงภาพรวมสถานะโปรเจค Pomodoro ทั้งหมด

อ่านไฟล์เหล่านี้แล้วสรุป:
1. `context/plans/PLAN.md` → phase ปัจจุบัน และ % เสร็จ
2. `context/tasks/in_progress/current_sprint.md` → งานที่กำลังทำ
3. `context/tasks/backlog/phase_0_backlog.md` หรือ phase ปัจจุบัน → top 3 tasks รอทำ
4. รัน `git status` → มี uncommitted changes ไหม
5. รัน `git log --oneline -5` → commits ล่าสุด

แสดงผลในรูปแบบนี้:
─────────────────────────────────
📍 Phase ปัจจุบัน: [ชื่อ] ([X/Y tasks เสร็จ])
🔄 กำลังทำ: [ชื่อ tasks]
📋 รอทำต่อ: [top 3 tasks จาก backlog]
🌿 Branch: [ชื่อ branch]
📝 Uncommitted: [มี/ไม่มี + จำนวนไฟล์]
🕐 Commit ล่าสุด: [message + เวลา]
─────────────────────────────────
แนะนำ next action: [หนึ่งประโยค]
