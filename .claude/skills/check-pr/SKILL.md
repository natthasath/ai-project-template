---
name: check-pr
description: ตรวจสอบสถานะ Pull Request — CI checks, review status, merge conflicts
tools:
  - Bash
---

ตรวจสอบสถานะ PR สำหรับ branch ปัจจุบัน: $ARGUMENTS

1. หา PR ที่เกี่ยวข้อง:
   - ถ้ามี $ARGUMENTS (PR number หรือ URL) ใช้ตรงนั้น
   - ถ้าไม่มี ใช้ branch ปัจจุบัน:
     ```bash
     git branch --show-current
     gh pr view --json number,title,state,url 2>/dev/null
     ```
   - ถ้าไม่พบ PR — แจ้ง "ไม่พบ PR สำหรับ branch นี้ รัน /open-pr ก่อน" แล้วหยุด

2. ดึงข้อมูล PR ทั้งหมดพร้อมกัน:
   ```bash
   gh pr view --json number,title,state,baseRefName,headRefName,mergeable,url,reviews,reviewDecision
   gh pr checks
   ```

3. แสดงผลในรูปแบบนี้:

   ```
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    PR #<number> — <title>
    <feature-branch> → <base-branch>
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

   CI Checks
     ✅ build          (2m 14s)
     ✅ lint           (45s)
     ❌ test           failed — <error summary>
     ⏳ deploy-preview  running...

   Reviews
     ✅ approved       @reviewer1
     💬 changes requested  @reviewer2 — "<comment>"
     ⏳ pending        @reviewer3

   Merge
     ✅ No conflicts with main
     (หรือ) ❌ Conflict — <ชื่อไฟล์ที่ conflict>

   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   ```

   Legend: ✅ pass  ❌ fail  ⏳ pending  💬 needs action

4. ประเมิน state และปิดท้าย:

   **ถ้าพร้อม merge ทุกอย่าง** (CI ผ่าน + approved + ไม่มี conflict):
   ```
   ─────────────────────────────────────────────────
   ✅ READY TO MERGE
   ถัดไป → /merge   (merge local แล้วลบ branch)
            <pr-url>  (merge บน GitHub)
   ─────────────────────────────────────────────────
   ```

   **ถ้า CI fail:**
   ```
   ─────────────────────────────────────────────────
   ❌ CI FAILING — แก้แล้วรัน:
   ถัดไป → /push   (push fix แล้ว CI จะรันใหม่อัตโนมัติ)
   ─────────────────────────────────────────────────
   ```

   **ถ้ามี changes requested:**
   ```
   ─────────────────────────────────────────────────
   💬 CHANGES REQUESTED — แก้ตาม review แล้วรัน:
   ถัดไป → /push   (push แล้วตอบ review comments)
   ─────────────────────────────────────────────────
   ```

   **ถ้า CI ยังรันอยู่:**
   ```
   ─────────────────────────────────────────────────
   ⏳ CI กำลังรัน — รอแล้วรัน /check-pr อีกครั้ง
   ─────────────────────────────────────────────────
   ```

   **ถ้ามี merge conflict:**
   ```
   ─────────────────────────────────────────────────
   ❌ MERGE CONFLICT — resolve แล้วรัน:
     git checkout <feature-branch>
     git merge main
     (แก้ conflict)
     /push
   ─────────────────────────────────────────────────
   ```
