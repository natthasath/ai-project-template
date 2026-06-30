# Skills — คู่มือการใช้งาน

## Skills คืออะไร

ไฟล์ใน `skills/<name>/SKILL.md` คือ prompt template ที่เรียกใช้ได้ด้วย `/<name>` ใน Claude Code chat

```
/checkpoint phase-0-setup
/build-feature timer core
/debug timer drift after 30 minutes
```

**ต่างจาก `commands/`** ตรงที่ skills ใช้ **folder** ไม่ใช่ไฟล์เดียว — จึง bundle supporting files เข้าไปได้ (เช่น templates, schemas, examples) และสามารถ override commands ที่ชื่อเดียวกันได้

---

## Format ของ SKILL.md

```yaml
---
name: skill-name          ← ชื่อที่ใช้เรียก (/<name>)
description: อธิบายสั้นๆ   ← Claude ใช้ตัดสินใจว่าจะ invoke skill นี้ไหม
tools:                    ← tools ที่ skill นี้ใช้ได้
  - Read
  - Bash
---

Prompt content...
ใช้ $ARGUMENTS สำหรับ input จากผู้ใช้: `/skill-name <input>`
```

---

## Skills ที่มีในโปรเจคนี้

| Skill | คำสั่ง | ใช้เมื่อ | Tools |
|---|---|---|---|
| `checkpoint` | `/checkpoint <task>` | ก่อนให้ Claude ทำงานทุกครั้ง | Bash |
| `status` | `/status` | ดูภาพรวมโปรเจค | Read, Bash |
| `build-feature` | `/build-feature <feature>` | สร้าง feature ใหม่ | Read, Write, Edit, Bash, Glob, Grep |
| `ship` | `/ship [task-id]` | ตรวจสอบก่อน merge | Read, Bash |
| `debug` | `/debug <bug>` | วิเคราะห์และแก้ bug | Read, Grep, Bash, Edit |
| `code-review` | `/code-review [file]` | ตรวจสอบ code quality | Read, Grep, Bash |
| `refactor` | `/refactor <target>` | Refactor โดยไม่เปลี่ยน behavior | Read, Edit, Grep, Bash |
| `merge` | `/merge` | merge feature branch กลับ main + ลบ branch | Bash |
| `open-pr` | `/open-pr` | เปิด Pull Request จาก feature branch ไปยัง main | Bash |
| `check-pr` | `/check-pr [pr-number]` | ตรวจ CI checks, review status, merge conflicts | Bash |
| `sync-template` | `/sync-template [url]` | ดึง .claude/ เวอร์ชันล่าสุดจาก template repo | Bash, Read |
| `init` | `/init <name> "desc"` | ตั้งค่า project ใหม่จาก template — ลบ Pomodoro content, reset context/ | Read, Write, Edit, Bash, Glob |

---

## รายละเอียดแต่ละ Skill

### `checkpoint` — รันก่อนเริ่มงานทุกครั้ง

สร้าง git safety commit เพื่อให้ย้อนกลับได้ถ้า Claude ทำพัง

```bash
/checkpoint implement-timer-core
# → git add . && git commit -m "chore: checkpoint before implement-timer-core"
# → แสดง commit hash + คำสั่ง reset ฉุกเฉิน
```

---

### `status` — ภาพรวมโปรเจคในครั้งเดียว

อ่าน `context/plans/PLAN.md`, `context/tasks/in_progress/current_sprint.md`, และ git status แล้วสรุปในรูปแบบ:

```
📍 Phase ปัจจุบัน: [ชื่อ] ([X/Y tasks เสร็จ])
🔄 กำลังทำ: [ชื่อ tasks]
📋 รอทำต่อ: [top 3 tasks]
🌿 Branch: [ชื่อ]
📝 Uncommitted: [จำนวนไฟล์]
```

---

### `build-feature` — สร้าง feature ใหม่

Workflow มาตรฐาน 4 ขั้น:
1. ตรวจสอบ context (sprint, phase, code ที่มีอยู่)
2. เสนอ approach + รอ confirmation ก่อนเขียน code
3. Implement ตาม FSD architecture
4. ตรวจสอบ (typecheck, lint, tests)

```bash
/build-feature timer core
/build-feature task list with drag-and-drop
```

---

### `ship` — Pre-merge checklist

รัน 4 ขั้นอัตโนมัติ:
1. **Technical** — typecheck, lint, tests
2. **Code review** — เทียบกับ `.claude/rules/`
3. **Task tracking** — เช็ค acceptance criteria
4. **Definition of Done** — สรุป READY / NOT READY

```bash
/ship              # ตรวจสอบ branch ปัจจุบัน
/ship TSK-0-003    # ตรวจสอบพร้อม acceptance criteria ของ task นั้น
```

---

### `debug` — วิเคราะห์ bug

Root cause analysis 5 ขั้น: reproduce → gather evidence → root cause → fix → document

มี timer-specific section สำหรับ bug พวก:
- Timer drift (ใช้ `performance.now()` แทน `Date.now()`)
- `setInterval` ที่ไม่ล้าง cleanup
- Tick mechanism ใน `src/entities/timer/`

```bash
/debug timer slows down after tab switch
/debug task status not updating in UI
```

---

### `code-review` — ตรวจสอบ code

ตรวจ 5 มิติ: Correctness, Security, Performance, Accessibility, Code Style

```bash
/code-review                          # ตรวจ diff ของ branch ปัจจุบัน
/code-review src/features/timer/      # ตรวจเฉพาะ folder
```

สรุปเป็น ✅ ผ่าน / ⚠️ แนะนำ / ❌ Blocking

---

### `sync-template` — ดึง .claude/ เวอร์ชันล่าสุดจาก template repo

ใช้เมื่อ template repo (`ai-project-template`) มี update แล้วต้องการ sync มายัง project นี้

Workflow 7 ขั้น: เตือน checkpoint → อ่าน URL → clone → diff → confirm → apply → สรุป

**Allowlist** (sync เฉพาะ dirs นี้เท่านั้น):
- `.claude/rules/`, `.claude/skills/`, `.claude/agents/`, `.claude/commands/`, `.claude/output-styles/`, `.claude/workflows/`, `.claude/themes/`

**ไม่แตะ**: `.claude/config/`, `.claude/settings.json`, `.claude/agent-memory/`

**Template ชนะเสมอ** — files ที่ต่างกันจะถูกเขียนทับ, files ที่ template ลบก็จะถูกลบด้วย

```bash
/sync-template                                              # ใช้ URL จาก .claude/config/template.md
/sync-template https://github.com/your-fork/template.git   # override URL ชั่วคราว
```

URL ที่ใช้เป็น default เก็บไว้ใน `.claude/config/template.md` — แก้ตรงนั้นถ้าใช้ fork

---

### `refactor` — Refactor โดยไม่เปลี่ยน behavior

กฎเดียว: tests ต้องผ่านก่อนและหลัง refactor

รองรับ 3 pattern:
- **Component** — แยก logic ออกเป็น custom hook, ลด prop drilling
- **Store** — แยก Zustand store, เปลี่ยน boolean flags เป็น discriminated union
- **Performance** — เพิ่ม React.memo, แก้ selector, lazy load

```bash
/refactor timer-widget component
/refactor task store boolean flags
```

---

## เพิ่ม Skill ใหม่

```bash
mkdir .claude/skills/my-skill
```

สร้าง `SKILL.md` พร้อม frontmatter:

```yaml
---
name: my-skill
description: อธิบายสั้นๆ ว่า skill นี้ทำอะไร
tools:
  - Read
  - Edit
---

Prompt content...
$ARGUMENTS คือ input จากผู้ใช้
```

**เมื่อไหรควรเพิ่ม skill ใหม่:**
- Workflow ที่ทำซ้ำบ่อยกว่า 3 ครั้ง
- Task ที่มีขั้นตอนชัดเจนและ error-prone ถ้าทำมือ
- ต้องการ bundle supporting files เข้าไปด้วย (ใส่ใน folder เดียวกับ SKILL.md ได้)

**Skills vs Commands:**
- ใช้ `skills/` สำหรับ workflow ใหม่ทุกอย่าง
- `commands/` มีอยู่แล้วเพื่อ backward compatibility เท่านั้น
