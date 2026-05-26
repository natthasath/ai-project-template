---
name: user-preferences
description: Developer workflow preferences และ collaboration style สำหรับ AI-assisted development
metadata:
  type: user
---

# Developer Preferences

## Collaboration Style

- ต้องการ response สั้นกระชับ — ไม่ต้องสรุปซ้ำว่าทำอะไรไปแล้ว
- ชอบดู trade-off ก่อนตัดสินใจ ไม่ใช่แค่คำตอบเดียว
- ตอบคำถาม exploratory ด้วย 2-3 ประโยค พร้อม recommendation และ trade-off หลัก
- ไม่ implement จนกว่าจะได้รับการยืนยัน

## Code Style Preferences

- ไม่เขียน comments ที่อธิบาย "what" — ใช้ชื่อ function/variable ที่ชัดเจนแทน
- เขียน comment เฉพาะเมื่อ "why" ไม่ชัดเจน (hidden constraint, subtle invariant, workaround)
- ชอบ functional style มากกว่า class-based
- ชอบ explicit types มากกว่า inferred เมื่อ function เป็น public API
- ใช้ named exports ไม่ใช่ default exports (ยกเว้น pages)

## Testing Preferences

- เขียน test พร้อมกับ implementation ไม่ใช่หลังจากนั้น
- ไม่ mock internal modules — mock เฉพาะ external boundaries (API, storage, time)
- ชอบ integration test มากกว่า unit test สำหรับ user-facing behavior
- ต้องการ test descriptions ที่อ่านแล้วเข้าใจ behavior โดยไม่ต้องดู implementation

## Git Preferences

- Commit ทีละ logical change เดียว
- Commit message: imperative mood, ไม่เกิน 72 chars, ภาษาอังกฤษ
- Branch naming: `feature/`, `fix/`, `refactor/`, `docs/`
- ไม่ force push main/master
- ไม่ skip hooks ยกเว้นได้รับคำสั่งชัดเจน

## Language Preference

- Documentation, comments ในโค้ด: ภาษาอังกฤษ
- Communication กับ AI (prompts, memory): ภาษาไทยได้
- User-facing text ใน app: ภาษาอังกฤษ (รองรับ i18n ในอนาคต)
