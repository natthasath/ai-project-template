---
name: today
description: สรุปงานที่ทำวันนี้ — commits, tasks ที่เสร็จ, และสิ่งที่ค้างอยู่
tools:
  - Read
  - Bash
---

สรุปงานที่ทำวันนี้

1. รัน `git log --oneline --since="midnight" --author="$(git config user.name)"` เพื่อดู commits วันนี้

2. อ่าน `context/tasks/in_progress/current_sprint.md` — มีงานที่ยังค้างอยู่ไหม

3. อ่าน `context/tasks/completed/archive.md` — กรอง entries ที่มี `**Completed:** <วันนี้>` เพื่อดู tasks ที่เสร็จวันนี้

4. สรุปใน 3-5 bullet points:
   - ✅ ทำเสร็จแล้ว: (tasks จาก archive + commits)
   - 🔄 กำลังทำ: (tasks ใน current_sprint)
   - 📋 รอทำต่อพรุ่งนี้: (tasks ที่ยังค้างใน current_sprint)
