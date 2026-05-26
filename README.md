# Pomodoro Application — Project Template

> Project template สำหรับพัฒนา Pomodoro timer application ด้วย Claude Code  
> ออกแบบมาเพื่อ AI-assisted development โดยใช้ prompt engineering best practices

---

## สารบัญ

1. [ภาพรวมโปรเจค](#ภาพรวมโปรเจค)
2. [โครงสร้างไฟล์และโฟลเดอร์](#โครงสร้างไฟล์และโฟลเดอร์)
3. [อธิบายแต่ละไฟล์และโฟลเดอร์](#อธิบายแต่ละไฟล์และโฟลเดอร์)
   - [ไฟล์ Root Level](#ไฟล์-root-level)
   - [โฟลเดอร์ .claude/](#โฟลเดอร์-claude)
   - [โฟลเดอร์ memory/](#โฟลเดอร์-memory)
   - [โฟลเดอร์ plans/](#โฟลเดอร์-plans)
   - [โฟลเดอร์ rules/](#โฟลเดอร์-rules)
   - [โฟลเดอร์ tasks/](#โฟลเดอร์-tasks)
   - [โฟลเดอร์ prompts/](#โฟลเดอร์-prompts)
   - [โฟลเดอร์ docs/](#โฟลเดอร์-docs)
4. [วิธีใช้งาน Template นี้](#วิธีใช้งาน-template-นี้)
5. [Workflow การพัฒนา](#workflow-การพัฒนา)
6. [Technology Stack](#technology-stack)

---

## ภาพรวมโปรเจค

Pomodoro Application เป็น web application แบบ offline-first ที่ช่วยให้ผู้ใช้งาน:
- จัดการ focus sessions ด้วยเทคนิค Pomodoro (25 นาทีทำงาน + พัก)
- ติดตาม tasks และ progress
- วิเคราะห์ productivity ผ่าน analytics dashboard
- รับ notifications เมื่อ timer หมด

โปรเจคนี้เป็น **template** — ออกแบบโครงสร้างทั้งหมดไว้แล้ว พร้อมสำหรับการเริ่มเขียนโค้ด

---

## โครงสร้างไฟล์และโฟลเดอร์

```
pomodoro-app/
│
├── CLAUDE.md                          # คำสั่งหลักสำหรับ Claude Code
├── README.md                          # ไฟล์นี้
├── .gitignore                         # ไฟล์ที่ไม่ต้อง track ใน git
│
├── .claude/                           # การตั้งค่า Claude Code
│   ├── settings.json                  # การตั้งค่าหลัก (commit ได้)
│   └── settings.local.json            # การตั้งค่าส่วนตัว (ห้าม commit)
│
├── memory/                            # ระบบ memory สำหรับ AI
│   ├── MEMORY.md                      # Index ของ memory ทั้งหมด
│   ├── project_overview.md            # เป้าหมายและขอบเขตโปรเจค
│   ├── tech_stack.md                  # การตัดสินใจเลือก technology
│   ├── architecture.md                # รูปแบบ architecture หลัก
│   ├── user_preferences.md            # preferences ของ developer
│   └── feedback_history.md            # สิ่งที่เรียนรู้จาก iterations ก่อนหน้า
│
├── plans/                             # แผนการพัฒนาแต่ละ phase
│   ├── PLAN.md                        # Master plan overview
│   ├── phase_0_setup.md               # Phase 0: Project Setup
│   ├── phase_1_timer.md               # Phase 1: Core Timer Engine
│   ├── phase_2_tasks.md               # Phase 2: Task Management
│   ├── phase_3_notifications.md       # Phase 3: Notifications & Audio
│   ├── phase_4_persistence.md         # Phase 4: Data Persistence
│   ├── phase_5_settings.md            # Phase 5: Settings
│   ├── phase_6_analytics.md           # Phase 6: Analytics Dashboard
│   ├── phase_7_polish.md              # Phase 7: Polish & Accessibility
│   └── phase_8_testing.md             # Phase 8: Testing & QA
│
├── rules/                             # กฎและมาตรฐานการพัฒนา
│   ├── RULES.md                       # Index และ top-5 non-negotiable rules
│   ├── coding_standards.md            # TypeScript, React, naming conventions
│   ├── git_conventions.md             # Branch naming, commit messages
│   ├── testing_rules.md               # สิ่งที่ต้อง test และวิธี test
│   ├── security_rules.md              # Input validation, XSS prevention
│   ├── ui_ux_rules.md                 # Design tokens, accessibility, animations
│   └── performance_rules.md           # Bundle budget, rendering, IndexedDB
│
├── tasks/                             # Task tracking board
│   ├── TASKS.md                       # Overview และ task template
│   ├── backlog/
│   │   ├── phase_0_backlog.md         # Tasks ที่รอดำเนินการ Phase 0
│   │   └── feature_requests.md        # Feature requests ที่ยังไม่ assign phase
│   ├── in_progress/
│   │   └── current_sprint.md          # Tasks ที่กำลังทำอยู่ใน sprint ปัจจุบัน
│   └── completed/
│       └── archive.md                 # Tasks ที่เสร็จแล้ว (historical record)
│
├── prompts/                           # คลังของ reusable prompts
│   ├── PROMPTS.md                     # Index และวิธีใช้ prompt library
│   ├── feature_prompts/
│   │   ├── timer_feature.md           # Prompt สำหรับ build timer features
│   │   ├── task_management.md         # Prompt สำหรับ build task features
│   │   ├── notification_system.md     # Prompt สำหรับ notifications & audio
│   │   ├── analytics_dashboard.md     # Prompt สำหรับ analytics charts
│   │   └── settings_feature.md        # Prompt สำหรับ settings functionality
│   ├── review_prompts/
│   │   ├── code_review.md             # Prompt สำหรับ review code quality
│   │   ├── security_review.md         # Prompt สำหรับ security audit
│   │   ├── performance_review.md      # Prompt สำหรับ performance audit
│   │   └── accessibility_review.md    # Prompt สำหรับ accessibility audit
│   ├── debug_prompts/
│   │   ├── bug_investigation.md       # Prompt สำหรับ root-cause analysis
│   │   ├── performance_debug.md       # Prompt สำหรับ debug ปัญหา performance
│   │   └── timer_accuracy_debug.md    # Prompt เฉพาะสำหรับ timer drift issues
│   └── refactor_prompts/
│       ├── component_refactor.md      # Prompt สำหรับ refactor components
│       ├── store_refactor.md          # Prompt สำหรับ refactor Zustand stores
│       └── optimization.md            # Prompt สำหรับ optimization pass
│
└── docs/                              # เอกสารโปรเจค
    ├── requirements/
    │   ├── PRD.md                     # Product Requirements Document
    │   ├── user_stories.md            # User stories แต่ละ feature
    │   └── acceptance_criteria.md     # Acceptance criteria แต่ละ feature
    ├── design/
    │   ├── system_design.md           # System architecture overview
    │   ├── data_models.md             # TypeScript interfaces และ DB schema
    │   └── ui_wireframes.md           # Text-based wireframes ของแต่ละหน้า
    └── decisions/
        ├── ADR-001_tech_stack.md      # ทำไมถึงเลือก tech stack นี้
        ├── ADR-002_state_management.md # ทำไมถึงใช้ Zustand แบบแยก stores
        └── ADR-003_storage_strategy.md # ทำไมถึงใช้ IndexedDB + localStorage
```

---

## อธิบายแต่ละไฟล์และโฟลเดอร์

---

### ไฟล์ Root Level

#### `CLAUDE.md`
**หน้าที่:** ไฟล์สำคัญที่สุด — เป็นคำสั่งและ context หลักที่ Claude Code อ่านก่อนเริ่มทุก session

ประกอบด้วย:
- ภาพรวมโปรเจคและ tech stack ที่ตัดสินใจแล้ว
- โครงสร้าง folder ทั้งหมด
- Core domain concepts (Pomodoro, Cycle, Session)
- Development principles และ constraints
- Index ของ memory system
- Quick reference ไปยัง prompt library

**เมื่อไหรที่อัปเดต:** เมื่อมีการเปลี่ยนแปลง tech stack, architecture หลัก, หรือ project constraints

---

#### `README.md`
**หน้าที่:** ไฟล์นี้ — เอกสารภาษาไทยที่อธิบายโครงสร้างและวิธีใช้งาน template ทั้งหมด

---

#### `.gitignore`
**หน้าที่:** กำหนดไฟล์ที่ Git ไม่ต้อง track โดยเฉพาะ:
- `node_modules/` — dependencies (ใหญ่มาก, regenerate ได้)
- `.claude/settings.local.json` — personal settings ของแต่ละคน
- `dist/` — build output
- `.env` — environment variables ที่อาจมี secrets

---

### โฟลเดอร์ `.claude/`

โฟลเดอร์นี้เก็บการตั้งค่าสำหรับ Claude Code CLI

#### `.claude/settings.json`
**หน้าที่:** การตั้งค่าหลักของ Claude Code สำหรับโปรเจคนี้

ประกอบด้วย:
- **`permissions.allow`** — คำสั่ง Bash ที่อนุญาตให้รันอัตโนมัติ (npm, git, vite ฯลฯ)
- **`permissions.deny`** — คำสั่งอันตรายที่ห้ามรัน (rm -rf, curl ฯลฯ)
- **`hooks`** — คำสั่งที่รันอัตโนมัติเมื่อเกิด events:
  - `PreToolUse` (Bash): แจ้งเตือนก่อนรันคำสั่ง
  - `PostToolUse` (Edit/Write): เตือนให้อัปเดต tasks เมื่อแก้ไขไฟล์
  - `Stop`: เตือนให้ตรวจสอบ in-progress tasks เมื่อจบ session
- **`env`** — environment variables สำหรับ development

**Commit ได้:** ใช่ — ใช้ร่วมกันทั้งทีม

#### `.claude/settings.local.json`
**หน้าที่:** การตั้งค่า override ส่วนตัวที่ไม่ควร commit

ใช้สำหรับ:
- เพิ่ม permissions เพิ่มเติมที่ใช้เฉพาะบนเครื่องตัวเอง
- ตั้ง debug environment variables
- Override model หรือ theme

**Commit ได้:** ไม่ — อยู่ใน `.gitignore` แล้ว

---

### โฟลเดอร์ `memory/`

ระบบ memory ของ AI ที่ช่วยให้ทุก session ได้รับ context ที่ถูกต้องโดยไม่ต้องอธิบายซ้ำ

#### `memory/MEMORY.md`
**หน้าที่:** Index ไฟล์ของ memory ทั้งหมด — โหลดเข้า context ทุกครั้งโดยอัตโนมัติ

ประกอบด้วย:
- Links ไปยัง memory files ทั้งหมด
- กฎในการเขียน memory (อะไรควรบันทึก, อะไรไม่ควร)

**เมื่อไหรที่อัปเดต:** ทุกครั้งที่เพิ่มหรือลบ memory file

#### `memory/project_overview.md`
**หน้าที่:** บันทึก vision, core features, success criteria, และ out-of-scope ของโปรเจค

ใช้เมื่อ: AI ต้องการตัดสินว่า feature request ใดอยู่ในขอบเขตโปรเจคหรือไม่

#### `memory/tech_stack.md`
**หน้าที่:** บันทึก technology ที่เลือกใช้ พร้อมเหตุผล และ options ที่ reject ไปแล้ว

ใช้เมื่อ: AI กำลังจะแนะนำ library ใหม่ — ตรวจสอบก่อนว่า stack ที่มีอยู่รองรับได้ไหม

#### `memory/architecture.md`
**หน้าที่:** บันทึก Feature-Sliced Design structure, Zustand store schemas, timer accuracy strategy, และ persistence layer design

ใช้เมื่อ: สร้าง feature ใหม่หรือตัดสินใจว่าโค้ดควรอยู่ layer ไหน

#### `memory/user_preferences.md`
**หน้าที่:** บันทึก preferences ของ developer เช่น coding style, git conventions, tone ของ response

ใช้เมื่อ: AI ต้องการปรับ response ให้เหมาะกับ developer แต่ละคน

#### `memory/feedback_history.md`
**หน้าที่:** บันทึก lessons learned จาก iterations ที่ผ่านมา — ทั้งสิ่งที่ได้ผลและไม่ได้ผล

ใช้เมื่อ: เริ่ม phase ใหม่ เพื่อไม่ทำผิดซ้ำ

---

### โฟลเดอร์ `plans/`

แผนการพัฒนาแบบ phase-based ที่กำหนด objectives, deliverables, และ acceptance criteria

#### `plans/PLAN.md`
**หน้าที่:** Master plan ที่แสดงภาพรวมของทุก phase พร้อม status และ target dates

ประกอบด้วย:
- ตาราง phase overview (status, target date)
- Definition of Done ที่ apply กับทุก phase
- Link ไปยัง phase detail files
- Current active phase

**เมื่อไหรที่อัปเดต:** เมื่อ phase status เปลี่ยน หรือ target date เปลี่ยน

#### `plans/phase_0_setup.md`
**หน้าที่:** รายละเอียดการ setup โปรเจค — Vite, ESLint, Tailwind, Vitest, Playwright, Git hooks, CI

#### `plans/phase_1_timer.md`
**หน้าที่:** รายละเอียดการสร้าง Timer Engine — state machine, drift correction, circular progress UI, keyboard shortcuts

#### `plans/phase_2_tasks.md`
**หน้าที่:** รายละเอียดการสร้าง Task Management — CRUD, data model, timer integration, drag-to-reorder

#### `plans/phase_3_notifications.md`
**หน้าที่:** รายละเอียดการสร้าง Notification system — Web Notifications API, Web Audio API, iOS quirks

#### `plans/phase_4_persistence.md`
**หน้าที่:** รายละเอียดการ setup Dexie.js — DB schema, repositories, data export/import, migration strategy

#### `plans/phase_5_settings.md`
**หน้าที่:** รายละเอียดการสร้าง Settings — schema, form validation, real-time preview, persistence

#### `plans/phase_6_analytics.md`
**หน้าที่:** รายละเอียดการสร้าง Analytics Dashboard — chart types, query patterns, aggregation, accessibility

#### `plans/phase_7_polish.md`
**หน้าที่:** รายละเอียด accessibility checklist, performance checklist, PWA setup, UX polish

#### `plans/phase_8_testing.md`
**หน้าที่:** รายละเอียด test coverage targets, E2E scenarios, cross-browser QA checklist

---

### โฟลเดอร์ `rules/`

กฎและมาตรฐานที่ enforce quality และ consistency ตลอดโปรเจค

#### `rules/RULES.md`
**หน้าที่:** Index ของ rules ทั้งหมด พร้อม top-5 non-negotiable rules และ enforcement mechanisms

อ่านก่อน coding session ทุกครั้ง

#### `rules/coding_standards.md`
**หน้าที่:** มาตรฐานการเขียนโค้ดสำหรับโปรเจคนี้

ครอบคลุม:
- TypeScript patterns (discriminated unions, readonly, satisfies)
- React component patterns (named exports, early returns, props typing)
- File naming conventions (kebab-case files, PascalCase exports)
- Import order (React → external → internal → relative)
- Zustand store pattern (co-located actions)
- Forbidden patterns (console.log, @ts-ignore, inline styles, magic numbers)

#### `rules/git_conventions.md`
**หน้าที่:** กฎการใช้ Git ในโปรเจค

ครอบคลุม:
- Branch naming format (`feature/`, `fix/`, `refactor/`, `docs/`, `chore/`)
- Commit message format (Conventional Commits: type, scope, summary)
- PR rules (title format, required sections, merge strategy)
- Protected branch rules (ห้าม push ตรงไป main)

#### `rules/testing_rules.md`
**หน้าที่:** กฎสำหรับการเขียน tests

ครอบคลุม:
- Test categories (unit, component, integration, E2E) และขอบเขตแต่ละ category
- Mocking policy (mock เฉพาะ external boundaries)
- Timer testing strategy (fake timers + Date.now())
- Test description format (Arrange-Act-Assert, behavior-focused naming)
- Coverage requirements แต่ละ layer

#### `rules/security_rules.md`
**หน้าที่:** กฎด้าน security ที่ต้องปฏิบัติตาม

ครอบคลุม:
- Input validation (strip HTML, enforce length limits, range checks)
- XSS prevention (ห้าม dangerouslySetInnerHTML กับ user input)
- Data import validation (schema check ก่อน write ลง IndexedDB)
- localStorage security (ห้าม store sensitive data)
- Content Security Policy header

#### `rules/ui_ux_rules.md`
**หน้าที่:** มาตรฐาน UI/UX สำหรับโปรเจค

ครอบคลุม:
- Design tokens (colors, spacing, typography)
- Keyboard shortcuts map ทั้งหมด
- Responsive breakpoints
- ARIA patterns สำหรับแต่ละ component type
- Animation rules และ prefers-reduced-motion

#### `rules/performance_rules.md`
**หน้าที่:** กฎด้าน performance

ครอบคลุม:
- Bundle size budgets (initial ≤ 150KB, total ≤ 250KB)
- Zustand selector granularity (ป้องกัน unnecessary re-renders)
- Memory management (cleanup intervals/listeners)
- Lazy loading strategy (analytics page, settings page)
- IndexedDB query optimization (indexes, limit(), avoid full scans)
- Web Vitals targets (FCP, LCP, CLS, INP)

---

### โฟลเดอร์ `tasks/`

Task tracking system แบบ lightweight สำหรับ manage งานพัฒนา

#### `tasks/TASKS.md`
**หน้าที่:** Overview ของ task board ปัจจุบัน พร้อม task template และ priority legend

ใช้เป็นจุดเริ่มต้นในการดูสถานะงานทั้งหมด

#### `tasks/backlog/phase_0_backlog.md`
**หน้าที่:** รายการ tasks ที่รอดำเนินการสำหรับ Phase 0 — แต่ละ task มี priority, estimate, description, และ acceptance criteria

#### `tasks/backlog/feature_requests.md`
**หน้าที่:** เก็บ feature requests ที่ยังไม่ได้ assign เข้า phase — มี user story และ notes สำหรับแต่ละ request

#### `tasks/in_progress/current_sprint.md`
**หน้าที่:** แสดง tasks ที่กำลังทำอยู่ใน sprint ปัจจุบัน พร้อม sprint log และ blockers

อัปเดตทุกวัน หรือทุกครั้งที่มีความคืบหน้า

#### `tasks/completed/archive.md`
**หน้าที่:** Historical record ของ tasks ที่เสร็จแล้ว พร้อม actual vs estimated Pomodoros และ lessons learned

ใช้เพื่อ calibrate future estimates

---

### โฟลเดอร์ `prompts/`

คลัง prompt templates ที่ใช้ซ้ำได้ — ช่วยให้ AI ได้รับ context ที่ครบถ้วนทุกครั้ง

#### `prompts/PROMPTS.md`
**หน้าที่:** Index ของ prompts ทั้งหมด พร้อมคำแนะนำว่าเมื่อไหรให้ใช้ prompt ไหน

**วิธีใช้:**
1. เลือก prompt ที่ตรงกับงาน
2. อ่าน "Context to Load First" section
3. กรอก `{{PLACEHOLDER}}` ด้วยข้อมูลจริง
4. Paste ใน Claude Code

#### Feature Prompts

| ไฟล์ | หน้าที่ |
|---|---|
| `feature_prompts/timer_feature.md` | Template prompt สำหรับ build/แก้ไข timer — ระบุ constraints เฉพาะของ timer (drift correction, background tab, state machine) |
| `feature_prompts/task_management.md` | Template prompt สำหรับ task CRUD — รวม security reminders สำหรับ input validation |
| `feature_prompts/notification_system.md` | Template prompt สำหรับ notifications — ระบุ platform quirks (iOS AudioContext, Firefox HTTPS) |
| `feature_prompts/analytics_dashboard.md` | Template prompt สำหรับ charts — ระบุ query patterns, memoization rules, empty states |
| `feature_prompts/settings_feature.md` | Template prompt สำหรับ settings — ระบุ validation ranges และ real-time behavior |

#### Review Prompts

| ไฟล์ | หน้าที่ |
|---|---|
| `review_prompts/code_review.md` | ขอ review code quality ครบ 8 มิติ (TypeScript, React, Zustand, Security, A11y, Tests, Performance, Clarity) |
| `review_prompts/security_review.md` | ขอ security audit — ตรวจ XSS, input validation, JSON import safety, CSP |
| `review_prompts/performance_review.md` | ขอ performance audit — bundle size, re-renders, IndexedDB efficiency |
| `review_prompts/accessibility_review.md` | ขอ accessibility audit — keyboard nav, ARIA, contrast, screen reader |

#### Debug Prompts

| ไฟล์ | หน้าที่ |
|---|---|
| `debug_prompts/bug_investigation.md` | Structured bug report template พร้อม common bug categories ของ Pomodoro apps |
| `debug_prompts/performance_debug.md` | Debug ปัญหา performance — symptoms, profiling steps, common causes |
| `debug_prompts/timer_accuracy_debug.md` | Debug timer drift/background issues เฉพาะ — มี investigation checklist |

#### Refactor Prompts

| ไฟล์ | หน้าที่ |
|---|---|
| `refactor_prompts/component_refactor.md` | Refactor component — มี pattern reference (เมื่อไหรควรแยก, เมื่อไหรควรใช้ hook) |
| `refactor_prompts/store_refactor.md` | Refactor Zustand store — แยก store, เพิ่ม selectors, แก้ cross-store communication |
| `refactor_prompts/optimization.md` | Optimization pass — ขอ top-3 opportunities พร้อม justification (ป้องกัน premature optimization) |

---

### โฟลเดอร์ `docs/`

เอกสารโปรเจคที่เป็นทางการ — requirements, design, และ architecture decisions

#### `docs/requirements/PRD.md`
**หน้าที่:** Product Requirements Document — เอกสารหลักที่กำหนดว่า app ต้องทำอะไร

ประกอบด้วย:
- Product vision
- Target users และ user characteristics
- Problem statement
- Core features (MVP) พร้อม Functional Requirements IDs (FR-XXX)
- Non-Functional Requirements (NFR-XXX)
- Out of scope

**ใช้เมื่อ:** ประเมินว่า feature request ใหม่อยู่ใน scope ไหม

#### `docs/requirements/user_stories.md`
**หน้าที่:** User stories ในรูปแบบ "As a [user], I want to [action] so that [benefit]"

จัดกลุ่มตาม epic และระบุ priority (Must Have/Should Have/Could Have) และ phase

**ใช้เมื่อ:** สร้าง task ใหม่ หรือตรวจสอบว่า implementation ตรงกับความต้องการของ user

#### `docs/requirements/acceptance_criteria.md`
**หน้าที่:** Acceptance criteria ในรูปแบบ Given-When-Then สำหรับแต่ละ feature

**ใช้เมื่อ:** ตรวจสอบว่า feature เสร็จสมบูรณ์จริงหรือไม่ก่อน mark as done

#### `docs/design/system_design.md`
**หน้าที่:** ภาพรวม system architecture — ASCII diagram ของ component layers, data flow, module dependency rules (FSD)

**ใช้เมื่อ:** ตัดสินใจว่าโค้ดใหม่ควรอยู่ layer ไหน, หรืออธิบาย architecture ให้คนใหม่

#### `docs/design/data_models.md`
**หน้าที่:** TypeScript interfaces ของทุก domain entity (TimerState, Task, Session, UserSettings) และ Dexie.js database schema

**ใช้เมื่อ:** สร้าง store ใหม่, เพิ่ม field, หรือออกแบบ query

#### `docs/design/ui_wireframes.md`
**หน้าที่:** Text-based wireframes (ASCII art) ของแต่ละหน้า — Timer, Analytics, Settings — และ component breakdowns

**ใช้เมื่อ:** สร้าง UI components ใหม่ หรืออธิบาย layout ที่ต้องการ

#### `docs/decisions/ADR-001_tech_stack.md`
**หน้าที่:** Architecture Decision Record — เหตุผลการเลือก tech stack (React, Vite, Zustand, Tailwind, Dexie)

#### `docs/decisions/ADR-002_state_management.md`
**หน้าที่:** ADR — ทำไมถึงแยก Zustand เป็น 4 stores (Timer, Task, Session, Settings) ไม่ใช่ store เดียว

#### `docs/decisions/ADR-003_storage_strategy.md`
**หน้าที่:** ADR — ทำไมถึงใช้ localStorage สำหรับ settings และ IndexedDB สำหรับ tasks/sessions

**ใช้เมื่อ:** มีคำถามว่า "ทำไมถึงทำแบบนี้?" — ADR จะตอบได้โดยไม่ต้องถาม

---

## วิธีใช้งาน Template นี้

### ขั้นตอนที่ 1: เริ่ม Session ใหม่

เมื่อเริ่ม Claude Code session ให้บอกว่า:
```
เปิด CLAUDE.md และ plans/PLAN.md ให้ฉัน แล้วบอกว่า phase ไหนที่กำลัง active อยู่
```

### ขั้นตอนที่ 2: ก่อนเขียนโค้ด

1. ตรวจสอบ `tasks/in_progress/current_sprint.md` ว่ามี task อะไรค้างอยู่
2. เลือก task จาก backlog และย้ายมาที่ `in_progress`
3. อ่าน phase plan file ที่เกี่ยวข้อง
4. อ่าน rules ที่เกี่ยวข้องกับ task นั้น

### ขั้นตอนที่ 3: เขียนโค้ด

เลือก prompt ที่เหมาะสมจาก `prompts/` แล้วกรอก placeholders:
```
ฉันต้องการ build timer feature ตาม plans/phase_1_timer.md

[วาง prompt จาก prompts/feature_prompts/timer_feature.md มาที่นี่]

Task: [อธิบาย task เฉพาะที่ต้องการทำ]
```

### ขั้นตอนที่ 4: Review ก่อน Merge

ใช้ review prompts ก่อน merge ทุกครั้ง:
```
[วาง prompt จาก prompts/review_prompts/code_review.md มาที่นี่]

Files changed: src/entities/timer/timer-store.ts
What this change does: เพิ่ม drift correction ให้ timer
```

### ขั้นตอนที่ 5: หลัง Complete Task

1. ย้าย task จาก `in_progress` ไป `completed/archive.md`
2. อัปเดต phase status ใน `plans/PLAN.md`
3. บันทึก lessons learned ใน `memory/feedback_history.md` ถ้ามี

---

## Workflow การพัฒนา

```
┌─────────────────────────────────────────────────────────────┐
│                    Development Workflow                     │
│                                                             │
│  docs/requirements/  →  plans/  →  tasks/backlog/           │
│  (define what)          (plan how)    (break down)          │
│                                            │                │
│                                            ▼                │
│                                     tasks/in_progress/      │
│                                       (pick a task)         │
│                                            │                │
│                                            ▼                │
│                              prompts/  →  src/ + tests/     │
│                              (use template)  (write code)   │
│                                            │                │
│                                            ▼                │
│                              review_prompts/ → merge        │
│                              (quality gate)                 │
│                                            │                │
│                                            ▼                │
│                              tasks/completed/ + memory/     │
│                              (close task + capture learning)│
└─────────────────────────────────────────────────────────────┘
```

---

## Technology Stack

| Layer | Technology | เหตุผล |
|---|---|---|
| Framework | React 19 + TypeScript | Component reusability, strong typing, concurrent features |
| Build Tool | Vite 6 | Fast HMR, native ESM, ไม่ต้องการ config มาก |
| State | Zustand 5 | Minimal boilerplate, granular subscriptions, devtools |
| Styling | Tailwind CSS v4 | Utility-first, native CSS cascade layers, ไม่ต้องการ PostCSS |
| Storage | Dexie.js (IndexedDB) | Offline-first, รองรับ complex queries สำหรับ analytics |
| Notifications | Web Notifications API | Native OS notifications, ไม่ต้องการ library |
| Audio | Web Audio API | สร้างเสียงใน browser, ไม่ต้องโหลดไฟล์ภายนอก |
| Testing | Vitest + Testing Library | Co-located กับ Vite, React-native testing |
| E2E | Playwright | Cross-browser, modern API |
| Linting | ESLint v9 (flat config) + Prettier | Enforce standards อัตโนมัติ |

> รายละเอียดเหตุผลเต็มๆ: `docs/decisions/ADR-001_tech_stack.md`

---

*Template นี้สร้างขึ้นเมื่อ 2026-05-26 — อัปเดต README นี้เมื่อโครงสร้างเปลี่ยนแปลง*
