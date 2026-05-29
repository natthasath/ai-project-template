---
description: กฎ security — input validation, XSS prevention, CSP
paths:
  - src/**
---

# Security Rules

## Input Validation

```typescript
// ✅ Validate และ sanitize ทุก user input ที่ system boundary

function validateTaskTitle(input: string): string {
  const stripped = input.replace(/<[^>]*>/g, '')  // strip HTML tags
  if (stripped.trim().length === 0) throw new ValidationError('Title is required')
  if (stripped.length > 200) throw new ValidationError('Title must be under 200 chars')
  return stripped.trim()
}

function validateDuration(minutes: number, min: number, max: number): number {
  if (!Number.isInteger(minutes)) throw new ValidationError('Must be a whole number')
  if (minutes < min || minutes > max) throw new ValidationError(`Must be ${min}–${max}`)
  return minutes
}
```

## XSS Prevention

```typescript
// ✅ React escape ให้อัตโนมัติผ่าน {} interpolation — ปลอดภัยโดย default
<p>{userTitle}</p>

// ❌ ห้ามเด็ดขาด dangerouslySetInnerHTML กับ user input
<p dangerouslySetInnerHTML={{ __html: userTitle }} />

// ✅ ถ้าต้องการ render HTML ใช้ DOMPurify
import DOMPurify from 'dompurify'
<p dangerouslySetInnerHTML={{ __html: DOMPurify.sanitize(userNotes) }} />
```

## Data Import Security

```typescript
// ✅ Validate JSON structure ก่อน write ลง IndexedDB
function validateImportedData(data: unknown): data is ExportedData {
  if (typeof data !== 'object' || data === null) return false
  if (!Array.isArray((data as any).sessions)) return false
  if (!Array.isArray((data as any).tasks)) return false
  return true
}
```

## Storage Security

- ❌ ห้ามเก็บ sensitive data ใน localStorage เป็น plain text
- ❌ ห้ามเก็บ credentials, tokens, หรือ PII
- ✅ IndexedDB เก็บเฉพาะ productivity data (sessions, tasks, settings)
- ✅ Export files ต้องให้ user download ลงเครื่องตัวเอง ไม่ upload ไปไหน

## Content Security Policy

```html
<meta http-equiv="Content-Security-Policy"
  content="default-src 'self';
           script-src 'self' 'wasm-unsafe-eval';
           style-src 'self' 'unsafe-inline';
           img-src 'self' data: blob:;
           font-src 'self';
           connect-src 'none';
           worker-src 'self' blob:">
```

## Dependencies

- รัน `npm audit` ทุก sprint
- ไม่เพิ่ม dependency ที่มี known high/critical vulnerabilities
- ใช้ `npm ci` ไม่ใช่ `npm install` ใน CI
