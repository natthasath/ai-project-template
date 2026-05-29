---
argument-hint: <task-id>
---

!`cat context/tasks/backlog/phase_0_backlog.md 2>/dev/null || echo "backlog not found"`

เริ่มทำงาน task: $ARGUMENTS

1. อ่าน `context/tasks/in_progress/current_sprint.md` เพื่อดูว่า task นี้อยู่ใน sprint แล้วหรือยัง
2. ถ้ายังไม่มี — เพิ่ม task นี้เข้า `context/tasks/in_progress/current_sprint.md` พร้อม status: 🔄 In Progress
3. แนะนำชื่อ git branch ที่ควรสร้าง เช่น `feature/<task-id>-<short-description>`
4. แจ้งให้รัน: `git checkout -b <branch-name>` แล้วตาม `/checkpoint <task-id>` ก่อนเริ่มเขียน code
