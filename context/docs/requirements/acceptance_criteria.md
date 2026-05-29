# Acceptance Criteria — Pomodoro Application

## Global Acceptance Criteria (All Features)

- [ ] No TypeScript errors (`tsc --noEmit` passes)
- [ ] ESLint passes with zero warnings
- [ ] All new code has unit tests (≥ 80% coverage)
- [ ] Keyboard accessible (no mouse required)
- [ ] Works in Chrome, Firefox, Safari (latest stable)
- [ ] Works offline (no network calls)

---

## Timer (Phase 1)

### AC-TIMER-01: Timer Countdown
**Given** the timer is in 'idle' state  
**When** the user presses Start  
**Then** the timer begins counting down from the configured work duration  
**And** the status changes to 'running'  
**And** the circular progress ring begins animating

### AC-TIMER-02: Timer Accuracy
**Given** the timer is running  
**When** 25 minutes have elapsed on the wall clock  
**Then** the timer should have completed with ≤ 200ms total drift  
(regardless of tab visibility changes)

### AC-TIMER-03: Cycle Completion
**Given** the user has completed 4 Pomodoros  
**When** the 4th Pomodoro timer ends  
**Then** a long break timer starts (or is offered, based on autoStart setting)  
**And** the cycle count is displayed as "Cycle 1 Complete"

### AC-TIMER-04: Background Tab
**Given** the timer is running  
**When** the user switches to another tab for 5 minutes  
**And** returns to the Pomodoro tab  
**Then** the timer shows the correct remaining time (within 200ms)

---

## Tasks (Phase 2)

### AC-TASK-01: Create Task
**Given** the user is on the Timer page  
**When** the user types a task name and presses Enter  
**Then** a new task is created and appears in the task list  
**And** the task has estimated Pomodoros = 1 (default)

### AC-TASK-02: Task Persistence
**Given** the user has 3 tasks in their list  
**When** the user closes and reopens the browser  
**Then** all 3 tasks are still visible with their correct state

### AC-TASK-03: Pomodoro Tracking
**Given** a task is set as active  
**When** a Pomodoro session completes  
**Then** the task's completed Pomodoros count increases by 1  
**And** if completedPomodoros >= estimatedPomodoros, the task status changes to 'completed'

---

## Notifications (Phase 3)

### AC-NOTIF-01: Permission Request Timing
**Given** the user opens the app for the first time  
**When** the page loads  
**Then** NO notification permission prompt should appear  
**And** the permission is only requested after the user first presses Start

### AC-NOTIF-02: Notification on Completion
**Given** notification permission is granted  
**And** the timer is running in a background tab  
**When** the timer completes  
**Then** an OS notification appears with the correct message

### AC-NOTIF-03: Graceful Degradation
**Given** notification permission is denied  
**When** the timer completes  
**Then** an in-app toast notification appears instead of an OS notification
