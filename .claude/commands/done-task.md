---
argument-hint: <task-id>
---

Mark task เสร็จแล้ว: $ARGUMENTS

1. อ่าน `context/tasks/in_progress/current_sprint.md`
2. เปลี่ยน status ของ task `$ARGUMENTS` จาก 🔄 เป็น ✅ Done พร้อมวันที่วันนี้
3. อ่าน `context/tasks/completed/archive.md` แล้ว append task นี้ลงไปพร้อม completion date
4. รัน `git log --oneline -3` เพื่อแสดง commits ที่เกี่ยวข้อง
5. แจ้งว่า task เสร็จแล้ว และถาม: "ต้องการ merge branch นี้กลับ main ไหม? ถ้าใช่ รัน /ship $ARGUMENTS ก่อน"
