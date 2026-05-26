# Prompt: Component Refactor

## When to Use
ใช้เมื่อ component ซับซ้อนเกินไป, ยาวเกิน 200 บรรทัด, หรือมี logic ที่ควรแยกออกมา

---

## Prompt Template

```
I need to refactor a component in the Pomodoro application.

**Component to refactor:**
{{FILE PATH}}

**Why it needs refactoring:**
{{e.g., "Component is 350 lines, mixing UI and business logic", "Too many props (12), hard to test"}}

**What the component currently does:**
{{DESCRIBE CURRENT RESPONSIBILITIES}}

**Target state after refactor:**
{{e.g., "Split into 3 smaller components", "Extract business logic to custom hook"}}

**Constraints:**
- No behavior changes — only internal restructure
- Tests must still pass after refactor
- Follow FSD architecture: UI logic in component, business logic in store/hooks
- Named exports only (no default exports)
- TypeScript strict mode maintained

**Please:**
1. Analyze the current component structure
2. Propose a refactoring plan (what to extract where)
3. Show the refactored code
4. Confirm existing tests still cover the behavior
```

---

## Refactor Patterns for This Project

| Problem | Solution |
|---|---|
| Complex state logic in component | Extract to Zustand store action |
| Repeated logic across components | Extract to `shared/hooks/` |
| Component > 150 lines | Split along responsibility lines |
| Deep prop drilling (3+ levels) | Use Zustand selector in child |
| Complex conditional rendering | Extract to sub-components |
