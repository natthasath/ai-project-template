# Prompt: Performance Optimization Pass

## When to Use
ใช้เมื่อ feature เสร็จแล้ว แต่ต้องการ optimize ก่อน ship

---

## Prompt Template

```
Please optimize the following Pomodoro application code for performance.

**Files to optimize:**
{{LIST FILES}}

**Current performance baseline:**
- Lighthouse: {{X}}
- Biggest re-render bottlenecks (from React Profiler): {{X}}
- Bundle contribution of these files: {{X KB}}

**Optimization goals:**
- Reduce unnecessary re-renders
- Memoize expensive computations
- Improve IndexedDB query efficiency (if applicable)

**Constraints:**
- No behavior changes
- No new dependencies
- Don't add useMemo/useCallback where it's not needed (premature optimization)
  Rule: only add memo if you can demonstrate the render is actually expensive

**Please:**
1. Identify the top 3 performance opportunities in these files
2. Show the optimized code for each
3. Explain why each optimization helps (don't just add memo everywhere)
4. Note any optimizations you considered but rejected (and why)
```
