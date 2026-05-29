# Agents — คู่มือการใช้งาน

## Agents คืออะไร

เมื่อคุยกับ Claude ปกติ มี **context window เดียว** — Claude จำทุกอย่างที่คุยกันไว้ในนั้น

Subagent คือการให้ Claude **spawn instance ใหม่** ที่มี context window แยกต่างหาก
ไม่มีความทรงจำจาก session หลัก แต่ได้รับ system prompt จากไฟล์ `.md` ในโฟลเดอร์นี้

```
session หลัก (คุณ + Claude)
    └── spawn → FeatureBuilder  (context window ใหม่, ไม่รู้ประวัติ session หลัก)
    └── spawn → CodeReviewer    (context window ใหม่, อิสระจากกัน)
```

---

## ใช้ตอนไหน

### ✅ ได้ประโยชน์จริงๆ

**1. งานที่ต้องการ isolation**
ให้ `CodeReviewer` ตรวจ code โดยไม่รู้ว่า implementation ทำยังไง
ได้ second opinion ที่เป็นกลาง ไม่ถูก bias จาก context ที่สะสมมาใน session หลัก

**2. งาน parallel**
Implement feature A และ feature B พร้อมกัน
Spawn `FeatureBuilder` 2 ตัวพร้อมกัน แทนที่จะทำทีละอัน

**3. Context window ใกล้เต็ม**
งานที่ต้องอ่านไฟล์จำนวนมาก เช่น refactor ทั้ง codebase
Delegate ให้ agent ทำในพื้นที่สะอาด ไม่รบกวน session หลัก

### ❌ ไม่ควรใช้ตอนไหน

- งานเล็กที่ทำใน session เดียวได้ — เพิ่ม overhead โดยไม่จำเป็น
- Phase 0–2 ของโปรเจคนี้ที่ codebase ยังเล็ก
- ถ้าใช้ **Claude Pro $17/เดือน** — subagent แต่ละตัวกินโควต้าเหมือน session ใหม่

---

## วิธี Invoke

### วิธีที่ 1 — คุณเรียกเอง (พิมพ์ @)

```
@FeatureBuilder implement timer drift correction in src/entities/timer/
@CodeReviewer review the changes in src/features/timer/
@QATester write tests for the new notification feature
```

พิมพ์ `@` แล้วเลือก agent จาก autocomplete ที่จะขึ้นมา

### วิธีที่ 2 — Claude ตัดสินใจ spawn เอง

Claude อ่าน `description:` ใน frontmatter ของแต่ละ agent
ถ้างานที่กำลังทำตรงกับ description — Claude อาจ spawn agent นั้นให้อัตโนมัติ

> ⚠️ **ปัจจุบัน: ปิด auto-spawn แล้ว**
> Agent ทั้ง 3 ตัวมี `disable-model-invocation: true` — Claude จะไม่ spawn เองโดยไม่ได้รับอนุญาต
> ต้องพิมพ์ `@AgentName` เองเท่านั้น
>
> ถ้าต้องการเปิด auto-spawn ในอนาคต ลบบรรทัด `disable-model-invocation: true` ออกจาก agent file ที่ต้องการ

---

## Format ของ Agent File

```yaml
---
name: AgentName
description: อธิบายว่า Claude ควร spawn agent นี้เมื่อไหร่ (ใช้ตัดสินใจ auto-invoke)
tools: Read, Grep, Glob, Bash    ← จำกัด tools ให้เท่าที่จำเป็น
memory: false                    ← false | project | local | user
---

System prompt ของ agent นี้...
```

### `tools:` — จำกัดสิ่งที่ agent ทำได้

| Agent | Tools ที่เหมาะ | เหตุผล |
|---|---|---|
| CodeReviewer | Read, Grep, Glob | ตรวจได้อย่างเดียว ห้ามแก้ไข |
| FeatureBuilder | Read, Write, Edit, Bash | ต้องเขียน code ได้ |
| QATester | Read, Write, Edit, Bash | ต้องเขียน test ได้ |

---

## `memory:` — ความทรงจำระหว่าง Sessions

| ค่า | เก็บที่ | เหมาะกับ |
|---|---|---|
| `memory: false` | ไม่จำอะไร | default — เหมาะกับ early development |
| `memory: project` | `.claude/agent-memory/<name>/` | ทีมใช้ร่วมกัน, commit ได้ |
| `memory: local` | `.claude/agent-memory-local/<name>/` | ส่วนตัว, ไม่ commit |
| `memory: user` | `~/.claude/agent-memory/<name>/` | ข้ามโปรเจค |

โฟลเดอร์ `agent-memory/` **ถูกสร้างอัตโนมัติ** โดย Claude — ไม่ต้องสร้างมือ

---

## Agents ที่มีในโปรเจคนี้

**Analysis (read-only)**

| ไฟล์ | ชื่อ | ใช้เมื่อ |
|---|---|---|
| `explorer.md` | Explorer | สำรวจ codebase ก่อน implement — หาไฟล์, patterns, dependencies |
| `architect.md` | Architect | ออกแบบ approach, file structure, interfaces ก่อนลงมือเขียน code |
| `performance-auditor.md` | PerformanceAuditor | ตรวจ bundle size, re-renders, IndexedDB queries |

**Implementation**

| ไฟล์ | ชื่อ | ใช้เมื่อ |
|---|---|---|
| `feature-builder.md` | FeatureBuilder | implement feature ใหม่ที่ซับซ้อน หรืองาน parallel |
| `qa-tester.md` | QATester | เขียน tests หรือ verify acceptance criteria เร็ว |

**Specialized — Pomodoro**

| ไฟล์ | ชื่อ | ใช้เมื่อ |
|---|---|---|
| `accessibility-auditor.md` | AccessibilityAuditor | ตรวจ WCAG 2.1 AA — aria, keyboard, contrast, motion |
| `db-migrator.md` | DBMigrator | วางแผน IndexedDB schema migration ก่อน Dexie version bump |
| `security-auditor.md` | SecurityAuditor | ตรวจ OWASP Top 10 + ASVS Level 1-2 — XSS, CSP, dependencies, storage |
| `seo-auditor.md` | SEOAuditor | ตรวจ meta tags, Core Web Vitals, PWA, structured data, semantic HTML |

**Documentation**

| ไฟล์ | ชื่อ | ใช้เมื่อ |
|---|---|---|
| `documenter.md` | Documenter | เขียน JSDoc, ADR, อัปเดต docs หลัง implement เสร็จ |
| `changelog-writer.md` | ChangelogWriter | อ่าน git log แล้วสรุปเป็น changelog ที่อ่านง่าย |

**Review**

| ไฟล์ | ชื่อ | ใช้เมื่อ |
|---|---|---|
| `code-reviewer.md` | CodeReviewer | ต้องการ second opinion อิสระบน code |

---

## เงื่อนไขก่อนเปิดใช้งาน

**DEFAULT: ปิดอยู่** — ใช้ single-agent mode จนกว่าจะครบเงื่อนไขทั้ง 3:

- [ ] Phase ≥ 3
- [ ] Codebase > 20 ไฟล์
- [ ] งานต้องการ parallel หรือ isolation จริงๆ

ถ้าครบแล้ว เปิดใช้ได้โดยพิมพ์ `@AgentName` — หรือถ้าต้องการให้ Claude ตัดสินใจ spawn เองด้วย ให้ลบ `disable-model-invocation: true` ออกจาก agent file นั้น
