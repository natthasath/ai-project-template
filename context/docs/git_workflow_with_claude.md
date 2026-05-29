# Git Workflow กับ Claude Code

## ทำไม Claude ถึงไม่ทำ Git เอง?

Claude Code แก้ไขไฟล์ได้ แต่ **ไม่ commit, ไม่ push, ไม่ branch** โดยอัตโนมัติ
เพราะ git history เป็น "ประวัติที่ลบยาก" — Claude จึงรอให้คุณตัดสินใจก่อนเสมอ

ผลลัพธ์: ถ้าคุณไม่มี commit ก่อนให้ Claude ทำงาน และ code พัง → **ไม่มีจุดย้อนกลับ**

---

## Safety Net Pattern (ใช้ทุกครั้ง)

```
ก่อนให้ Claude ทำงาน          หลัง Claude ทำเสร็จ
─────────────────────          ──────────────────────────────
1. git checkout -b branch      4. ตรวจสอบ: git diff + npm test
2. git add .                      ┌──── โอเค? ────┐
3. git commit "checkpoint"     5. ✅ commit      ❌ revert
                                   git add .      git checkout .
                                   git commit     git clean -fd
```

---

## Cheatsheet: วิธีย้อนกลับทุกกรณี

### กรณีที่ 1: Claude แก้ไฟล์แล้วพัง ยังไม่ได้ commit อะไรเลย

```bash
# ดูว่า Claude เปลี่ยนอะไร
git diff
git status

# ทิ้งการแก้ไขทุกไฟล์ที่มีอยู่แล้ว (tracked files)
git checkout .

# ลบไฟล์ใหม่ที่ Claude สร้างขึ้น (untracked files)
git clean -fd

# ผลลัพธ์: กลับไปเหมือนก่อน Claude ทำงาน 100%
```

### กรณีที่ 2: ทำ checkpoint commit ไว้ก่อน แล้วให้ Claude ทำ, ยัง commit งานจริงไม่ได้

```bash
# กลับไปที่ checkpoint เป๊ะๆ (ทิ้งทุกอย่างที่ Claude ทำ)
git reset --hard HEAD

# หรือถ้า checkpoint เป็น commit ก่อน HEAD:
git reset --hard HEAD~1
```

### กรณีที่ 3: Commit งาน Claude ไปแล้ว แต่พบว่าพัง

```bash
# สร้าง "undo commit" (safe — ไม่แก้ history)
git revert HEAD

# หรือถ้า commit หลายอันและอยากเลิก n อัน:
git revert HEAD~n..HEAD
```

### กรณีที่ 4: อยู่บน feature branch, merge เข้า main แล้วพัง

```bash
# บน main — undo merge
git revert -m 1 <merge-commit-hash>
git push

# หรือถ้า force ได้ (เพิ่ง push ไม่นาน, ไม่มีคนอื่น pull):
git reset --hard HEAD~1
git push --force-with-lease   # ปลอดภัยกว่า --force
```

---

## ตัวอย่าง Session จริง

### Scenario: พัฒนา Timer drift correction (Phase 1)

```bash
# === คุณทำ ===
git checkout main
git pull
git checkout -b feature/timer-drift-correction

# สร้าง safety net
git add .
git commit -m "chore: checkpoint before timer drift correction"

# === บอก Claude ===
# "ช่วย implement drift-correcting tick mechanism 
#  ตาม plans/phase_1_timer.md ใน src/entities/timer/timer-store.ts"

# === Claude แก้ไขไฟล์ ===
# ... Claude เขียน code ให้ ...

# === คุณตรวจสอบ ===
git diff src/entities/timer/timer-store.ts   # ดูว่าเปลี่ยนอะไร
npm run typecheck                             # TypeScript ผ่านไหม?
npm test -- timer-store                       # Tests ผ่านไหม?

# === ถ้าโอเค ===
git add src/entities/timer/timer-store.ts
git add src/entities/timer/timer-store.test.ts
git commit -m "feat(timer): add drift-correcting tick mechanism

Uses Date.now() comparison instead of counter increment to
compensate for setTimeout delay variance in background tabs."

# === ถ้าพัง ===
git checkout .    # กลับไปจุดเดิมทันที
# แล้วลองอีกครั้งพร้อม context เพิ่มเติม

# === เมื่อ feature เสร็จ ===
git push -u origin feature/timer-drift-correction
# สร้าง PR บน GitHub
```

---

## การสั่ง Claude ให้ทำ Git

เมื่อตรวจสอบแล้วว่าโอเค คุณสามารถสั่ง Claude ให้ทำ commit ได้:

```
# สั่ง commit
"commit ไฟล์ที่เปลี่ยนแปลงด้วย message: feat(timer): add drift correction"

# สั่ง สร้าง branch
"สร้าง branch ชื่อ feature/timer-drift-correction แล้ว checkout"

# สั่ง push (Claude จะถามยืนยันก่อน)
"push branch นี้ขึ้น origin"
```

Claude จะ:
- Stage เฉพาะไฟล์ที่เกี่ยวข้อง (ไม่ใช่ `git add -A` ทั้งหมด)
- สร้าง commit message ที่ตรง conventions
- **ไม่ push** เว้นแต่คุณสั่ง push ด้วยชัดเจน
- **ไม่ force push** เด็ดขาด เว้นแต่คุณพิมพ์ force push ชัดๆ

---

## Rules สำหรับ Claude

Claude ต้องปฏิบัติตามกฎเหล่านี้เสมอ:
- ❌ ห้าม `git push --force` หรือ `git push --force-with-lease` เว้นแต่ user สั่ง
- ❌ ห้าม `git reset --hard` กับ committed work เว้นแต่ user สั่ง
- ❌ ห้าม `git add -A` หรือ `git add .` ที่อาจ include `.env` หรือ secrets
- ✅ ถ้าไม่แน่ใจว่า user ต้องการ push หรือเปล่า — ถามก่อน
- ✅ แสดง `git status` + `git diff` ก่อน commit เสมอ
