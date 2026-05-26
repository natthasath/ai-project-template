# Git Conventions

## Branch Naming

```
feature/<short-description>     # new functionality
fix/<issue-or-description>      # bug fixes
refactor/<what-changed>         # internal restructure, no behavior change
docs/<what-docs>                # documentation only
chore/<task>                    # tooling, dependencies, CI

Examples:
  feature/timer-drift-correction
  fix/notification-permission-ios
  refactor/task-store-actions
  docs/architecture-decision-records
  chore/upgrade-tailwind-v4
```

## Commit Message Format

```
<type>(<scope>): <imperative summary>

[Optional body — explain WHY, not WHAT]

[Optional footer — breaking changes, issue refs]
```

**Types:** `feat` | `fix` | `refactor` | `test` | `docs` | `chore` | `perf` | `style`  
**Scope:** `timer` | `tasks` | `sessions` | `notifications` | `settings` | `analytics` | `ui` | `db`  
**Summary:** max 72 chars, imperative mood, no period at end, English

```
Examples:
  feat(timer): add drift-correcting tick mechanism
  fix(notifications): request permission after user gesture, not on load
  refactor(tasks): replace boolean flags with discriminated union status
  test(timer): add cycle transition edge cases
  chore: upgrade Dexie.js to v4
```

## Pull Request Rules

1. PR title = commit message format (แต่ไม่ต้องมี scope ถ้า scope ชัดเจนจาก branch)
2. PR description ต้องมี: Summary, Test plan, Screenshots (ถ้า UI changes)
3. ทุก PR ต้อง pass: lint, typecheck, tests (CI)
4. ไม่ merge PR ที่มี unresolved review comments
5. Squash merge สำหรับ feature branches (เพื่อ clean history บน main)
6. Rebase merge สำหรับ fix/chore (เพื่อ preserve individual commits)

## Protected Branch Rules

- `main` — production-ready code, ห้าม push โดยตรง
- `develop` — integration branch (ถ้ามี), ห้าม push โดยตรง
- Force push ห้ามเด็ดขาดบน `main`

## Commit Signing

- ใช้ signed commits เมื่อ repo เป็น public
- `git config commit.gpgsign true`
