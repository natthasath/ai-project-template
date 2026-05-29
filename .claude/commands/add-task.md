---
argument-hint: <task description>
---

เพิ่ม task ใหม่เข้า backlog: $ARGUMENTS

1. อ่าน `context/tasks/backlog/phase_0_backlog.md` เพื่อดู task ID ล่าสุด แล้ว generate ID ถัดไป (เช่น TSK-0-007)
2. เพิ่ม task ใหม่ต่อท้ายไฟล์ในรูปแบบนี้:

```
### TSK-X-XXX — $ARGUMENTS
- **Status:** 📋 Backlog
- **Priority:** Medium
- **Phase:** [ระบุ phase ที่เหมาะสมจาก context/plans/PLAN.md]
- **Added:** [วันที่วันนี้]
```

3. แจ้งว่าเพิ่มสำเร็จ พร้อม task ID ที่ได้ และบอกว่า "รัน `/start-task <id>` เมื่อพร้อมทำงาน"
