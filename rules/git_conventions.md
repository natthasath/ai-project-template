# Git Conventions

## ⚠️ Claude Code ไม่ทำ Git อัตโนมัติ

Claude Code **ไม่** สร้าง branch, commit, หรือ push เองโดยอัตโนมัติ
ทำได้ก็ต่อเมื่อคุณสั่งเท่านั้น

**ผลที่ตามมา:** ถ้าคุณให้ Claude แก้ไขไฟล์โดยไม่มี commit ก่อนหน้า
และผลลัพธ์พัง — คุณไม่มีจุดย้อนกลับ

**วิธีป้องกัน:** ดู "Workflow กับ Claude Code" ด้านล่าง

---

## Workflow กับ Claude Code (สำคัญมาก)

### กฎทอง: commit ก่อนให้ Claude ทำงานทุกครั้ง

```
[คุณ] git checkout -b feature/timer-drift-correction
[คุณ] git add . && git commit -m "chore: checkpoint before timer refactor"
[Claude] แก้ไขไฟล์ต่างๆ ตามที่สั่ง
[คุณ] ตรวจสอบผลลัพธ์
  ✅ ถ้าโอเค → git add . && git commit -m "feat(timer): add drift correction"
  ❌ ถ้าพัง → git checkout . (ทิ้งการแก้ไขทั้งหมด กลับไปจุดเดิม)
```

### ขั้นตอน Step-by-Step ต่อ Task หนึ่งๆ

```bash
# ขั้นที่ 1: สร้าง branch ใหม่จาก main (ก่อนเริ่มทุกครั้ง)
git checkout main
git pull
git checkout -b feature/ชื่อ-feature

# ขั้นที่ 2: สร้าง checkpoint commit (ก่อนให้ Claude ทำงาน)
# ถ้ายังไม่มีโค้ดเลย ข้ามขั้นนี้ได้
git add .
git commit -m "chore: checkpoint before <ชื่องาน>"

# ขั้นที่ 3: บอก Claude ให้ทำงาน
# (Claude แก้ไขไฟล์ให้)

# ขั้นที่ 4: ตรวจสอบ
npm run lint && npm run typecheck && npm test

# ขั้นที่ 5ก: ถ้าโอเค — commit งานจริง
git add src/ tests/              # เพิ่มเฉพาะไฟล์ที่เกี่ยวข้อง
git commit -m "feat(timer): add drift-correcting tick mechanism"

# ขั้นที่ 5ข: ถ้าพัง — ย้อนกลับทั้งหมด
git checkout .                   # ทิ้งการแก้ไขทุกไฟล์ (untracked ยังอยู่)
git clean -fd                    # ลบไฟล์ใหม่ที่ Claude สร้าง (ระวัง!)
# หรือถ้า commit checkpoint ไว้แล้ว:
git reset --hard HEAD            # กลับไป checkpoint เป๊ะๆ
```

### วิธีย้อนกลับแบบต่างๆ

| สถานการณ์ | คำสั่ง |
|---|---|
| ยังไม่ได้ commit อะไรเลย, อยากทิ้งการแก้ไข | `git checkout .` |
| มี checkpoint commit แล้ว, อยากกลับไปจุดนั้น | `git reset --hard HEAD` |
| Commit ไปแล้วหลายอัน, อยาก undo commit ล่าสุด | `git revert HEAD` |
| อยากดูว่า Claude เปลี่ยนอะไรก่อนตัดสินใจ | `git diff` หรือ `git status` |
| อยาก compare กับ main ว่าต่างกันยังไง | `git diff main...HEAD` |

### การสั่ง Claude ให้ commit ให้

เมื่อตรวจสอบแล้วว่าโอเค คุณสามารถสั่ง Claude ได้:

```
# ตัวอย่างวิธีสั่ง:
"commit ไฟล์เหล่านี้ด้วย message ว่า feat(timer): add drift correction"
"สร้าง commit สำหรับการเปลี่ยนแปลงนี้"
```

Claude จะ stage เฉพาะไฟล์ที่เกี่ยวข้อง และสร้าง commit ให้ แต่ **ไม่ push** เว้นแต่คุณสั่ง push ด้วย

---

## Branch Naming

```
feature/<short-description>     # new functionality
fix/<issue-or-description>      # bug fixes
refactor/<what-changed>         # internal restructure, no behavior change
docs/<what-docs>                # documentation only
chore/<task>                    # tooling, dependencies, CI

Examples:
  feature/timer-drift-correction
  fix/notification-permission-ios
  refactor/task-store-actions
  docs/architecture-decision-records
  chore/upgrade-tailwind-v4
```

## Commit Message Format

```
<type>(<scope>): <imperative summary>

[Optional body — explain WHY, not WHAT]

[Optional footer — breaking changes, issue refs]
```

**Types:** `feat` | `fix` | `refactor` | `test` | `docs` | `chore` | `perf` | `style`  
**Scope:** `timer` | `tasks` | `sessions` | `notifications` | `settings` | `analytics` | `ui` | `db`  
**Summary:** max 72 chars, imperative mood, no period at end, English

```
Examples:
  feat(timer): add drift-correcting tick mechanism
  fix(notifications): request permission after user gesture, not on load
  refactor(tasks): replace boolean flags with discriminated union status
  test(timer): add cycle transition edge cases
  chore: upgrade Dexie.js to v4
```

## Pull Request Rules

1. PR title = commit message format (แต่ไม่ต้องมี scope ถ้า scope ชัดเจนจาก branch)
2. PR description ต้องมี: Summary, Test plan, Screenshots (ถ้า UI changes)
3. ทุก PR ต้อง pass: lint, typecheck, tests (CI)
4. ไม่ merge PR ที่มี unresolved review comments
5. Squash merge สำหรับ feature branches (เพื่อ clean history บน main)
6. Rebase merge สำหรับ fix/chore (เพื่อ preserve individual commits)

## Protected Branch Rules

- `main` — production-ready code, ห้าม push โดยตรง
- `develop` — integration branch (ถ้ามี), ห้าม push โดยตรง
- Force push ห้ามเด็ดขาดบน `main`

## Commit Signing

- ใช้ signed commits เมื่อ repo เป็น public
- `git config commit.gpgsign true`
