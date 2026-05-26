# Prompt: Security Review

## When to Use
ใช้เมื่อ feature ใหม่รับ user input, จัดการ file import/export, หรือใช้ browser APIs ใหม่

---

## Prompt Template

```
Please perform a security review of the following Pomodoro application code.

**Security context:**
- Client-side only app (no backend) — attack surface is: user input, data import, localStorage/IndexedDB
- Main risks: XSS via unsanitized input, prototype pollution via JSON import, localStorage injection
- CSP is configured: no inline scripts, no external connections

**Files to review:**
{{LIST FILES}}

**Please check for:**
1. XSS vectors — dangerouslySetInnerHTML, eval, innerHTML with user data
2. Input validation — all user inputs sanitized and range-checked at entry point
3. JSON import safety — schema validation before writing to IndexedDB
4. localStorage safety — no sensitive data stored in plain text
5. Prototype pollution — JSON.parse with user-provided data
6. Dependency risks — any new npm packages with known vulnerabilities

**For each finding:**
- Severity: Critical / High / Medium / Low / Info
- Location: file:line
- Description: what the issue is
- Recommendation: how to fix it
```
