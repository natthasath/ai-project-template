# Pomodoro Application — Claude Code Instructions

## Project Overview

A cross-platform Pomodoro timer application that helps users manage focus sessions, track tasks, and analyze productivity patterns. This file is the authoritative source of truth for all AI-assisted development in this project.

## Repository Structure

```
pomodoro-app/
├── .claude/            # Claude Code configuration
├── memory/             # Persistent AI memory (project context, preferences, decisions)
├── plans/              # Development phase plans and roadmaps
├── rules/              # Coding standards, conventions, and constraints
├── tasks/              # Task tracking (backlog / in_progress / completed)
├── prompts/            # Reusable prompt library for common development scenarios
├── docs/               # Requirements, design docs, and Architecture Decision Records
├── src/                # Application source code (created during development)
├── tests/              # Test suites (created during development)
└── CLAUDE.md           # This file — always read first
```

## How to Use This Template

1. **Before starting any work** — read `plans/PLAN.md` to understand the current phase.
2. **Before writing code** — read `rules/RULES.md` and the relevant rule files.
3. **For recurring tasks** — use prompts from the `prompts/` library instead of writing from scratch.
4. **After making decisions** — update `memory/` and `docs/decisions/` accordingly.
5. **After completing tasks** — move them from `tasks/in_progress/` to `tasks/completed/`.

## Tech Stack (Decided)

| Layer | Technology | Rationale |
|---|---|---|
| Framework | React 19 + TypeScript | Component reusability, strong typing |
| Build Tool | Vite | Fast HMR, modern ESM |
| State | Zustand | Minimal boilerplate, devtools support |
| Styling | Tailwind CSS v4 | Utility-first, design consistency |
| Storage | IndexedDB (Dexie.js) | Offline-first, large dataset support |
| Notifications | Web Notifications API | Native OS notifications |
| Audio | Web Audio API | No external dependencies |
| Testing | Vitest + Testing Library | Co-located with Vite |
| E2E Testing | Playwright | Cross-browser coverage |

> See `docs/decisions/` for full ADR rationale.

## Core Domain Concepts

- **Pomodoro** — A 25-minute focused work session
- **Short Break** — A 5-minute rest between Pomodoros
- **Long Break** — A 15–30-minute rest after 4 Pomodoros (one cycle)
- **Cycle** — A set of 4 Pomodoros + 3 short breaks + 1 long break
- **Task** — A unit of work assigned to one or more Pomodoros
- **Session** — A logged record of a completed or interrupted Pomodoro

## Development Principles

1. **Offline-first** — all features must work without a network connection.
2. **Keyboard-first** — every action must be reachable via keyboard shortcut.
3. **Accessible** — WCAG 2.1 AA minimum; screen-reader compatible.
4. **Privacy-by-default** — no telemetry, no external data transmission.
5. **Test as you build** — unit tests are written alongside implementation, not after.
6. **Small commits** — each commit represents one logical change.

## Key Constraints

- No backend server — this is a fully client-side application.
- No paid external APIs.
- Target bundle size < 200 KB gzipped.
- First Contentful Paint < 1.5 s on a mid-range device.
- Support: Chrome 120+, Firefox 120+, Safari 17+, Edge 120+.

## Memory System

| File | Purpose |
|---|---|
| `memory/MEMORY.md` | Index of all memory files |
| `memory/project_overview.md` | High-level project goals and scope |
| `memory/tech_stack.md` | Technology choices and rationale |
| `memory/architecture.md` | Architecture patterns and key decisions |
| `memory/user_preferences.md` | Developer workflow and style preferences |
| `memory/feedback_history.md` | What worked, what didn't across iterations |

## Quick Reference — Prompt Library

| Scenario | Prompt File |
|---|---|
| Build a new feature | `prompts/feature_prompts/` |
| Review code quality | `prompts/review_prompts/code_review.md` |
| Investigate a bug | `prompts/debug_prompts/bug_investigation.md` |
| Refactor a component | `prompts/refactor_prompts/component_refactor.md` |
| Security audit | `prompts/review_prompts/security_review.md` |

## Git Workflow with Claude Code

**Claude does NOT branch, commit, or push automatically.** You must do this yourself, or explicitly ask Claude to do it after reviewing changes.

### Before every task (your responsibility)

```bash
git checkout main && git pull
git checkout -b feature/<task-name>          # new branch per task
git add . && git commit -m "chore: checkpoint before <task>"  # safety net
```

### After Claude finishes

```bash
git diff                 # review exactly what Claude changed
npm run lint && npm test # verify nothing broke

# If OK → commit
git add src/ tests/
git commit -m "feat(timer): <what was done>"

# If broken → revert everything
git checkout .           # discard all uncommitted changes
git clean -fd            # remove new files Claude created
# or if you have a checkpoint commit:
git reset --hard HEAD
```

### Asking Claude to commit

Once you've reviewed changes and they're good:
> "Commit these changes with message: feat(timer): add drift correction"

Claude will stage relevant files and commit — but will NOT push unless you say so.

See `rules/git_conventions.md` for full revert scenarios and branch naming.

## Workflow

```
Idea → docs/requirements/ → plans/ → tasks/ → git checkout -b → prompts/ → src/ → tests/ → commit → tasks/completed/
```

Each stage gates the next. Do not write source code without an entry in `tasks/in_progress/` **and** a feature branch checked out.
