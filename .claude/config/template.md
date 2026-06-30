---
description: Template repo URL สำหรับ /sync-template — แก้ไขตรงนี้ถ้าใช้ fork หรือ private repo
---

## Template Repository

```
repo: https://github.com/natthasath/ai-project-template.git
```

## วิธีใช้

ไฟล์นี้อ่านโดย `/sync-template` เพื่อรู้ว่าจะดึง `.claude/` infrastructure จากที่ไหน

**เปลี่ยน URL:** แก้บรรทัด `repo:` ด้านบนถ้าต้องการใช้ fork หรือ private repo

**Override ชั่วคราว:** `/sync-template https://github.com/your-fork/ai-project-template.git`

## Dirs ที่ sync

| Dir | Synced? |
|---|---|
| `.claude/rules/` | ✅ |
| `.claude/skills/` | ✅ |
| `.claude/agents/` | ✅ |
| `.claude/commands/` | ✅ |
| `.claude/output-styles/` | ✅ |
| `.claude/workflows/` | ✅ |
| `.claude/themes/` | ✅ |
| `.claude/config/` | ❌ project-specific |
| `.claude/agent-memory/` | ❌ project-specific |
| `.claude/settings.json` | ❌ project-specific |
