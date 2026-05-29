---
name: code-review
description: ตรวจสอบ code quality, security, performance, accessibility
tools:
  - Read
  - Grep
  - Bash
---

ตรวจสอบ code: $ARGUMENTS

ถ้าไม่ระบุไฟล์ ให้ตรวจสอบ diff ของ branch ปัจจุบัน: `git diff main...HEAD`

ตรวจสอบในแต่ละมิติ:

**🔍 Correctness**
- Logic ถูกต้องไหม
- Edge cases ที่อาจพลาด
- Null/undefined handling

**🔒 Security** (อ้างอิง `.claude/rules/security-rules.md`)
- Input validation ครบไหม
- XSS risks
- ไม่มี sensitive data ใน localStorage

**⚡ Performance** (อ้างอิง `.claude/rules/performance-rules.md`)
- Unnecessary re-renders ไหม
- Memory leaks (ล้าง cleanup ไหม)
- Bundle size impact

**♿ Accessibility** (อ้างอิง `.claude/rules/ui-ux-rules.md`)
- aria-label ครบไหม
- Keyboard accessible ไหม
- Color contrast

**📐 Code Style** (อ้างอิง `.claude/rules/coding-standards.md`)
- TypeScript types ถูกต้อง
- ไม่มี forbidden patterns
- Naming conventions ตรง

สรุปเป็น:
- ✅ ผ่าน: สิ่งที่ทำได้ดี
- ⚠️ แนะนำ: สิ่งที่ควรปรับปรุง (ไม่บังคับ)
- ❌ Blocking: สิ่งที่ต้องแก้ก่อน merge
