---
argument-hint: <task-id>
---

!`cat context/tasks/backlog/phase_0_backlog.md 2>/dev/null || echo "backlog not found"`

เริ่มทำงาน task: $ARGUMENTS

1. อ่าน `context/tasks/in_progress/current_sprint.md`
   - ถ้า task `$ARGUMENTS` มี status 🔄 อยู่แล้ว — แจ้ง "Task นี้อยู่ใน sprint แล้ว" แล้วหยุด

2. อ่าน `context/tasks/backlog/phase_0_backlog.md`
   - ค้นหา section ของ task `$ARGUMENTS`
   - เปลี่ยน `**Status:** Backlog` เป็น `**Status:** 🔄 In Progress`

3. แก้ `context/tasks/in_progress/current_sprint.md`
   - เพิ่ม entry ใหม่ใน "Currently Active Tasks":
     ```
     ## $ARGUMENTS — <ชื่อ task จาก backlog>

     **Status:** 🔄 In Progress
     **Started:** YYYY-MM-DD
     **Estimate:** <จาก backlog>

     **Notes:** -

     ---
     ```
   - เพิ่ม row ใน Sprint Log: `| YYYY-MM-DD | $ARGUMENTS | Started | - |`

4. แนะนำชื่อ git branch ที่ควรสร้าง เช่น `feature/<task-id>-<short-description>`

5. แจ้งให้รัน:
   ```
   git checkout -b <branch-name>
   ```
   แล้วตาม `/checkpoint $ARGUMENTS` ก่อนเริ่มเขียน code
