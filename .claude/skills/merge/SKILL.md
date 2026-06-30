---
name: merge
description: Merge feature branch กลับ main — ตรวจสอบก่อน merge, ลบ branch หลัง merge เสร็จ
tools:
  - Bash
---

Merge branch ปัจจุบันกลับ main: $ARGUMENTS

1. รัน `git branch --show-current` และ `git status --short` พร้อมกัน

2. ตรวจสอบเบื้องต้น:
   - ถ้า branch ปัจจุบันคือ `main` — แจ้ง "อยู่บน main อยู่แล้ว ไม่มีอะไรต้อง merge" แล้วหยุด
   - ถ้ามีไฟล์ที่ยังไม่ได้ commit — แจ้ง "มี uncommitted changes อยู่ รัน /push ก่อน" แล้วหยุด

3. รัน `git log main..HEAD --oneline` เพื่อดู commits ที่จะ merge

4. แสดง summary และขอ confirm:

   ```
   🔀 Merge plan

   Branch:  <feature-branch> → main
   Commits: <จำนวน> commits
     · <commit 1>
     · <commit 2>

   หลัง merge: ลบ <feature-branch> (local + remote)
   ```

   รอผู้ใช้ confirm ก่อนดำเนินการ

5. Merge:
   ```bash
   git checkout main
   git pull origin main          # sync main ก่อน merge
   git merge --no-ff <branch> -m "merge(<scope>): <branch-name>"
   ```
   - `--no-ff` เพื่อเก็บ merge commit ไว้ใน history
   - scope ดึงจากชื่อ branch เช่น `feature/timer-core` → scope = `timer`

6. ถ้า merge มี conflict:
   - แจ้งไฟล์ที่ conflict
   - รัน `git merge --abort` เพื่อยกเลิก
   - แนะนำให้ resolve conflict มือแล้วรันใหม่
   - หยุด (ไม่ดำเนินการต่อ)

7. Push main และลบ branch:
   ```bash
   git push origin main
   git branch -d <branch>
   git push origin --delete <branch>
   ```

8. รายงานผล:

   ```
   ✅ Merge เสร็จแล้ว

   <feature-branch> → main
   Commits: <จำนวน>
   Branch ลบแล้ว: local + remote
   ```

   แล้วปิดท้ายด้วย:

   ```
   ─────────────────────────────────────
   ถัดไป → /done-task <task-id>   (mark task เสร็จ)
   ─────────────────────────────────────
   ```
