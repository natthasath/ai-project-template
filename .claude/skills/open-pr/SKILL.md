---
name: open-pr
description: เปิด Pull Request จาก feature branch ปัจจุบันไปยัง main — draft title/body จาก commits แล้วรอ confirm
tools:
  - Bash
---

เปิด Pull Request สำหรับ branch ปัจจุบัน: $ARGUMENTS

1. รัน `git branch --show-current` และ `git status --short` พร้อมกัน

2. ตรวจสอบเบื้องต้น:
   - ถ้า branch ปัจจุบันคือ `main` — แจ้ง "อยู่บน main แล้ว ไม่มี feature branch ที่จะเปิด PR" แล้วหยุด
   - ถ้ามี uncommitted changes — แจ้ง "มี uncommitted changes อยู่ รัน /push ก่อน" แล้วหยุด
   - ตรวจว่า branch นี้มีบน remote แล้วหรือยัง:
     ```bash
     git ls-remote --heads origin <branch>
     ```
     ถ้ายังไม่มี — แจ้ง "branch ยังไม่ได้ push รัน /push ก่อน" แล้วหยุด

3. รวบรวม context สำหรับ PR:
   ```bash
   git log main..HEAD --oneline
   git diff main...HEAD --stat
   ```

4. Draft PR title และ body:
   - **Title**: สรุป commits ทั้งหมดเป็น 1 ประโยค ≤ 70 ตัวอักษร ตาม convention `<type>(<scope>): <summary>`
   - **Body**: สร้างจาก template นี้:
     ```
     ## Summary
     - <bullet point สรุปสิ่งที่เปลี่ยน>
     - <bullet point 2 ถ้ามี>

     ## Changes
     <git diff --stat output>

     ## Test plan
     - [ ] typecheck ผ่าน
     - [ ] lint ผ่าน
     - [ ] tests ผ่าน
     - [ ] ทดสอบ manually แล้ว
     ```

5. แสดง draft และขอ confirm:
   ```
   📋 PR Draft

   Title: <title>
   Base:  main ← <feature-branch>

   Body:
   <body>

   ต้องการแก้ไขอะไรไหม หรือ OK ให้เปิด PR เลย?
   ```
   รอ confirm ก่อน

6. เปิด PR ด้วย `gh`:
   ```bash
   gh pr create \
     --title "<title>" \
     --body "<body>" \
     --base main \
     --head <branch>
   ```
   ถ้าไม่มี `gh` ในระบบ — แสดง URL format แทน:
   `https://github.com/<owner>/<repo>/compare/main...<branch>`

7. รายงานผลและปิดท้าย:
   ```
   ✅ Pull Request เปิดแล้ว

   Title:  <title>
   URL:    <pr-url>
   Branch: <feature-branch> → main
   ```

   ```
   ─────────────────────────────────────────────────
   ถัดไป → <pr-url>         (review + merge บน GitHub)
            /merge           (merge local แทน)
   ─────────────────────────────────────────────────
   ```
