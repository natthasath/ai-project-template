---
argument-hint: [high|medium|low|<keyword>]
---

แสดง tasks ที่จะทำต่อไปทั้งหมดในโปรเจค Pomodoro

1. อ่านไฟล์เหล่านี้พร้อมกัน:
   - `context/tasks/in_progress/current_sprint.md` → tasks ที่กำลังทำอยู่
   - `context/tasks/backlog/phase_0_backlog.md` → tasks ที่รอทำ (phase ปัจจุบัน)
   - `context/tasks/backlog/feature_requests.md` → feature requests ที่ยังไม่ได้ assign

2. ถ้ามี $ARGUMENTS ให้ filter เฉพาะ tasks ที่ตรงกับ keyword นั้น (เช่น priority หรือ keyword ใน title)

3. แสดงผลในรูปแบบนี้:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 TASK LIST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔄 IN PROGRESS
  [TSK-X-XXX] ชื่อ task — X Pomodoros

📋 BACKLOG — High Priority
  [TSK-X-XXX] ชื่อ task — X Pomodoros

📋 BACKLOG — Medium Priority
  [TSK-X-XXX] ชื่อ task — X Pomodoros

💡 FEATURE REQUESTS (unassigned)
  [FR-XXX] ชื่อ feature — Priority: Low

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 รวม: X tasks (Y in progress, Z รอทำ)
 Next: [TSK ที่ควรทำต่อไป — High priority อันแรกใน backlog]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

กฎการแสดงผล:
- ข้าม section ที่ไม่มี tasks
- เรียง Backlog ตาม Priority: High → Medium → Low
- **ข้าม tasks ที่มี `Status: ✅ Done`** — ไม่แสดงใน list
- Feature Requests แสดงเฉพาะที่ Phase: Unassigned
- "Next" คือ High priority task แรกใน backlog ที่ยังไม่มีใครทำ
