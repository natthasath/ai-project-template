# UI Wireframes (Text Description) — Pomodoro Application

## Page: Timer (Primary)

```
┌─────────────────────────────────────────────┐
│  🍅 Pomodoro         [Analytics] [Settings]  │ ← Navigation
├─────────────────────────────────────────────┤
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │         WORK  •  Short  •  Long     │   │ ← Phase tabs
│  └─────────────────────────────────────┘   │
│                                             │
│              ┌──────────────┐               │
│              │   ◯ 25:00   │               │ ← Circular progress ring
│              │  (progress)  │               │   - accent color for work
│              └──────────────┘               │   - green for short break
│                                             │   - blue for long break
│         [  START  ]  [ Reset ]              │ ← Primary CTA
│                                             │
│  ──────────────────────────────────────    │
│  Today: ◉◉◉◎◎◎◎◎  (3/8 Pomodoros)         │ ← Daily progress dots
│                                             │
├─────────────────────────────────────────────┤
│  Current Task                               │ ← Task section
│  ┌─────────────────────────────────────┐   │
│  │ ▶ Write report introduction   [2/4] │   │ ← Active task
│  └─────────────────────────────────────┘   │
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │ ○ Review pull requests         [0/2] │   │
│  │ ○ Fix notification bug          [1/3] │   │
│  │ + Add a task...                      │   │ ← Input field
│  └─────────────────────────────────────┘   │
└─────────────────────────────────────────────┘
```

## Page: Analytics

```
┌─────────────────────────────────────────────┐
│  ← Timer    Analytics         [Settings]    │
├─────────────────────────────────────────────┤
│  [ This Week ] [ This Month ] [ All Time ]  │ ← Time range tabs
│                                             │
│  Total Focus   Pomodoros    Best Day        │
│  12h 30m       30           Wednesday (8)  │ ← Summary stats
│                                             │
│  Pomodoros per day                          │
│  ┌───────────────────────────────────────┐ │
│  │  8 │    ████                          │ │
│  │  6 │  ████████                ████   │ │ ← Bar chart
│  │  4 │  ████████  ████  ████  ████████  │ │
│  │  2 │  ████████  ████  ████  ████████  │ │
│  │  0 └────────────────────────────────  │ │
│  │     Mon  Tue  Wed  Thu  Fri  Sat  Sun  │ │
│  └───────────────────────────────────────┘ │
│                                             │
│  Top Tasks                                  │
│  ┌───────────────────────────────────────┐ │
│  │ Write report    ████████████ 12       │ │
│  │ Code review     ██████ 6              │ │ ← Horizontal bars
│  │ Email           ████ 4                │ │
│  └───────────────────────────────────────┘ │
└─────────────────────────────────────────────┘
```

## Page: Settings

```
┌─────────────────────────────────────────────┐
│  ← Timer    Settings                        │
├─────────────────────────────────────────────┤
│                                             │
│  ▼ Timer                                   │ ← Collapsible section
│  ┌───────────────────────────────────────┐ │
│  │ Work duration          [25] minutes   │ │
│  │ Short break            [ 5] minutes   │ │
│  │ Long break             [15] minutes   │ │
│  │ Long break every       [ 4] Pomodoros │ │
│  │ Auto-start breaks      ○──  OFF       │ │
│  │ Auto-start work        ○──  OFF       │ │
│  └───────────────────────────────────────┘ │
│                                             │
│  ▶ Notifications                           │ ← Collapsed
│  ▶ Appearance                              │ ← Collapsed
│                                             │
│  [Reset to Defaults]        [Save Changes] │
└─────────────────────────────────────────────┘
```

## Component: Timer Ring (SVG)

```
         ╭──────────────────╮
        ╱    ░░░░░░░░░░░     ╲    ← Background ring (muted)
       │   ░░░░░░░░░░░░░░░    │
       │  ░░░░░░░░░░░░░░░░░   │
       │  ░░░░░  25:00  ░░░   │   ← Timer display (center)
       │  ░░░░░  WORK   ░░░   │   ← Phase label
       │   ░░░░░░░░░░░░░░░    │
        ╲    ░░░░░░░░░░░     ╱    ← Progress ring (accent color)
         ╰──────────────────╯
```

- Progress ring fills clockwise from top
- Color: accent (work), green (short break), blue (long break)
- Inner text: countdown + phase name
- Ring thickness: 8px stroke

## Mobile Layout (< 640px)

- Timer widget: full width, centered, larger font
- Task list: below timer, scrollable
- Navigation: bottom tabs (Timer | Analytics | Settings)
- All elements maintain minimum 44px touch targets
