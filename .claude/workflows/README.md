# Workflows

โฟลเดอร์นี้เก็บ dynamic workflow scripts (`.js` files)

Workflows ถูกสร้างโดย Claude ผ่าน `/workflows` command — ไม่ต้องสร้างมือ

## วิธีใช้

```
/workflows new feature-sprint
```

Claude จะสร้างไฟล์ `.js` ที่สามารถ orchestrate งานหลายขั้นตอนได้อัตโนมัติ

## ตัวอย่าง workflows ที่อาจสร้างในอนาคต

- `feature-sprint.js` — วางแผน + implement + test feature ทั้งหมดใน sprint
- `release-check.js` — ตรวจสอบ pre-release checklist ทั้งหมด
- `daily-review.js` — สรุปสิ่งที่ทำเสร็จ + plan วันถัดไป
