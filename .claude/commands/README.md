# Commands — คู่มือการใช้งาน

## Commands คืออะไร

ไฟล์ `.md` แต่ละอันในโฟลเดอร์นี้สร้าง slash command `/name` ที่เรียกใช้ได้จาก chat

```
/add-task เพิ่ม dark mode toggle
/start-task TSK-0-003
/done-task TSK-0-003
/today
```

---

## Commands vs Skills — ต่างกันอย่างไร

| | Commands (`commands/`) | Skills (`skills/`) |
|---|---|---|
| โครงสร้าง | ไฟล์ `.md` เดียว | โฟลเดอร์ + `SKILL.md` |
| Bundle supporting files | ❌ ไม่ได้ | ✅ ได้ (checklist, templates, scripts) |
| Invoke | `/<name>` | `/<name>` |
| Auto-invoke โดย Claude | ✅ ได้ (ถ้า description ตรง) | ✅ ได้ |
| สถานะ | Legacy — ยังรองรับ | แนะนำสำหรับงานใหม่ |

> ถ้าชื่อซ้ำกัน `skills/` override `commands/` เสมอ

---

## Format ของ Command File

```yaml
---
argument-hint: <คำอธิบาย argument>   ← แสดงใน autocomplete (optional)
---

!`shell command ที่รันก่อน`           ← inject output เข้า prompt อัตโนมัติ (optional)

Prompt content...
ใช้ $ARGUMENTS สำหรับ input จากผู้ใช้
ใช้ $0, $1, $2 สำหรับ positional arguments
```

### Shell Injection (`!``...``)

บรรทัดที่ขึ้นต้นด้วย `!`` `` ` รันคำสั่ง shell แล้ว inject output เข้า prompt ก่อนที่ Claude จะเห็น:

```markdown
!`git log --oneline --since="midnight"`

สรุปงานที่ทำวันนี้จาก git log ด้านบน
```

Claude จะเห็น output ของ git log จริงๆ ไม่ใช่แค่คำสั่ง

---

## Commands ที่มีในโปรเจคนี้

### `/add-task <description>`
**ไฟล์:** `add-task.md`

เพิ่ม task ใหม่เข้า backlog ทันที พร้อม generate task ID อัตโนมัติต่อจาก ID ล่าสุด

```
/add-task เพิ่ม dark mode toggle ใน settings
/add-task แก้ timer drift บน mobile Safari
```

---

### `/start-task <task-id>`
**ไฟล์:** `start-task.md`

เริ่มทำงาน task — ย้ายเข้า sprint, แนะนำชื่อ branch, และบอกให้ทำ checkpoint ก่อนเริ่ม

```
/start-task TSK-0-003
```

**ลำดับที่แนะนำ:**
```
/add-task <description>   → ได้ task ID
/start-task <id>          → ย้ายเข้า sprint + สร้าง branch
/checkpoint <id>          → git safety commit
```

---

### `/done-task <task-id>`
**ไฟล์:** `done-task.md`

Mark task ว่าเสร็จ — อัปเดต sprint, archive ไปยัง completed, และถามว่าจะ merge ไหม

```
/done-task TSK-0-003
```

**ลำดับที่แนะนำ:**
```
/done-task <id>   → mark เสร็จ
/ship <id>        → ตรวจสอบก่อน merge
```

---

### `/list-task [filter]`
**ไฟล์:** `list-task.md`

แสดง tasks ที่รอทำทั้งหมด จัดกลุ่มตาม status และ priority พร้อมบอก next task ที่ควรทำ

```
/list-task           # แสดงทุก tasks
/list-task high      # filter เฉพาะ High priority
/list-task timer     # filter tasks ที่มีคำว่า "timer"
```

---

### `/today`
**ไฟล์:** `today.md`

สรุปงานที่ทำวันนี้ — อ่าน git log ตั้งแต่เที่ยงคืน บวกกับ tasks ที่ยังค้างอยู่

```
/today
```

ผลลัพธ์:
```
✅ ทำเสร็จแล้ว: ...
🔄 กำลังทำ: ...
📋 รอทำต่อพรุ่งนี้: ...
```

---

## Workflow ปกติ ใช้ Commands ร่วมกัน

```
1. /add-task <description>     เพิ่ม task ใหม่เข้า backlog
2. /start-task <id>            เริ่มทำงาน + สร้าง branch
3. /checkpoint <id>            (skill) git safety commit
4. ... เขียน code ...
5. /done-task <id>             mark เสร็จ + archive
6. /ship <id>                  (skill) ตรวจก่อน merge
7. /today                      สรุปท้ายวัน
```

---

## เพิ่ม Command ใหม่

สร้างไฟล์ `.md` ใหม่ในโฟลเดอร์นี้:

```bash
# ตัวอย่าง: สร้าง /standup command
touch .claude/commands/standup.md
```

หรือถ้างานซับซ้อนและต้องการ bundle supporting files — สร้างเป็น skill แทน:

```bash
mkdir .claude/skills/standup
touch .claude/skills/standup/SKILL.md
```
