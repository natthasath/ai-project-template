# Pomodoro App — Claude Code Instructions

## โปรเจคนี้คืออะไร

Pomodoro timer application แบบ client-side ล้วน
ช่วยจัดการ focus sessions, ติดตาม tasks, และวิเคราะห์ productivity
ไม่มี backend — ทำงาน offline ได้ทั้งหมด

## Tech Stack

| ชั้น | เทคโนโลยี |
|---|---|
| Framework | React 19 + TypeScript |
| Build | Vite |
| State | Zustand |
| Styling | Tailwind CSS v4 |
| Storage | IndexedDB (Dexie.js) |
| Testing | Vitest + Testing Library + Playwright |

## Architecture — Feature-Sliced Design (FSD)

```
src/
├── app/        — app setup, routing, providers
├── pages/      — page-level components
├── features/   — feature modules (timer, tasks, notifications, analytics)
├── entities/   — core domain (session, task, settings)
└── shared/     — utilities, UI components, types
```

## Domain Concepts

- **Pomodoro** — work session 25 นาที
- **Short Break** — พัก 5 นาที ระหว่าง Pomodoros
- **Long Break** — พัก 15–30 นาที หลัง 4 Pomodoros
- **Cycle** — 4 Pomodoros + 3 short breaks + 1 long break
- **Task** — งานที่มอบหมายให้ 1 หรือหลาย Pomodoros
- **Session** — บันทึก Pomodoro ที่เสร็จหรือถูก interrupt

## Key Constraints

- ❌ ไม่มี backend server
- ❌ ไม่มี external API ที่เสียค่าใช้จ่าย
- ✅ Bundle < 200 KB gzipped
- ✅ First Contentful Paint < 1.5s
- ✅ Chrome 120+, Firefox 120+, Safari 17+, Edge 120+
- ✅ WCAG 2.1 AA accessibility

## Development Principles

1. **Offline-first** — ทุก feature ทำงานโดยไม่ต้องมีเน็ต
2. **Keyboard-first** — ทุก action เข้าถึงได้ผ่าน keyboard
3. **Privacy-by-default** — ไม่มี telemetry, ไม่ส่งข้อมูลออก
4. **Test as you build** — unit tests เขียนพร้อม implementation
5. **Small commits** — แต่ละ commit = 1 logical change

## Git Workflow (Claude Code ไม่ทำอัตโนมัติ)

```bash
# ก่อนให้ Claude ทำงาน — checkpoint commit ก่อนเสมอ
git checkout -b feature/ชื่อ-feature
git add . && git commit -m "chore: checkpoint before <task>"

# หลัง Claude ทำงาน — ตรวจสอบก่อน commit จริง
git diff
npm run lint && npm run typecheck && npm test

# โอเค → commit, พัง → ย้อนกลับ
git checkout .  # ยกเลิกทุกอย่างที่ Claude ทำ
```

ดู `.claude/rules/git-conventions.md` สำหรับรายละเอียดทั้งหมด

## Skills ที่ใช้บ่อย

| Skill | ใช้เมื่อ |
|---|---|
| `/checkpoint <task>` | ก่อนให้ Claude ทำงานทุกครั้ง |
| `/status` | ดูภาพรวมโปรเจค |
| `/ship [task-id]` | ตรวจสอบก่อน merge |
| `/build-feature <feature>` | สร้าง feature ใหม่ |
| `/debug <bug>` | วิเคราะห์ bug |
| `/code-review [file]` | ตรวจสอบ code quality |
| `/refactor <target>` | Refactor โดยไม่เปลี่ยน behavior |

## Subagents (ปิดเป็น default)

ใช้ single-agent mode ปกติ เปิด subagents เมื่อ:
- Phase ≥ 3 AND codebase > 20 ไฟล์
- งานต้องการ parallel tasks จริงๆ (เช่น implement + review + test พร้อมกัน)

Agents ที่พร้อมใช้: `.claude/agents/feature-builder.md`, `code-reviewer.md`, `qa-tester.md`

## Project Management Files (ไม่ใช่ Claude Code features)

เก็บรวมกันใน `context/` เพื่อแยกออกจาก source code:

| โฟลเดอร์ | หน้าที่ |
|---|---|
| `context/plans/` | Development phases, roadmap |
| `context/tasks/` | Task backlog, sprint tracking |
| `context/docs/` | Requirements, design docs, ADRs |
| `context/memory/` | AI context (project decisions, preferences) |
