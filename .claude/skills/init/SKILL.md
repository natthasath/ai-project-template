---
name: init
description: ตั้งค่า project ใหม่จาก template — ลบ Pomodoro-specific content, สร้าง CLAUDE.md ใหม่, reset context/ ให้พร้อมใช้งาน
tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
---

เตรียม project ใหม่จาก template

Project name และ description: $ARGUMENTS

---

## Step 0 — รับข้อมูล

ถ้า $ARGUMENTS ว่างเปล่า ให้ถามผู้ใช้ก่อน:

```
ชื่อโปรเจคของคุณคืออะไร? (เช่น "Todo App", "E-commerce API")
อธิบายสั้นๆ ว่าโปรเจคนี้ทำอะไร (1-2 ประโยค)
```

Parse $ARGUMENTS เป็น:
- PROJECT_NAME = token แรก (เช่น "my-app") หรือถามถ้าไม่มี
- DESCRIPTION = ส่วนที่เหลือ (quoted string หรือว่างก็ได้)

---

## Step 1 — แสดงแผนและขอ confirm

แสดงรายการสิ่งที่จะทำ:

```
🗂️  init: <PROJECT_NAME>

  ✏️  เขียนใหม่  CLAUDE.md
  ✏️  เขียนใหม่  context/plans/PLAN.md
  ✏️  เขียนใหม่  context/tasks/TASKS.md (เฉพาะชื่อโปรเจค)
  ✏️  เขียนใหม่  context/tasks/in_progress/current_sprint.md
  🗑️  ลบ        context/plans/phase_*.md (Pomodoro phases)
  🗑️  ลบ        context/tasks/backlog/phase_0_backlog.md
  🔄  reset      context/memory/*.md (ล้าง content — คง frontmatter)
  🔄  reset      context/docs/requirements/*, design/*, decisions/* (9 ไฟล์)
  🔄  reset      context/tasks/backlog/feature_requests.md (ล้าง entries)

  ✅  ไม่แตะ    .claude/ (skills, commands, rules, config ทั้งหมด)
  ✅  ไม่แตะ    context/docs/claude-cli.md
  ✅  ไม่แตะ    context/docs/git_workflow_with_claude.md
  ✅  ไม่แตะ    context/tasks/completed/

ดำเนินการต่อไหม? (yes / no)
```

รอ confirm ก่อน — ถ้า no หยุดทันที

---

## Step 2 — Execute (หลัง confirm เท่านั้น)

### 2a. เขียน CLAUDE.md ใหม่

เขียนทับด้วย skeleton นี้ (แทน PROJECT_NAME และ DESCRIPTION จริง):

```markdown
# <PROJECT_NAME> — Claude Code Instructions

## โปรเจคนี้คืออะไร

<DESCRIPTION>

## Tech Stack

(รัน `/set-stack <preset>` เพื่อตั้งค่า — presets: react-vite | python | go | laravel | node-express)

## Architecture

(อธิบาย folder structure และ architecture pattern ที่นี่)

## Key Constraints

- (เพิ่ม constraints ที่สำคัญ)

## Development Principles

1. (เพิ่ม principles ของทีม)

## Git Workflow (Claude Code ไม่ทำอัตโนมัติ)

ดู `.claude/rules/git-conventions.md` สำหรับรายละเอียดทั้งหมด

## Skills ที่ใช้บ่อย

| Skill | ใช้เมื่อ |
|---|---|
| `/checkpoint <task>` | ก่อนให้ Claude ทำงานทุกครั้ง |
| `/status` | ดูภาพรวมโปรเจค |
| `/ship [task-id]` | ตรวจสอบก่อน merge |
| `/build-feature <feature>` | สร้าง feature ใหม่ |
| `/debug <bug>` | วิเคราะห์ bug |
| `/implement <task-id>` | implement task ตาม spec |
```

### 2b. เขียน context/plans/PLAN.md ใหม่

```markdown
# Master Development Plan — <PROJECT_NAME>

## Status Overview

| Phase | Name | Status | Target Date |
|---|---|---|---|
| (ใช้ `/add-phase <name> [date]` เพื่อเพิ่ม phases) | | | |

**Status Key:** 🔲 Not Started | 🔄 In Progress | ✅ Done | ⏸️ Blocked

## Phase Files

_(อัปเดตอัตโนมัติเมื่อรัน `/add-phase`)_

## Definition of Done (Global)

A phase is "Done" when ALL of the following are true:
- [ ] All tasks moved to `context/tasks/completed/`
- [ ] Tests pass
- [ ] No lint/typecheck errors
- [ ] Tested manually
```

### 2c. อัปเดต context/tasks/TASKS.md

เปลี่ยนเฉพาะบรรทัดแรก (title) จาก "Pomodoro Application" เป็น PROJECT_NAME
คง task template, priority legend, และโครงสร้างทั้งหมดไว้

ลบส่วน "**Phase 0: Project Setup** (Target: ...)" ในหัว Active Sprint — แทนด้วย:
```
**Phase:** (ยังไม่มี — รัน /add-phase ก่อน)
```

### 2d. เขียน context/tasks/in_progress/current_sprint.md ใหม่

```markdown
# Current Sprint — In Progress

**Sprint:** (ยังไม่มี — รัน `/add-phase` แล้ว `/start-task` เพื่อเริ่ม)
**Started:** —
**Target:** —

---

## Currently Active Tasks

_(ย้าย tasks จาก backlog มาที่นี่เมื่อเริ่มทำ พร้อมอัปเดต status)_

---

## Sprint Log

| Date | Task | Action | Notes |
|---|---|---|---|

---

## Blockers

ไม่มี blockers ปัจจุบัน
```

### 2e. ลบ Pomodoro-specific files

รัน:
```bash
ls context/plans/phase_*.md 2>/dev/null && rm -f context/plans/phase_*.md
rm -f context/tasks/backlog/phase_0_backlog.md
```

แสดงจำนวนไฟล์ที่ลบให้ผู้ใช้ทราบ

### 2f. Reset memory files

สำหรับแต่ละไฟล์ (`project_overview.md`, `tech_stack.md`, `architecture.md`, `user_preferences.md`, `feedback_history.md`):
- อ่านไฟล์ก่อน
- เก็บ YAML frontmatter (`---` ... `---`) ไว้ครบ
- แทน body ด้วย: `_(ยังไม่มีข้อมูล — จะอัปเดตหลังเริ่มพัฒนา)_`

อัปเดต `context/memory/MEMORY.md`:
- เปลี่ยน header เป็น `# Memory Index — <PROJECT_NAME>`
- ใน "## Active Memories" เปลี่ยนเป็น:
  ```
  _(ยังว่างเปล่า — memory จะถูกเพิ่มระหว่างพัฒนา)_
  ```
- คง "## Memory Writing Rules" ไว้ครบ

### 2g. Reset context/docs files (9 ไฟล์)

สำหรับแต่ละไฟล์:
- `context/docs/requirements/PRD.md`
- `context/docs/requirements/user_stories.md`
- `context/docs/requirements/acceptance_criteria.md`
- `context/docs/design/data_models.md`
- `context/docs/design/ui_wireframes.md`
- `context/docs/design/system_design.md`
- `context/docs/decisions/ADR-001_tech_stack.md`
- `context/docs/decisions/ADR-002_state_management.md`
- `context/docs/decisions/ADR-003_storage_strategy.md`

เขียนทับด้วย (คง filename เดิม เปลี่ยนแค่ content):

```markdown
# <ชื่อเดิมของไฟล์> — <PROJECT_NAME>

_(ยังไม่มีข้อมูล — เพิ่มเติมเมื่อเริ่มพัฒนา)_
```

### 2h. Reset feature_requests.md

ลบเฉพาะ entries ใน "## Entries" section
คง "## Template" section ไว้ แล้วเปลี่ยน Entries เป็น:

```markdown
## Entries

_(ไม่มี feature requests ในขณะนี้)_
```

### 2i. Git commit

```bash
git add .
git commit -m "chore: init project from template — <PROJECT_NAME>"
```

---

## Step 3 — รายงานผล

```
✅ Init เสร็จแล้ว — <PROJECT_NAME>

  ✓ CLAUDE.md — skeleton ใหม่ (เติม Architecture และ Constraints เอง)
  ✓ context/plans/PLAN.md — reset แล้ว (ไม่มี phases)
  ✓ context/tasks/TASKS.md — อัปเดตชื่อโปรเจค
  ✓ context/tasks/in_progress/current_sprint.md — reset
  ✓ context/plans/phase_*.md — ลบ <X> ไฟล์
  ✓ context/tasks/backlog/phase_0_backlog.md — ลบแล้ว
  ✓ context/memory/*.md — ล้าง content (5 ไฟล์)
  ✓ context/docs/ — reset (9 ไฟล์)
  ✓ context/tasks/backlog/feature_requests.md — ล้าง entries
  ✓ git commit: chore: init project from template — <PROJECT_NAME>
```

---

## Step 4 — Next steps

```
─────────────────────────────────────────────────────────────
ถัดไป → ตั้งค่าโปรเจค (ทำตามลำดับ):

  1. /set-stack <preset>          ตั้ง tech stack
                                  presets: react-vite | python | go | laravel | node-express

  2. แก้ CLAUDE.md                เติม Architecture + Constraints + Principles

  3. /add-phase <name> [date]     เพิ่ม Phase แรก

  4. /add-task <description>      เพิ่ม Tasks แรก

  (อนาคต) /sync-template         sync เมื่อ template repo มี update
─────────────────────────────────────────────────────────────
```
