---
name: refactor
description: Refactor code โดยไม่เปลี่ยน behavior — component, store, optimization
tools:
  - Read
  - Edit
  - Grep
  - Bash
---

Refactor: $ARGUMENTS

**กฎสำคัญ: Behavior ต้องเหมือนเดิม 100%**

**ขั้นที่ 1 — ทำความเข้าใจก่อน:**
- อ่านไฟล์ที่จะ refactor ทั้งหมด
- รัน tests ปัจจุบันให้ผ่านก่อน: `npm test -- --run`
- บันทึก test coverage ปัจจุบัน

**ขั้นที่ 2 — วางแผน:**
- อธิบาย approach ให้ฉันเห็นก่อน
- ระบุสิ่งที่จะเปลี่ยนและสิ่งที่จะไม่เปลี่ยน
- รอ confirmation

**ขั้นที่ 3 — Refactor (ทีละขั้นเล็กๆ):**
- เปลี่ยนทีละอย่าง ไม่เปลี่ยนทุกอย่างพร้อมกัน
- รัน tests หลังเปลี่ยนแต่ละขั้น
- ถ้า tests fail ให้หยุดและรายงานทันที

**ขั้นที่ 4 — ตรวจสอบ:**
- `npm run typecheck`
- `npm run lint`
- `npm test -- --run`
- ตรวจสอบว่า behavior ไม่เปลี่ยน

### Refactor Patterns สำหรับ Pomodoro App

**Component refactor:**
- แยก logic ออกจาก UI (custom hook)
- ลด prop drilling ด้วย Zustand store
- แยก component ใหญ่เป็น component เล็กๆ

**Store refactor:**
- แยก store ที่ใหญ่เกินไปออกเป็น slice
- Replace boolean flags ด้วย discriminated union
- ย้าย derived state ออกจาก store เป็น selector

**Performance refactor:**
- เพิ่ม React.memo หรือ useMemo ที่จำเป็น
- แก้ Zustand selector ที่ subscribe มากเกินไป
- Lazy load routes หรือ heavy components
