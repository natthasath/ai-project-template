---
name: feedback-history
description: สิ่งที่ได้ผลดีและสิ่งที่ต้องแก้ไขจาก development iterations ที่ผ่านมา
metadata:
  type: feedback
---

# Feedback History

## Template Entry Format

```markdown
### [YYYY-MM-DD] — ชื่อ iteration หรือ feature
**Result:** ✅ Success / ❌ Failure / ⚠️ Partial
**What happened:** อธิบายสั้นๆ
**Why it matters:** เหตุผลที่ควรจำ
**Rule going forward:** สิ่งที่จะทำ/ไม่ทำในครั้งต่อไป
```

---

## Entries

_(ไฟล์นี้เริ่มว่างเปล่า — เพิ่ม entry หลังจาก complete iteration แรก)_

### ตัวอย่าง (สมมติ)

### [2026-05-26] — Project template creation
**Result:** ✅ Success  
**What happened:** สร้าง prompt structure ก่อนเขียนโค้ดทำให้ทีมเข้าใจ architecture ตรงกัน  
**Why it matters:** ลด rework จาก misalignment ระหว่าง AI และ developer  
**Rule going forward:** เริ่ม feature ใหม่ด้วยการ update `context/tasks/` และ `context/plans/` ก่อนเสมอ  
