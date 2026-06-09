---
argument-hint: <task description>
---

เพิ่ม task ใหม่เข้า backlog: $ARGUMENTS

1. **เรียบเรียงความต้องการ** — วิเคราะห์ `$ARGUMENTS` แล้วร่าง task draft:
   - **ชื่อ task**: กระชับ ≤ 60 ตัวอักษร บอก action + object ชัดเจน (เช่น "Configure ESLint with TypeScript rules")
   - **Description**: ขยายความว่าต้องทำอะไร ทำไม และขอบเขตคืออะไร (2-4 ประโยค)
   - **Acceptance Criteria**: 2-4 ข้อที่ตรวจสอบได้จริง (testable, specific)
   - **Priority**: ประเมินจาก context (High / Medium / Low)
   - **Estimate**: ประเมินจำนวน Pomodoros ที่ต้องใช้

2. **แสดง draft ให้ confirm** ในรูปแบบนี้:

   ```
   📋 Task Draft

   ชื่อ: <ชื่อ task>
   Priority: <High/Medium/Low>
   Estimate: <X> Pomodoro(s)

   Description:
   <description>

   Acceptance Criteria:
   - [ ] <criteria 1>
   - [ ] <criteria 2>
   ...
   ```

   แล้วถามว่า "ต้องการแก้ไขส่วนไหนไหม หรือ OK ให้เพิ่มลง backlog เลย?"

3. **รอ confirm** — ถ้าผู้ใช้บอก OK หรือ ยืนยัน ถึงไปขั้นต่อไป ถ้าต้องการแก้ให้แก้แล้วแสดง draft ใหม่

4. อ่าน `context/tasks/backlog/phase_0_backlog.md` เพื่อหา task ID สูงสุด แล้ว generate ID ถัดไป
   - ตัวอย่าง: ถ้า ID ล่าสุดคือ `TSK-0-008` → ID ใหม่คือ `TSK-0-009`

5. เพิ่ม entry ต่อท้าย `context/tasks/backlog/phase_0_backlog.md`:

   ```
   ## TSK-0-XXX — <ชื่อ task ที่ confirm แล้ว>

   **Priority:** <priority>
   **Estimate:** <X> Pomodoro(s)
   **Status:** Backlog

   **Description:**
   <description>

   **Acceptance Criteria:**
   - [ ] <criteria 1>
   - [ ] <criteria 2>

   ---
   ```

6. แจ้ง task ID ที่ได้ และ reminder: "รัน `/start-task <id>` เมื่อพร้อมทำงาน"
