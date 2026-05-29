---
name: checkpoint
description: สร้าง git safety commit ก่อนให้ Claude ทำงาน ป้องกัน code หาย
tools:
  - Bash
---

สร้าง checkpoint commit ที่ปลอดภัยก่อนเริ่มงาน: $ARGUMENTS

ทำตามขั้นตอนนี้:

1. รัน `git status` เพื่อดูไฟล์ที่เปลี่ยนแปลง
2. รัน `git add .` เพื่อ stage ทุกอย่าง
3. รัน `git commit -m "chore: checkpoint before $ARGUMENTS"`
4. แจ้งผลว่า commit hash คืออะไร พร้อมบอกว่า "ถ้าทุกอย่างพัง ย้อนกลับด้วย: git reset --hard HEAD"

ถ้าไม่มีไฟล์ที่เปลี่ยนแปลง ให้บอกว่า "ไม่มีอะไรต้อง commit — ปลอดภัยที่จะเริ่มงานได้เลย"
