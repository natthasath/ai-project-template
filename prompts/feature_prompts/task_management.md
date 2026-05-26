# Prompt: Task Management Feature

## When to Use
ใช้เมื่อต้องการ build หรือแก้ไข task CRUD, task-timer integration, หรือ task UI

## Context to Load First
- `memory/architecture.md` — TaskStore structure และ data model
- `plans/phase_2_tasks.md` — Task requirements
- `rules/coding_standards.md` — TypeScript patterns
- `rules/security_rules.md` — Input validation rules

---

## Prompt Template

```
I'm working on the Pomodoro application's task management feature.

**Context:**
- Tasks stored in Zustand TaskStore + Dexie.js IndexedDB for persistence
- Task model: { id: UUID, title: string (max 200), estimatedPomodoros: 1-20, 
  completedPomodoros: number, status: 'pending'|'active'|'completed', tags: string[], 
  notes: string (max 2000), createdAt, updatedAt, completedAt }
- Only one task can be 'active' at a time (linked to running timer)
- Tasks auto-complete when completedPomodoros >= estimatedPomodoros

**Task:**
{{DESCRIBE THE TASK FEATURE HERE}}

**Constraints:**
- Validate all user input: strip HTML from title/notes, enforce length limits
- Use crypto.randomUUID() for ID generation
- Zustand selector pattern: subscribe to specific fields only
- Tests must cover validation edge cases

**Files to modify:**
{{LIST FILES}}

**Acceptance criteria:**
{{LIST CRITERIA}}
```

---

## Security Reminder

ทุกครั้งที่รับ input จาก user (title, notes, tags):
1. Strip HTML tags
2. Enforce length limits
3. ตรวจสอบว่า estimatedPomodoros อยู่ใน range 1–20
