# Prompt: Code Review

## When to Use
ใช้ก่อน merge PR หรือเมื่อต้องการ review code quality ของ feature ที่เขียนเสร็จแล้ว

---

## Prompt Template

```
Please review the following code changes in the Pomodoro application.

**Project context:**
- TypeScript strict mode, React 19, Zustand, Tailwind CSS v4, Dexie.js
- Architecture: Feature-Sliced Design (app/pages/widgets/features/entities/shared)
- Rules: see rules/coding_standards.md, rules/security_rules.md

**Files changed:**
{{LIST CHANGED FILES}}

**What this change does:**
{{DESCRIBE THE CHANGE}}

**Please review for:**
1. TypeScript correctness — no `any`, proper types, strict mode compliance
2. React patterns — proper hooks usage, no stale closures, correct memo usage
3. Zustand patterns — selector granularity, no unnecessary re-renders
4. Security — input validation, XSS vectors, unsafe HTML rendering
5. Accessibility — ARIA labels, keyboard navigation, focus management
6. Test coverage — are the right things tested? are tests behavior-focused?
7. Performance — unnecessary re-renders, missing memoization, bundle impact
8. Code clarity — naming, unnecessary complexity, missing edge cases

**Format your response as:**
- ✅ Good: [what's done well]
- ⚠️ Suggestion: [optional improvements]
- ❌ Required: [must fix before merge]
```
