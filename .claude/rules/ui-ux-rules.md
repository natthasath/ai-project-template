---
description: Design tokens, keyboard shortcuts, accessibility, animation rules
paths:
  - src/components/**
  - src/features/**
  - src/pages/**
  - src/shared/ui/**
---

# UI/UX Rules

## Design Tokens

```
Colors:
  accent:       #e63946  (primary CTA, active states)
  surface:      #1a1a2e  (dark background)
  panel:        #16213e  (cards, modals)
  border:       #0f3460  (subtle borders)
  text:         #eaeaea  (primary text)
  muted:        #8892b0  (secondary text)

Timer Phase Colors:
  work:         #e63946  (accent)
  short-break:  #06d6a0  (green)
  long-break:   #118ab2  (blue)
```

## Spacing & Sizing

- ใช้ Tailwind spacing scale เท่านั้น (4px base unit)
- Minimum touch target: 44×44 px (WCAG 2.5.5)
- Minimum font size: 14px (0.875rem)
- Line height: 1.5 สำหรับ body text

## Keyboard Shortcuts

| Key | Action | Context |
|---|---|---|
| `Space` | Start / Pause timer | Timer page |
| `R` | Reset timer | Timer page |
| `N` | Skip to next phase | Timer page |
| `T` | Focus task input | Timer page |
| `?` | เปิด shortcuts modal | Global |
| `Escape` | ปิด modal | Global |
| `Ctrl+,` | เปิด Settings | Global |

## Responsive Breakpoints

```
sm:  640px  — single-column
md:  768px  — timer + task list side by side
lg:  1024px — full desktop layout
xl:  1280px — analytics multi-column
```

## Accessibility Requirements

```typescript
// ✅ Icon-only buttons ต้องมี aria-label
<button aria-label="Start timer"><PlayIcon /></button>

// ✅ Timer countdown ต้องมี aria-live
<div aria-live="polite" aria-atomic="true">
  {formatTime(secondsRemaining)}
</div>

// ✅ Progress bars
<div role="progressbar" aria-valuemin={0} aria-valuemax={100} aria-valuenow={progress} />

// ✅ Modals
<div role="dialog" aria-modal="true" aria-labelledby="modal-title">
  <h2 id="modal-title">Add Task</h2>
</div>
```

## Animation Rules

- Micro-interactions: 150ms
- Page transitions: 300ms
- Easing: `ease-out` สำหรับ enter, `ease-in` สำหรับ exit
- ✅ ใช้ `prefers-reduced-motion` เสมอ

```css
@media (prefers-reduced-motion: reduce) {
  * { animation-duration: 0.01ms !important; transition-duration: 0.01ms !important; }
}
```

## Error States

- Form validation: แสดง inline ใต้ field (ไม่ใช่ alert popup)
- App errors: ErrorBoundary + friendly message + retry button
- Empty states: ต้องมี CTA บอกว่าต้องทำอะไรต่อ
