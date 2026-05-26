# Prompt: Analytics Dashboard

## When to Use
ใช้เมื่อต้องการ build หรือแก้ไข analytics charts, stats, หรือ data aggregation

---

## Prompt Template

```
I'm working on the analytics dashboard for the Pomodoro application.

**Context:**
- Data source: Dexie.js IndexedDB, sessions table indexed by startedAt, taskId, status
- All date calculations use Intl.DateTimeFormat — no date-fns or moment.js
- Timezone: always user's local timezone (no UTC conversion)
- Query pattern: db.sessions.where('startedAt').between(startDate, endDate).toArray()
- Memoize aggregations: don't re-query IndexedDB on every render

**Performance rules:**
- Use display_limit — never load all sessions at once
- Lazy load analytics page: const AnalyticsPage = lazy(() => import('@pages/analytics'))
- useMemo for aggregated data, not raw queries

**Task:**
{{DESCRIBE THE ANALYTICS FEATURE}}

**Chart types available:**
- Bar chart (daily/weekly Pomodoro counts)
- Heatmap calendar (52-week grid)
- Line chart (trend over time)
- Horizontal bar (task comparison)

**Constraints:**
- Empty state required: show guidance when no session data exists
- All charts must be accessible (aria-labels, keyboard navigation)
- No chart library unless bundle impact is justified (prefer native SVG)

**Files to modify:**
{{LIST FILES}}
```
