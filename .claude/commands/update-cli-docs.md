---
argument-hint: [changelog|commands]
---

!`node -e "const { execSync } = require('child_process'); try { const v = execSync('claude --version 2>/dev/null || claude -v 2>/dev/null').toString().trim(); console.log('Claude version: ' + v); } catch { console.log('version unavailable'); }"`

อัปเดตเอกสาร Claude CLI ใน `context/docs/claude-cli.md`

**โหมดที่รองรับ:**
- ไม่ใส่ argument → อัปเดตจากหน้า commands ทั้งหมด
- `commands` → อัปเดตเฉพาะ slash commands
- `changelog` → เพิ่ม entries ใหม่จาก release notes

**ขั้นตอน:**

1. ดึงข้อมูลล่าสุดจาก official docs:
   - Fetch `https://code.claude.com/docs/en/commands` — รายการ commands ครบทั้งหมด
   - ถ้า argument คือ `changelog` ให้ fetch `https://code.claude.com/docs/en/changelog` แทน (หรือเพิ่มเติม)

2. อ่านไฟล์ปัจจุบัน `context/docs/claude-cli.md` เพื่อเปรียบเทียบ

3. ระบุสิ่งที่เปลี่ยนแปลงก่อนแก้ไข:
   - Commands ใหม่ที่ยังไม่มีในไฟล์
   - Commands ที่ถูกลบหรือ deprecated
   - Descriptions ที่เปลี่ยนไป
   - Features ใหม่ที่เพิ่มเข้ามา

4. อัปเดต `context/docs/claude-cli.md`:
   - เพิ่ม commands ใหม่ในหมวดที่เหมาะสม
   - อัปเดต descriptions ที่เปลี่ยน
   - ~~ขีดทับ~~ หรือลบ commands ที่ deprecated แล้ว (ดูจาก max-version ใน docs)
   - รักษา format ภาษาไทยเดิมไว้

5. สรุปสิ่งที่เปลี่ยนแปลง:
   - ✅ เพิ่มใหม่: [รายการ]
   - 🔄 อัปเดต: [รายการ]
   - ❌ ลบออก/deprecated: [รายการ]
   - บอก version ที่ดึงมา (ถ้าระบุได้)
