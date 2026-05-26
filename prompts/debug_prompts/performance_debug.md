# Prompt: Performance Debug

## When to Use
ใช้เมื่อ app ช้า, jank, หรือ Lighthouse score ต่ำกว่า target

---

## Prompt Template

```
I'm investigating a performance issue in the Pomodoro application.

**Symptom:**
{{e.g., "Timer UI lags every second", "Analytics page takes 3s to load", "Memory grows over time"}}

**Metrics:**
- Lighthouse Performance score: {{X}}
- React DevTools Profiler: {{component re-rendering too often?}}
- Chrome Performance tab: {{long tasks? layout shifts?}}

**Suspected area:**
{{Timer rendering / Analytics queries / IndexedDB / Bundle size}}

**Please analyze:**
1. What is the most likely performance bottleneck given these symptoms?
2. What specific profiling steps should I take to confirm?
3. What's the fix once confirmed?

**Relevant files:**
{{LIST FILES}}
```

---

## Performance Investigation Checklist

```
□ Open React DevTools Profiler — record 5 timer ticks, identify which components re-render
□ Check Zustand selectors — are they granular enough?
□ Check Chrome Memory tab — is heap growing during timer?
□ Run `npm run build` — check chunk sizes
□ Run Lighthouse in incognito — get baseline metrics
□ Check IndexedDB queries in DevTools Application tab
```
