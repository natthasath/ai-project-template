---
argument-hint: <thai|eng>
---

เปลี่ยน output style ที่ใช้ใน project นี้

**Styles ที่มี:**
- `thai` → `.claude/output-styles/concise-thai.md` (ภาษาไทย, กระชับ)
- `eng` → `.claude/output-styles/concise-eng.md` (English only, concise)

1. ถ้าไม่มี $ARGUMENTS — แสดง styles ที่มีพร้อม description แล้วถามว่าต้องการใช้อันไหน

2. อ่าน `CLAUDE.md` เพื่อตรวจสอบว่ามี section `## Output Style` อยู่แล้วหรือยัง

3. ถ้า **ยังไม่มี** section นั้น — append ต่อท้าย `CLAUDE.md`:
   ```
   ## Output Style

   @.claude/output-styles/concise-<thai|eng>.md
   ```

4. ถ้า **มีอยู่แล้ว** — แก้ไข line `@.claude/output-styles/...` ให้ชี้ไปที่ style ใหม่

5. แจ้งว่า style ถูกเปลี่ยนเป็นอะไร และมีผลทันทีใน session ถัดไป
