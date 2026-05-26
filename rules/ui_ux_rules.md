# UI/UX Rules

## Design Tokens (Tailwind Config)

```
Colors:
  accent:   #e63946  (primary CTA, active states)
  surface:  #1a1a2e  (dark background)
  panel:    #16213e  (cards, modals)
  border:   #0f3460  (subtle borders)
  text:     #eaeaea  (primary text)
  muted:    #8892b0  (secondary text)

Timer Phase Colors:
  work:       accent (#e63946)
  short-break: #06d6a0  (green)
  long-break:  #118ab2  (blue)
```

## Component Spacing

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
| `?` | Open keyboard shortcuts modal | Global |
| `Escape` | Close modal / cancel action | Global |
| `Ctrl+,` | Open Settings | Global |

ทุก shortcut ต้องไม่ conflict กับ browser defaults (ยกเว้น Space บน Timer page)

## Responsive Breakpoints

```
sm:  640px  — single-column layout
md:  768px  — timer + task list side by side
lg:  1024px — full desktop layout
xl:  1280px — analytics dashboard multi-column
```

## Accessibility Requirements

```typescript
// ✅ Icon-only buttons ต้องมี aria-label
<button aria-label="Start timer">
  <PlayIcon />
</button>

// ✅ Timer countdown ต้องมี aria-live
<div aria-live="polite" aria-atomic="true" aria-label="Timer">
  {formatTime(secondsRemaining)}
</div>

// ✅ Progress indicators ต้องมี role และ aria-valuenow
<div role="progressbar" aria-valuemin={0} aria-valuemax={100} aria-valuenow={progress}>
  ...
</div>

// ✅ Modals ต้องมี role="dialog" + aria-modal + aria-labelledby
<div role="dialog" aria-modal="true" aria-labelledby="modal-title">
  <h2 id="modal-title">Add Task</h2>
  ...
</div>
```

## Animation Rules

- Duration: 150ms สำหรับ micro-interactions, 300ms สำหรับ page transitions
- Easing: `ease-out` สำหรับ enter, `ease-in` สำหรับ exit
- ✅ ใช้ `prefers-reduced-motion` media query เสมอ

```css
@media (prefers-reduced-motion: reduce) {
  * { animation-duration: 0.01ms !important; transition-duration: 0.01ms !important; }
}
```

## Error States

- Form validation errors: แสดง inline ใต้ field (ไม่ใช่ alert popup)
- App errors: ErrorBoundary + friendly message + retry button
- Empty states: ต้องมี CTA บอกว่าต้องทำอะไรต่อ (ไม่ใช่แค่ "No items")
