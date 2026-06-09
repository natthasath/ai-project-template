---
argument-hint: <react-vite|python|go|laravel|node-express>
---

ตั้งค่า tech stack สำหรับ project นี้

**Presets ที่มี:**
- `react-vite` — React + TypeScript + Vite (default)
- `python` — Python + pytest + ruff + mypy
- `go` — Go + go test + golangci-lint
- `laravel` — Laravel + Pest + Pint + PHPStan
- `node-express` — Node.js + Jest + ESLint + tsc

1. ถ้าไม่มี $ARGUMENTS — แสดง presets ทั้งหมดพร้อม commands แล้วถามว่าต้องการใช้อันไหน

2. เขียน preset ที่เลือกลง `.claude/config/tech-stack.md` ตามรูปแบบนี้:

**react-vite:**
```
## Stack
React 19 + TypeScript + Vite

## Commands
| Role | Command |
|---|---|
| **typecheck** | `npm run typecheck` |
| **lint** | `npm run lint` |
| **test** | `npm test -- --run` |
| **test-watch** | `npm test` |
| **dev** | `npm run dev` |
| **build** | `npm run build` |
```

**python:**
```
## Stack
Python + pytest + ruff + mypy

## Commands
| Role | Command |
|---|---|
| **typecheck** | `mypy .` |
| **lint** | `ruff check .` |
| **test** | `pytest` |
| **test-watch** | `pytest -f` |
| **dev** | `python main.py` |
| **build** | `pip install -e .` |
```

**go:**
```
## Stack
Go

## Commands
| Role | Command |
|---|---|
| **typecheck** | `go vet ./...` |
| **lint** | `golangci-lint run` |
| **test** | `go test ./...` |
| **test-watch** | `go test ./... -v` |
| **dev** | `go run .` |
| **build** | `go build ./...` |
```

**laravel:**
```
## Stack
Laravel + PHP

## Commands
| Role | Command |
|---|---|
| **typecheck** | `./vendor/bin/phpstan analyse` |
| **lint** | `./vendor/bin/pint --test` |
| **test** | `./vendor/bin/pest` |
| **test-watch** | `./vendor/bin/pest --watch` |
| **dev** | `php artisan serve` |
| **build** | `php artisan optimize` |
```

**node-express:**
```
## Stack
Node.js + Express + TypeScript

## Commands
| Role | Command |
|---|---|
| **typecheck** | `npx tsc --noEmit` |
| **lint** | `npx eslint .` |
| **test** | `npx jest --passWithNoTests` |
| **test-watch** | `npx jest --watch` |
| **dev** | `npm run dev` |
| **build** | `npm run build` |
```

3. แจ้งว่า stack ถูกเปลี่ยนเป็นอะไร และ skills ทั้งหมดจะใช้ commands จากไฟล์นี้โดยอัตโนมัติ
