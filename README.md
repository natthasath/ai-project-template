# Pomodoro App — Template สำหรับพัฒนาด้วย Claude Code

Template นี้ช่วยให้คุณพัฒนา Pomodoro Application ร่วมกับ Claude Code ได้อย่างมีระบบ
โครงสร้างโฟลเดอร์ทั้งหมดอ้างอิงจาก [official Claude Code documentation](https://code.claude.com/docs/en/claude-directory)

---

## โครงสร้าง Project

```
pomodoro-app/
│
├── CLAUDE.md                    ← Claude อ่านทุก session (project overview, กฎสำคัญ)
├── .mcp.json                    ← MCP servers ที่แชร์ทั้งทีม (version control ได้)
├── .mcp.json.example            ← ตัวอย่าง MCP config สำหรับ copy มาแก้ไข
├── .worktreeinclude             ← ไฟล์ gitignored ที่ต้อง copy เข้า worktrees
├── .gitignore
│
├── .claude/                     ← Claude Code configuration (หัวใจหลัก)
│   ├── settings.json            ← permissions, hooks, env vars, model
│   ├── settings.local.json      ← personal overrides (auto-gitignored)
│   │
│   ├── rules/                   ← กฎที่ Claude ต้องปฏิบัติตาม
│   │   ├── git-conventions.md   ← branch naming, commit messages, workflow
│   │   ├── architecture.md      ← FSD layer rules, import direction, module boundaries
│   │   ├── coding-standards.md  ← TypeScript, React, Zustand patterns
│   │   ├── testing-rules.md     ← Vitest, Playwright, mocking policy
│   │   ├── security-rules.md    ← input validation, XSS, CSP
│   │   ├── ui-ux-rules.md       ← design tokens, keyboard shortcuts, a11y
│   │   ├── performance-rules.md ← bundle budget, rendering, IndexedDB
│   │   ├── error-handling.md    ← ErrorBoundary, async errors, user-facing messages
│   │   ├── dependency-rules.md  ← checklist ก่อนเพิ่ม dependency, approved/rejected list
│   │   └── i18n.md              ← ห้าม hardcode text, locale constants, Thai formatting
│   │
│   ├── skills/                  ← Reusable prompt templates (เรียกด้วย /<skill-name>)
│   │   ├── checkpoint/          ← /checkpoint — git safety commit
│   │   ├── status/              ← /status — ดูภาพรวมโปรเจค
│   │   ├── ship/                ← /ship — pre-merge checklist
│   │   ├── build-feature/       ← /build-feature — สร้าง feature ใหม่
│   │   ├── debug/               ← /debug — วิเคราะห์ bug
│   │   ├── code-review/         ← /code-review — ตรวจสอบ code quality
│   │   ├── refactor/            ← /refactor — refactor โดยไม่เปลี่ยน behavior
│   │   ├── implement/           ← /implement — implement task ตาม AC
│   │   ├── push/                ← /push — commit + push branch ปัจจุบัน
│   │   ├── today/               ← /today — สรุปงานที่ทำวันนี้
│   │   └── update-cli-docs/     ← /update-cli-docs — sync เอกสาร Claude CLI
│   │
│   ├── commands/                ← Single-file commands (รองรับแต่แนะนำให้ใช้ skills/)
│   │   ├── add-task.md          ← /add-task <desc> — เพิ่ม task ใหม่เข้า backlog
│   │   ├── list-task.md         ← /list-task — แสดง tasks ทั้งหมดที่รอทำ
│   │   ├── start-task.md        ← /start-task <id> — เริ่มทำงาน task
│   │   ├── done-task.md         ← /done-task <id> — mark task เสร็จ
│   │   ├── set-stack.md         ← /set-stack — ตั้งค่า tech stack ของโปรเจค
│   │   └── set-style.md         ← /set-style — เปลี่ยน output style ของ Claude
│   │
│   ├── agents/                  ← Subagent definitions (ปิดเป็น default)
│   │   ├── feature-builder.md   ← implement features ที่ซับซ้อน
│   │   ├── code-reviewer.md     ← second opinion บน code
│   │   ├── qa-tester.md         ← เขียน tests + verify acceptance criteria
│   │   ├── architect.md         ← ออกแบบ implementation approach
│   │   ├── explorer.md          ← สำรวจ codebase หา files, patterns, dependencies
│   │   ├── documenter.md        ← เขียน JSDoc, ADR, อัปเดต docs
│   │   ├── security-auditor.md  ← ตรวจ OWASP Top 10
│   │   ├── performance-auditor.md ← ตรวจ bundle size, rendering, IndexedDB
│   │   ├── accessibility-auditor.md ← ตรวจ WCAG 2.1 AA compliance
│   │   ├── seo-auditor.md       ← ตรวจ SEO สำหรับ React SPA
│   │   ├── db-migrator.md       ← ออกแบบ IndexedDB schema migration
│   │   └── changelog-writer.md  ← อ่าน git log แล้วสรุปเป็น changelog
│   │
│   ├── agent-memory/            ← Persistent memory สำหรับ subagents
│   │   └── README.md
│   │
│   ├── config/                  ← Project configuration files
│   │   └── tech-stack.md        ← tech stack ที่เลือกใช้
│   │
│   ├── themes/                  ← Claude Code UI themes
│   │   └── README.md
│   │
│   ├── workflows/               ← Dynamic workflow scripts (.js) สร้างโดย Claude
│   │   └── README.md
│   │
│   └── output-styles/           ← ปรับรูปแบบการตอบกลับของ Claude
│       ├── concise-thai.md      ← ตอบสั้น กระชับ ภาษาไทย
│       └── concise-eng.md       ← ตอบสั้น กระชับ ภาษาอังกฤษ
│
└── context/                     ← Project management (แยกจาก source code)
    │
    ├── plans/                   ← แผนพัฒนาทั้งหมด
    │   ├── PLAN.md              ← master plan: 9 phases + status
    │   ├── phase_0_setup.md
    │   ├── phase_1_timer.md
    │   └── ...
    │
    ├── tasks/                   ← Task tracking
    │   ├── TASKS.md             ← task board overview
    │   ├── backlog/             ← งานที่รอทำ
    │   ├── in_progress/         ← sprint ปัจจุบัน
    │   └── completed/           ← งานที่เสร็จแล้ว
    │
    ├── docs/                    ← เอกสารโปรเจค
    │   ├── requirements/        ← PRD, user stories, acceptance criteria
    │   ├── design/              ← system design, data models, wireframes
    │   ├── decisions/           ← Architecture Decision Records (ADRs)
    │   ├── claude-cli.md        ← เอกสาร Claude CLI อัปเดตจาก official docs
    │   └── git_workflow_with_claude.md ← คู่มือ git workflow กับ Claude Code
    │
    └── memory/                  ← AI context สำหรับ sessions ถัดไป
        ├── MEMORY.md            ← index
        ├── project_overview.md
        ├── tech_stack.md
        ├── architecture.md
        ├── user_preferences.md
        └── feedback_history.md
```

---

## ไฟล์ใน `.claude/` แต่ละอย่างทำอะไร

### `CLAUDE.md` (root)
ไฟล์แรกที่ Claude อ่านทุก session — เก็บ project overview, tech stack, กฎสำคัญที่สุด, และ git workflow
**ต้องกระชับ** — ไม่เกิน 200 บรรทัด เพราะโหลดเข้า context ทุกครั้ง

### `.claude/settings.json`
กำหนดการทำงานของ Claude Code:
- **`permissions`** — อนุญาต/ห้ามคำสั่ง Bash (เช่น ห้าม `git push --force`)
- **`hooks`** — คำสั่งที่รันอัตโนมัติก่อน/หลัง tool use (เช่น reminder หลังแก้ไขไฟล์)
- **`env`** — environment variables (เช่น `VITE_DEFAULT_WORK_DURATION=25`)
- **`model`** — Claude model ที่ใช้

```json
{
  "permissions": {
    "allow": ["Bash(npm:*)", "Bash(git status)"],
    "deny": ["Bash(git push --force)"]
  },
  "hooks": {
    "PostToolUse": [{ "matcher": "Edit|Write", "hooks": [{ "command": "echo reminder" }] }]
  }
}
```

> **หมายเหตุ:** `settings.local.json` เป็น personal overrides — auto-gitignored ใช้สำหรับ settings ส่วนตัวที่ไม่ต้องการ commit

### `.claude/rules/` — กฎที่ Claude ปฏิบัติตามโดยอัตโนมัติ

ไฟล์ `.md` แต่ละอันคือชุดกฎสำหรับบริบทนั้นๆ Claude โหลดเฉพาะ rules ที่เกี่ยวข้องกับไฟล์ที่กำลังแก้ไข

**Frontmatter ที่ใช้:**
```yaml
---
description: อธิบายว่า rule นี้ใช้สำหรับอะไร
paths:
  - src/**        ← โหลดเฉพาะเมื่อทำงานกับไฟล์ใน src/
  - tests/**
---
```

ถ้าไม่มี `paths:` — โหลดทุก session

| ไฟล์ | โหลดเมื่อ |
|---|---|
| `git-conventions.md` | ทุก session |
| `architecture.md` | แก้ไขไฟล์ใน `src/` |
| `coding-standards.md` | แก้ไขไฟล์ใน `src/` หรือ `tests/` |
| `testing-rules.md` | แก้ไขไฟล์ใน `src/` หรือ `tests/` |
| `security-rules.md` | แก้ไขไฟล์ใน `src/` |
| `ui-ux-rules.md` | แก้ไขไฟล์ใน `src/components/`, `features/`, `pages/`, `shared/ui/` |
| `performance-rules.md` | แก้ไขไฟล์ใน `src/` |
| `error-handling.md` | แก้ไขไฟล์ใน `src/` |
| `dependency-rules.md` | แก้ไขไฟล์ใน `src/` หรือ `package.json` |
| `i18n.md` | แก้ไขไฟล์ใน `src/` หรือ `public/locales/` |

### `.claude/skills/` — Prompt templates ที่เรียกใช้ได้

แต่ละ skill คือโฟลเดอร์ที่มี `SKILL.md` — เรียกใช้ด้วย `/<skill-name>` ใน chat

**Format ของ SKILL.md:**
```yaml
---
name: checkpoint
description: สร้าง git safety commit ก่อน Claude ทำงาน
tools:
  - Bash
---

Prompt content ที่ส่งให้ Claude...
ใช้ $ARGUMENTS สำหรับ input จากผู้ใช้
```

**Skills ที่มีใน template นี้:**

| Skill | คำสั่ง | ใช้เมื่อ |
|---|---|---|
| checkpoint | `/checkpoint <task>` | ก่อนให้ Claude ทำงานทุกครั้ง |
| status | `/status` | ต้องการดูภาพรวมโปรเจค |
| ship | `/ship [task-id]` | ก่อน merge branch |
| build-feature | `/build-feature <feature>` | สร้าง feature ใหม่ |
| debug | `/debug <bug>` | วิเคราะห์หาสาเหตุ bug |
| code-review | `/code-review [file]` | ตรวจสอบ code quality |
| refactor | `/refactor <target>` | refactor โดยไม่เปลี่ยน behavior |
| implement | `/implement <task-id>` | implement task ตาม acceptance criteria |
| push | `/push` | commit ของที่ค้างแล้ว push ขึ้น remote |
| today | `/today` | สรุปงานที่ทำวันนี้ |
| update-cli-docs | `/update-cli-docs` | sync เอกสาร Claude CLI จาก official docs |

### `.claude/commands/` — Single-file commands (legacy แต่ยังรองรับ)

แต่ละ `.md` file สร้าง command `/name` ได้เหมือน skills — แต่ไม่มี folder สำหรับ bundle supporting files

**Format:**
```yaml
---
argument-hint: <task-id>
---

!`git log --oneline -5`   ← รัน shell แล้ว inject output เข้า prompt อัตโนมัติ

Prompt content...
ใช้ $ARGUMENTS สำหรับ input จากผู้ใช้
```

**Commands ที่มีใน template นี้:**

| Command | คำสั่ง | ใช้เมื่อ |
|---|---|---|
| add-task | `/add-task <description>` | เพิ่ม task ใหม่เข้า backlog พร้อม ID อัตโนมัติ |
| list-task | `/list-task` | แสดง tasks ที่รอทำทั้งหมด |
| start-task | `/start-task <task-id>` | เริ่มทำงาน task ใหม่ |
| done-task | `/done-task <task-id>` | mark task ว่าเสร็จแล้ว |
| set-stack | `/set-stack` | ตั้งค่า tech stack สำหรับโปรเจค |
| set-style | `/set-style` | เปลี่ยน output style ของ Claude |

> **หมายเหตุ:** `commands/` และ `skills/` ทำงานเหมือนกัน — ถ้าชื่อซ้ำกัน `skills/` จะ override
> สำหรับ command ใหม่ที่ซับซ้อน แนะนำใช้ `skills/` แทน เพราะ bundle supporting files ได้

### `.claude/agents/` — Subagent definitions

แต่ละ `.md` file นิยาม subagent หนึ่งตัว Claude สามารถ spawn agents เหล่านี้เพื่อทำงานแบบ parallel หรือ specialized

**Format:**
```yaml
---
name: FeatureBuilder
description: ใช้เมื่อต้องการ parallel implementation
tools: [Read, Write, Edit, Bash]
memory: false
---

System prompt ของ agent นี้...
```

**Agents ที่มีใน template นี้:**

| Agent | ใช้เมื่อ |
|---|---|
| `feature-builder` | implement features ที่ซับซ้อนแบบ parallel |
| `code-reviewer` | second opinion บน implementation |
| `qa-tester` | เขียน tests + verify acceptance criteria |
| `architect` | ออกแบบ approach และ trade-offs ก่อน implement |
| `explorer` | สำรวจ codebase หา files, patterns, dependencies |
| `documenter` | เขียน JSDoc, ADR, อัปเดต docs |
| `security-auditor` | ตรวจ OWASP Top 10 |
| `performance-auditor` | ตรวจ bundle size, rendering, IndexedDB |
| `accessibility-auditor` | ตรวจ WCAG 2.1 AA compliance |
| `seo-auditor` | ตรวจ SEO สำหรับ React SPA |
| `db-migrator` | ออกแบบ IndexedDB schema migration |
| `changelog-writer` | อ่าน git log แล้วสรุปเป็น changelog |

**⚠️ Default: ปิดอยู่** — ใช้ single-agent mode ปกติก่อน
เปิดใช้เมื่อ: Phase ≥ 3 + codebase > 20 ไฟล์ + งานต้องการ parallel จริงๆ

**agents/ ต้องอยู่ใน `.claude/agents/`** — ไม่ใช่ที่ root

### `.claude/agent-memory/` — Persistent memory สำหรับ subagents

เก็บ memory ที่ subagents เขียนไว้ระหว่าง session เพื่อให้ agents ครั้งถัดไปมี context

### `.claude/config/` — Project configuration

เก็บ config ที่ใช้ร่วมกันใน project เช่น `tech-stack.md` ที่ `/set-stack` เขียนให้

### `.claude/themes/` — Claude Code UI themes

เก็บ theme ที่กำหนด color scheme ใน Claude Code terminal UI

### `.claude/workflows/` — Dynamic workflow scripts

`.js` files ที่ Claude สร้างผ่าน `/workflows` command เพื่อ orchestrate งานหลายขั้นตอน
**ไม่ต้องสร้างมือ** — Claude จัดการให้

### `.claude/output-styles/` — ปรับรูปแบบการตอบกลับ

`.md` files ที่เพิ่ม section ใน system prompt เพื่อควบคุมวิธี Claude ตอบกลับ

| ไฟล์ | ใช้เมื่อ |
|---|---|
| `concise-thai.md` | ตอบสั้น กระชับ ภาษาไทย |
| `concise-eng.md` | ตอบสั้น กระชับ ภาษาอังกฤษ |

### `.mcp.json` / `.mcp.json.example` (root — ไม่ใช่ใน `.claude/`)

กำหนด MCP servers ที่แชร์ทั้งทีม เก็บใน version control ได้
แตกต่างจาก `settings.json` ตรงที่ `.mcp.json` เป็นของทีม ส่วน `settings.json` เป็น project config

`.mcp.json.example` คือตัวอย่าง config ที่ทีมสามารถ copy มาแก้ไขเป็น `.mcp.json` ได้ทันที

### `.worktreeinclude` (root)

รายการไฟล์ที่ถูก gitignore แต่ควร copy เข้า git worktrees ด้วย
(เช่น `.env.local` ที่ต้องการใน worktree แต่ไม่ต้องการ commit)

---

## โฟลเดอร์ที่ไม่ใช่ Claude Code Features

`context/` เป็นโฟลเดอร์ **project management** ที่เราสร้างเองเพื่อจัดระเบียบงาน — รวบ `plans/`, `tasks/`, `docs/`, `memory/` ไว้ที่เดียวเพื่อแยกออกจาก source code ได้ชัดเจน ไม่ใช่ส่วนหนึ่งของ Claude Code โดยตรง Claude จะอ่านไฟล์เหล่านี้เมื่อคุณสั่งหรือเมื่อ skills ต้องการ

---

## เริ่มต้นใช้งาน — ขั้นตอน

### ขั้นที่ 1: ปรับ CLAUDE.md

เปิด `CLAUDE.md` แล้วปรับ project overview และ constraints ให้ตรงกับโปรเจคของคุณ
ต้องกระชับ ไม่เกิน 200 บรรทัด

### ขั้นที่ 2: ตรวจสอบ rules

ดู `.claude/rules/` ทั้ง 6 ไฟล์ — ปรับ coding standards และ test coverage ให้ตรงกับทีม

### ขั้นที่ 3: เลือก skills ที่ต้องการ

Skills ใน `.claude/skills/` พร้อมใช้แล้ว สร้าง skill ใหม่ได้โดยสร้างโฟลเดอร์ใหม่พร้อม `SKILL.md`

### ขั้นที่ 4: กรอก Project Management

- `context/plans/PLAN.md` — roadmap และ phases
- `context/tasks/TASKS.md` — task board  
- `context/docs/requirements/PRD.md` — requirements

### ขั้นที่ 5: Init git

```bash
cd pomodoro-app
git init
git add .
git commit -m "chore: init project template"
```

### ขั้นที่ 6: เริ่มงานกับ Claude

```bash
# สร้าง branch สำหรับ task แรก
git checkout -b feature/phase-0-setup

# Checkpoint ก่อนให้ Claude ทำงาน
/checkpoint phase-0-setup

# สั่ง Claude สร้าง feature
/build-feature timer core
```

---

## Git Workflow กับ Claude Code

Claude Code ไม่ทำ git อัตโนมัติ — คุณต้องสั่งเองหรือบอก Claude ให้ทำ

```
[คุณ] สร้าง branch + checkpoint commit ก่อน
[Claude] แก้ไขไฟล์ตามที่สั่ง
[คุณ] ตรวจสอบ: git diff, npm test
[คุณ] โอเค → commit    |    พัง → git checkout . (ย้อนกลับ)
```

**คำสั่งฉุกเฉิน:**
```bash
git checkout .          # ยกเลิกการแก้ไขทั้งหมด (uncommitted)
git reset --hard HEAD   # กลับไป checkpoint commit ล่าสุด
git revert HEAD         # undo commit ล่าสุด (ปลอดภัยที่สุด)
```

รายละเอียดเพิ่มเติม: `.claude/rules/git-conventions.md`

---

## อ้างอิง

- [Claude Code Official Docs](https://code.claude.com/docs)
- [Claude Directory Structure](https://code.claude.com/docs/en/claude-directory)
