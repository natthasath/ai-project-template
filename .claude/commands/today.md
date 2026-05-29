---
---

!`git log --oneline --since="midnight" --author="$(git config user.name)" 2>/dev/null || echo "no commits today"`

สรุปงานที่ทำวันนี้

1. ดู git log ด้านบน — commits วันนี้มีอะไรบ้าง
2. อ่าน `context/tasks/in_progress/current_sprint.md` — มีงานที่ยังค้างอยู่ไหม
3. สรุปใน 3-5 bullet points:
   - ✅ ทำเสร็จแล้ว: ...
   - 🔄 กำลังทำ: ...
   - 📋 รอทำต่อพรุ่งนี้: ...
