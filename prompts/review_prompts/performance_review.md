# Prompt: Performance Review

## When to Use
ใช้หลัง Phase 7 หรือเมื่อ Lighthouse score ต่ำกว่า 90

---

## Prompt Template

```
Please review the following Pomodoro application code for performance issues.

**Performance budgets:**
- Initial bundle: ≤ 150 KB gzipped
- Analytics chunk: ≤ 80 KB gzipped  
- FCP < 1.5s, LCP < 2.5s, CLS < 0.1, INP < 200ms

**Current metrics:** (fill in from Lighthouse)
- Bundle size: {{X}} KB
- Lighthouse Performance: {{X}}
- LCP: {{X}}s

**Files to review:**
{{LIST FILES}}

**Please check for:**
1. Unnecessary re-renders — components subscribing to too-large Zustand slices
2. Missing lazy loading — non-critical pages/components loaded eagerly
3. Expensive renders — useMemo/useCallback opportunities
4. IndexedDB query efficiency — missing indexes, scanning large collections
5. Bundle bloat — large dependencies that could be tree-shaken or replaced
6. Memory leaks — event listeners or intervals not cleaned up
7. Tailwind purge issues — unused CSS classes not removed in build

**Format:** List issues by severity, with file:line and suggested fix.
```
