---
name: debug
description: วิเคราะห์และแก้ bug — timer drift, state issues, performance, rendering
tools:
  - Read
  - Grep
  - Bash
  - Edit
---

!`cat .claude/config/tech-stack.md 2>/dev/null`

วิเคราะห์และแก้ bug: $ARGUMENTS

**ขั้นที่ 1 — Reproduce ปัญหา:**
- อธิบายขั้นตอนที่ทำให้เกิด bug
- Expected behavior คืออะไร
- Actual behavior คืออะไร
- Error message (ถ้ามี) คืออะไร

**ขั้นที่ 2 — Gather evidence (รัน tools):**
- ค้นหา error message ใน codebase ด้วย Grep
- อ่านไฟล์ที่เกี่ยวข้อง
- ดู git log เพื่อหาว่า bug เกิดขึ้นตั้งแต่ commit ไหน: `git log --oneline -20`

**ขั้นที่ 3 — Root cause analysis:**
- ระบุ root cause (ไม่ใช่แค่ symptom)
- อธิบายว่า bug เกิดขึ้นได้อย่างไร
- รายงานให้ฉันเห็นก่อนแก้

**ขั้นที่ 4 — Fix:**
- แก้เฉพาะ root cause ไม่แก้ครอบคลุมเกินจำเป็น
- เพิ่ม test ที่ reproduce bug ก่อน fix (ควร fail ก่อน แล้วผ่านหลัง fix)
- รัน **test** command (จาก tech-stack.md ด้านบน) หลังแก้

**ขั้นที่ 5 — Document:**
- อธิบายว่าแก้อะไรและทำไม (สำหรับ commit message)

### Timer-specific debugging
ถ้า bug เกี่ยวกับ timer drift:
- ตรวจสอบว่า interval ล้าง cleanup ใน useEffect หรือไม่
- ตรวจสอบ setInterval drift (ใช้ `performance.now()` แทน Date.now())
- ดู `src/entities/timer/` สำหรับ tick mechanism
