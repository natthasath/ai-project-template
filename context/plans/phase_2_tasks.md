# Phase 2: Task Management

**Status:** 🔲 Not Started  
**Target:** 2026-06-10  
**Depends on:** Phase 1 complete  
**Goal:** ให้ user สร้างและจัดการ tasks ที่ผูกกับ Pomodoro sessions ได้

## Objectives

1. สร้าง `TaskStore` ด้วย Zustand
2. Implement Task CRUD operations พร้อม IndexedDB persistence
3. สร้าง `TaskList` widget
4. Integrate active task กับ `TimerStore` (session logging)
5. Implement task completion และ progress tracking
6. Drag-to-reorder task list

## Task Data Model

```typescript
interface Task {
  id: string                    // UUID v4
  title: string                 // max 200 chars
  estimatedPomodoros: number    // 1–20
  completedPomodoros: number    // incremented on session complete
  status: 'pending' | 'active' | 'completed'
  tags: string[]
  notes: string                 // max 2000 chars
  createdAt: Date
  updatedAt: Date
  completedAt: Date | null
}
```

## Deliverables

- `src/entities/task/` — TaskStore, Task types, task validation
- `src/features/task-manager/` — AddTaskForm, EditTaskModal, DeleteConfirm
- `src/widgets/task-list/` — TaskList, TaskItem, TaskProgress
- Integration: active task name แสดงใน TimerWidget
- Integration: completedPomodoros++ เมื่อ Pomodoro session สำเร็จ

## Acceptance Criteria

- [ ] User สร้าง task ใหม่ได้ภายใน 2 steps
- [ ] Tasks persist หลัง page reload
- [ ] Active task แสดงใน timer UI
- [ ] Estimated vs completed Pomodoros แสดงถูกต้อง
- [ ] Completed tasks ย้ายไป completed section อัตโนมัติ

## Notes

- Validation: title ต้องไม่ว่าง, estimatedPomodoros ต้อง 1–20
- ใช้ `crypto.randomUUID()` สำหรับ ID generation
- ลำดับ tasks เก็บใน array index (ไม่ต้องการ separate sort order field)
