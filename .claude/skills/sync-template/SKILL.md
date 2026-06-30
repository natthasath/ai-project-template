---
name: sync-template
description: ดึง .claude/ infrastructure เวอร์ชันล่าสุดจาก template repo มาอัปเดต project นี้ — rules, skills, agents
tools:
  - Bash
  - Read
---

!`cat .claude/config/template.md 2>/dev/null || echo "⚠️ ไม่พบ .claude/config/template.md — จะใช้ค่า default"`

ซิงค์ `.claude/` infrastructure ของ project นี้กับ template repo ล่าสุด

**Override URL:** $ARGUMENTS (ถ้ามี ให้ใช้แทน URL ใน config)

---

ทำตามขั้นตอนนี้ **ตามลำดับ** — อย่าข้ามขั้นตอน:

## ขั้นที่ 0 — เตือน checkpoint

แจ้งผู้ใช้ก่อนเสมอว่า:

> ⚠️ sync-template จะเขียนทับ `.claude/rules/`, `.claude/skills/`, `.claude/agents/`, `.claude/commands/`, `.claude/output-styles/`, `.claude/workflows/`, `.claude/themes/` ด้วย version จาก template repo
>
> **แนะนำ:** รัน `/checkpoint sync-template` ก่อนถ้ายังไม่ได้ทำ

รอผู้ใช้ตอบ "ok" หรือ "ดำเนินการต่อ" ก่อนทำขั้นต่อไป

## ขั้นที่ 1 — อ่าน template URL

อ่านจาก output ของ `!cat` ด้านบน:
- หาบรรทัดที่ขึ้นต้นด้วย `repo:` แล้วนำ URL ที่ตามมาใช้
- ถ้าไม่มีบรรทัด `repo:` ใช้ค่า default: `https://github.com/natthasath/ai-project-template.git`
- ถ้ามี `$ARGUMENTS` ให้ใช้แทนทุกอย่าง (override ชั่วคราว)

## ขั้นที่ 2 — Clone template ไปที่ temp

รันคำสั่งนี้ (แทน `<TEMPLATE_URL>` ด้วย URL ที่ได้จากขั้นที่ 1):

```bash
TEMP_DIR=$(mktemp -d) && git clone --depth=1 <TEMPLATE_URL> "$TEMP_DIR" 2>&1 && echo "CLONE_OK:$TEMP_DIR" || echo "CLONE_FAIL"
```

**ถ้า CLONE_FAIL:** หยุดทันที บอก error message ที่ได้ พร้อมแนะนำ:
- ตรวจสอบ URL ใน `.claude/config/template.md`
- ถ้าเป็น private repo ต้องมี SSH key หรือ token

## ขั้นที่ 3 — วิเคราะห์การเปลี่ยนแปลง

Allowlist ของ dirs ที่ sync (แค่นี้ — ไม่เพิ่ม ไม่ลด):
```
.claude/rules/
.claude/skills/
.claude/agents/
.claude/commands/
.claude/output-styles/
.claude/workflows/
.claude/themes/
```

สำหรับแต่ละ dir ใน allowlist รัน diff เพื่อหา:
- **เพิ่มใหม่** — ไฟล์ที่มีใน template แต่ไม่มีใน project
- **อัปเดต** — ไฟล์ที่มีทั้งสองฝั่งแต่เนื้อหาต่างกัน
- **จะลบ** — ไฟล์ที่มีใน project แต่ template ลบออกแล้ว

ตัวอย่าง command สำหรับ diff (ทำซ้ำสำหรับแต่ละ dir):
```bash
# เพิ่มใหม่
diff -rq "$TEMP_DIR/.claude/rules/" ".claude/rules/" 2>/dev/null | grep "^Only in $TEMP_DIR" | sed 's|Only in .*/: ||'
# จะลบ
diff -rq "$TEMP_DIR/.claude/rules/" ".claude/rules/" 2>/dev/null | grep "^Only in .claude/rules" | sed 's|Only in .*/: ||'
# อัปเดต
diff -rq "$TEMP_DIR/.claude/rules/" ".claude/rules/" 2>/dev/null | grep "^Files .* differ"
```

## ขั้นที่ 4 — แสดง summary และขอ confirmation

แสดงในรูปแบบนี้:

```
📊 สรุปการเปลี่ยนแปลง (template vs project นี้)

📥 เพิ่มใหม่ (N ไฟล์):
   .claude/rules/new-rule.md
   .claude/agents/new-agent.md

📝 อัปเดต (N ไฟล์):
   .claude/skills/status/SKILL.md
   .claude/rules/coding-standards.md

🗑️  จะลบ (N ไฟล์):
   .claude/agents/old-agent.md

รวม: N ไฟล์ที่จะเปลี่ยน
```

**ถ้าไม่มีการเปลี่ยนแปลงเลย:** บอก "✅ ทุกอย่าง up-to-date แล้ว" ลบ temp dir แล้วหยุด

**ถ้ามีการเปลี่ยนแปลง:** ถามผู้ใช้ว่า "ดำเนินการ sync ต่อไหม? (y/n)" และรอคำตอบ

## ขั้นที่ 5 — Apply changes

สำหรับแต่ละ dir ใน allowlist ที่มีการเปลี่ยนแปลง ให้ mirror จาก template (template ชนะเสมอ):

```bash
# ตัวอย่างสำหรับ rules/ — ทำซ้ำสำหรับทุก dir ใน allowlist ที่มีใน template
rm -rf ".claude/rules/"
cp -r "$TEMP_DIR/.claude/rules/" ".claude/rules/"
```

**สำคัญ:** ถ้า dir นั้นไม่มีใน template (เช่น `themes/` ที่ยังไม่ได้สร้าง) ให้ข้ามไป อย่า rm dir ที่มีอยู่

## ขั้นที่ 6 — ล้าง temp

```bash
rm -rf "$TEMP_DIR"
```

## ขั้นที่ 7 — สรุปผล

แสดง:
```
✅ sync-template เสร็จแล้ว

เพิ่ม: N ไฟล์ | อัปเดต: N ไฟล์ | ลบ: N ไฟล์

ขั้นตอนถัดไป:
  git diff .claude/    ← ตรวจสอบการเปลี่ยนแปลง
  git add .claude/ && git commit -m "chore: sync .claude/ with template"
```
