# Rules Index — Pomodoro Application

อ่านไฟล์นี้ก่อนเริ่ม coding session ทุกครั้ง Rules เหล่านี้ไม่ใช่ guidelines — เป็น requirements

## Rule Files

| File | Scope |
|---|---|
| [coding_standards.md](coding_standards.md) | TypeScript, React, naming, file organization |
| [git_conventions.md](git_conventions.md) | Branch naming, commit messages, PR process |
| [testing_rules.md](testing_rules.md) | What to test, how to test, mocking policy |
| [security_rules.md](security_rules.md) | Input validation, XSS prevention, data handling |
| [ui_ux_rules.md](ui_ux_rules.md) | Component design, accessibility, responsive |
| [performance_rules.md](performance_rules.md) | Bundle size, rendering, memory usage |

## Non-Negotiable Rules (Top 5)

1. **TypeScript strict mode** — `"strict": true` เสมอ ห้าม `any` โดยไม่มี comment อธิบาย
2. **No backend dependencies** — ทุก feature ต้อง work offline, ไม่มี external API calls
3. **Tests ก่อน ship** — ไม่มี feature ที่ merge โดยไม่มี tests
4. **Accessibility first** — component ใหม่ทุกตัวต้องผ่าน axe audit ก่อน merge
5. **Security by default** — sanitize input ทุก user input boundary

## Rule Enforcement

- ESLint enforce: coding standards, import order
- TypeScript enforce: type safety, strict mode
- Husky pre-commit: lint + typecheck
- Husky pre-push: full test suite
- Code review: architecture + security + accessibility
