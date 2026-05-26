# Prompt Library — Pomodoro Application

ไฟล์นี้เป็น index ของ reusable prompts ทั้งหมดในโปรเจค ใช้ prompts เหล่านี้แทนการเขียนใหม่ทุกครั้ง

## Feature Development Prompts

| File | Use When |
|---|---|
| [timer_feature.md](feature_prompts/timer_feature.md) | Build หรือแก้ไข timer-related functionality |
| [task_management.md](feature_prompts/task_management.md) | Build หรือแก้ไข task CRUD features |
| [notification_system.md](feature_prompts/notification_system.md) | Build notification หรือ audio features |
| [analytics_dashboard.md](feature_prompts/analytics_dashboard.md) | Build analytics charts หรือ stats |
| [settings_feature.md](feature_prompts/settings_feature.md) | Build หรือแก้ไข settings functionality |

## Review Prompts

| File | Use When |
|---|---|
| [code_review.md](review_prompts/code_review.md) | Review code quality, patterns, conventions |
| [security_review.md](review_prompts/security_review.md) | Audit security of new features |
| [performance_review.md](review_prompts/performance_review.md) | Audit performance and bundle size |
| [accessibility_review.md](review_prompts/accessibility_review.md) | Audit accessibility compliance |

## Debug Prompts

| File | Use When |
|---|---|
| [bug_investigation.md](debug_prompts/bug_investigation.md) | Systematic bug root-cause analysis |
| [performance_debug.md](debug_prompts/performance_debug.md) | Debug slow renders หรือ memory leaks |
| [timer_accuracy_debug.md](debug_prompts/timer_accuracy_debug.md) | Debug timer drift หรือ background issues |

## Refactor Prompts

| File | Use When |
|---|---|
| [component_refactor.md](refactor_prompts/component_refactor.md) | Refactor a component or feature |
| [store_refactor.md](refactor_prompts/store_refactor.md) | Refactor Zustand store structure |
| [optimization.md](refactor_prompts/optimization.md) | Performance optimization pass |

## How to Use

1. เลือก prompt file ที่ตรงกับงาน
2. อ่าน context section — ตรวจสอบว่า relevant file paths ยังถูกต้อง
3. Fill in placeholders ที่ระบุด้วย `{{PLACEHOLDER}}`
4. Paste ใน Claude Code conversation
