---
name: build-feature
description: สร้าง feature ใหม่สำหรับ Pomodoro app — timer, tasks, notifications, analytics, settings
tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
  - Grep
---

!`cat .claude/config/tech-stack.md 2>/dev/null`

สร้าง feature ใหม่สำหรับ Pomodoro app: $ARGUMENTS

ก่อนเริ่มเขียน code ทำตามขั้นตอนนี้:

**1. ตรวจสอบ context:**
- อ่าน `context/tasks/in_progress/current_sprint.md` — task นี้อยู่ใน sprint แล้วหรือยัง
- อ่าน `context/plans/PLAN.md` — อยู่ใน phase ไหน
- ค้นหา code ที่เกี่ยวข้องใน `src/` ด้วย Grep

**2. ออกแบบก่อน implement:**
- อธิบาย approach ที่จะใช้ให้ฉันเห็นก่อน (ไม่เขียน code เลย)
- ระบุไฟล์ที่จะสร้าง/แก้ไข
- ระบุ types/interfaces ที่ต้องการ
- รอ confirmation จากฉันก่อน

**3. Implement:**
- สร้างตาม FSD architecture: `src/entities/`, `src/features/`, `src/shared/`
- ใช้ TypeScript strict mode
- เขียน test co-located กับ implementation
- ปฏิบัติตาม `.claude/rules/coding-standards.md` และ `.claude/rules/testing-rules.md`

**4. ตรวจสอบ:**
- รัน **typecheck** และ **lint** command (จาก tech-stack.md ด้านบน)
- ตรวจสอบว่า tests ผ่าน
- อัปเดต `context/tasks/in_progress/current_sprint.md` ถ้า task เสร็จแล้ว
