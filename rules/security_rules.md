# Security Rules

## Input Validation

```typescript
// ✅ Validate and sanitize ALL user input at system boundaries

// Task title — strip HTML, enforce length
function validateTaskTitle(input: string): string {
  const stripped = input.replace(/<[^>]*>/g, '')  // strip HTML tags
  if (stripped.trim().length === 0) throw new ValidationError('Title is required')
  if (stripped.length > 200) throw new ValidationError('Title must be under 200 chars')
  return stripped.trim()
}

// Numeric settings — enforce range
function validateDuration(minutes: number, min: number, max: number): number {
  if (!Number.isInteger(minutes)) throw new ValidationError('Duration must be a whole number')
  if (minutes < min || minutes > max) throw new ValidationError(`Duration must be ${min}–${max}`)
  return minutes
}
```

## XSS Prevention

```typescript
// ✅ React escapes JSX automatically — ใช้ {} interpolation ปกติ
<p>{userTitle}</p>  // safe

// ❌ NEVER use dangerouslySetInnerHTML กับ user input
<p dangerouslySetInnerHTML={{ __html: userTitle }} />  // DANGEROUS

// ✅ ถ้าต้องการ render HTML (เช่น notes with formatting) ใช้ DOMPurify
import DOMPurify from 'dompurify'
<p dangerouslySetInnerHTML={{ __html: DOMPurify.sanitize(userNotes) }} />
```

## Data Import Security

```typescript
// ✅ Validate imported JSON structure before writing to IndexedDB
function validateImportedData(data: unknown): data is ExportedData {
  if (typeof data !== 'object' || data === null) return false
  if (!Array.isArray((data as any).sessions)) return false
  if (!Array.isArray((data as any).tasks)) return false
  // validate each session/task shape
  return true
}
```

## Storage Security

- ❌ ห้ามเก็บ sensitive data ใน localStorage ใน plain text
- ❌ ห้ามเก็บ credentials, tokens, หรือ PII
- ✅ IndexedDB data เป็น productivity data เท่านั้น — ไม่มี sensitive fields
- ✅ Export files ต้องให้ user download ลงเครื่องตัวเอง (ไม่ upload ไปไหน)

## Content Security Policy

```html
<!-- index.html — CSP header สำหรับ Vite dev server และ production -->
<meta http-equiv="Content-Security-Policy"
  content="default-src 'self';
           script-src 'self' 'wasm-unsafe-eval';
           style-src 'self' 'unsafe-inline';
           img-src 'self' data: blob:;
           font-src 'self';
           connect-src 'none';
           worker-src 'self' blob:">
```

## Dependency Security

- รัน `npm audit` ทุก sprint
- ไม่เพิ่ม dependency ที่มี known high/critical vulnerabilities
- Review `package.json` ทุกครั้งที่ upgrade packages
- ใช้ `npm ci` ไม่ใช่ `npm install` ใน CI environment
