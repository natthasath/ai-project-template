# Phase 6: Analytics Dashboard

**Status:** 🔲 Not Started  
**Target:** 2026-07-01  
**Depends on:** Phase 4 complete (session data must exist)  
**Goal:** แสดง productivity trends และ insights จาก session history

## Charts & Metrics

### Daily View
- **Pomodoro count** — bar chart สำหรับ 7 วันล่าสุด
- **Focus time** — total minutes ต่อวัน
- **Completion rate** — % sessions completed vs interrupted

### Weekly View
- **Heatmap calendar** — GitHub-style intensity heatmap (52 weeks)
- **Best day of week** — bar chart เปรียบเทียบ Mon–Sun

### Task View
- **Top tasks by Pomodoros** — horizontal bar chart (top 10)
- **Average Pomodoros per task** — gauge

### Summary Stats (All Time)
- Total Pomodoros completed
- Total focus time (hours)
- Longest streak (consecutive days)
- Current streak

## Tech Decision: Chart Library

**Recharts** (React-native charting) — ถ้า bundle size เป็นปัญหา ใช้ native SVG แทน
> ตัดสินใจนี้ให้ revisit ตอน Phase 6 เริ่ม

## Deliverables

- `src/entities/session/` — analytics query functions (aggregateByDay, etc.)
- `src/features/analytics/` — chart components, date range selector
- `src/pages/analytics/` — Analytics page พร้อม tab navigation

## Acceptance Criteria

- [ ] Charts render ถูกต้องสำหรับ data ranges ต่างๆ (1 วัน, 7 วัน, 30 วัน)
- [ ] Empty state แสดงเมื่อยังไม่มีข้อมูล (แทนที่ empty chart)
- [ ] Charts accessible (aria-labels, keyboard navigation)
- [ ] ไม่ re-query IndexedDB ทุก render — ใช้ memoization

## Notes

- Analytics เป็น read-only feature — ไม่มี side effects
- Date calculations ทั้งหมดใช้ `Intl.DateTimeFormat` (ไม่ใช้ date-fns หรือ moment.js)
- Timezone: ใช้ user's local timezone เสมอ
