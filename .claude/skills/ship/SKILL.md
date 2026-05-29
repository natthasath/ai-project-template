---
name: ship
description: ตรวจสอบ pre-merge checklist ก่อน merge branch — lint, types, tests, acceptance criteria
tools:
  - Read
  - Bash
---

รัน pre-merge ship checklist สำหรับ branch ปัจจุบัน

Task ID (ถ้ามี): $ARGUMENTS

**Step 1 — Technical checks (รันคำสั่งเหล่านี้):**
- `npm run typecheck` (tsc --noEmit)
- `npm run lint`
- `npm test -- --run`
รายงาน: PASS/FAIL ต่อแต่ละอัน

**Step 2 — Code review:**
- รัน `git diff main...HEAD` เพื่อดูการเปลี่ยนแปลงทั้งหมด
- ตรวจสอบเทียบกับ `.claude/rules/` (coding-standards, security, performance)
- รายงาน: มี blocking issues ไหม

**Step 3 — Task tracking:**
- เช็ค `context/tasks/in_progress/current_sprint.md`
- task ของ branch นี้ถูก mark complete แล้วหรือยัง
- ถ้าระบุ task ID ใน $ARGUMENTS ให้เช็ค acceptance criteria ด้วย

**Step 4 — Definition of Done:**
- [ ] TypeScript errors: ไม่มี
- [ ] ESLint: zero warnings
- [ ] Tests: ผ่าน
- [ ] Acceptance criteria: verified

**สรุปผล:**
✅ READY TO MERGE — ให้ git commands สำหรับ merge
❌ NOT READY — list สิ่งที่ต้องแก้ก่อน
