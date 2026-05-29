---
description: Custom color themes สำหรับ Claude Code UI
---

# Themes

ไฟล์ `.json` ในโฟลเดอร์นี้คือ color themes สำหรับ Claude Code terminal UI

## วิธีใช้

เลือก theme ผ่าน Claude Code settings หรือ command `/theme <name>`

## สร้าง Theme ใหม่

สร้างไฟล์ `<theme-name>.json` พร้อมนิยามสี:

```json
{
  "name": "theme-name",
  "type": "dark",
  "colors": {
    "background": "#1a1a2e",
    "foreground": "#e8e8f0",
    "primary":    "#e85d5d",
    "secondary":  "#4caf82"
  }
}
```

ใช้ `type: "dark"` หรือ `type: "light"` ตามพื้นหลัง
