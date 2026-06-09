---
name: push
description: Push branch ปัจจุบันขึ้น remote — commit ของที่ค้างอยู่ก่อน (ถ้ามี) แล้ว git push
tools:
  - Bash
---

Push branch ปัจจุบันขึ้น remote

Commit message (ถ้ามี): $ARGUMENTS

1. รัน `git status --short` และ `git branch --show-current` พร้อมกัน

2. ถ้ามีไฟล์ที่ยังไม่ได้ commit (มี output จาก git status):
   - รัน `git diff --stat` เพื่อดูสิ่งที่เปลี่ยน
   - ถ้ามี $ARGUMENTS — ใช้เป็น commit message เลย
   - ถ้าไม่มี $ARGUMENTS — draft commit message จาก git diff ตาม convention `<type>(<scope>): <summary>` แล้วแสดงให้ confirm ก่อน
   - หลัง confirm: รัน `git add -A && git commit -m "<message>"`

3. รัน `git push origin <current-branch>`

4. รายงานผล:
   - branch ที่ push
   - commit range (เช่น `abc1234..def5678`)
   - URL remote ที่ push ไป
