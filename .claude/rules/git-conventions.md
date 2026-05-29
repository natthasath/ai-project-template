---
description: Git workflow, commit messages, branch naming — Claude Code ไม่ทำ git อัตโนมัติ
---

# Git Conventions

## ⚠️ Claude Code ไม่ทำ Git อัตโนมัติ

Claude Code **ไม่** สร้าง branch, commit, หรือ push เองโดยอัตโนมัติ
ทำได้ก็ต่อเมื่อคุณสั่งเท่านั้น

**วิธีป้องกัน code หาย:** ทำ checkpoint commit ก่อนให้ Claude ทำงานทุกครั้ง

---

## Workflow กับ Claude Code

```bash
# ขั้นที่ 1: สร้าง branch ใหม่
git checkout main && git pull
git checkout -b feature/ชื่อ-feature

# ขั้นที่ 2: checkpoint commit (ก่อนให้ Claude ทำงาน)
git add . && git commit -m "chore: checkpoint before <ชื่องาน>"

# ขั้นที่ 3: บอก Claude ให้ทำงาน

# ขั้นที่ 4: ตรวจสอบ
npm run lint && npm run typecheck && npm test

# ขั้นที่ 5ก: โอเค → commit
git add src/ tests/
git commit -m "feat(timer): add drift correction"

# ขั้นที่ 5ข: พัง → ย้อนกลับ
git checkout .          # ทิ้งการแก้ไขทุกไฟล์
git clean -fd           # ลบไฟล์ใหม่ที่ Claude สร้าง
# ถ้ามี checkpoint: git reset --hard HEAD
```

## วิธีย้อนกลับแบบต่างๆ

| สถานการณ์ | คำสั่ง |
|---|---|
| ยังไม่ได้ commit, อยากทิ้งการแก้ไข | `git checkout .` |
| มี checkpoint commit, อยากกลับไปจุดนั้น | `git reset --hard HEAD` |
| Commit ไปแล้ว, อยาก undo ล่าสุด | `git revert HEAD` |
| อยากดูว่า Claude เปลี่ยนอะไร | `git diff` |
| Compare กับ main | `git diff main...HEAD` |

## Branch Naming

```
feature/<short-description>    # feature ใหม่
fix/<issue-or-description>     # แก้ bug
refactor/<what-changed>        # refactor (ไม่เปลี่ยน behavior)
docs/<what-docs>               # เอกสารอย่างเดียว
chore/<task>                   # tooling, dependencies, CI
```

## Commit Message Format

```
<type>(<scope>): <imperative summary>

[Optional body — อธิบาย WHY ไม่ใช่ WHAT]
```

**Types:** `feat` | `fix` | `refactor` | `test` | `docs` | `chore` | `perf`
**Scope:** `timer` | `tasks` | `sessions` | `notifications` | `settings` | `analytics`
**Summary:** max 72 chars, imperative mood, ภาษาอังกฤษ, ไม่มีจุดท้าย

```
feat(timer): add drift-correcting tick mechanism
fix(notifications): request permission after user gesture
refactor(tasks): replace boolean flags with discriminated union
test(timer): add cycle transition edge cases
```

## Protected Branches

- `main` — production-ready, ห้าม push โดยตรง
- Force push ห้ามเด็ดขาดบน `main`
- ทุก PR ต้อง pass: lint, typecheck, tests
