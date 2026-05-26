# Prompt: Accessibility Review

## When to Use
ใช้หลังสร้าง component ใหม่ หรือก่อน Phase 8 QA

---

## Prompt Template

```
Please review the following Pomodoro application components for accessibility issues.

**Accessibility target:** WCAG 2.1 Level AA

**Files to review:**
{{LIST COMPONENT FILES}}

**Please check for:**
1. Keyboard navigation — all interactive elements reachable, logical tab order
2. ARIA labels — icon buttons, progress indicators, live regions labeled
3. Focus management — focus trap in modals, focus restore on modal close
4. Color contrast — text/background combinations ≥ 4.5:1 (AA)
5. Screen reader compatibility — semantic HTML, ARIA roles, descriptions
6. Touch targets — minimum 44×44px for interactive elements
7. Reduced motion — animations respect prefers-reduced-motion
8. Error announcements — form errors announced to screen readers

**For each issue:**
- WCAG criterion violated (e.g., 1.4.3 Contrast)
- Element/location
- Current behavior
- Required behavior
- Suggested fix
```
