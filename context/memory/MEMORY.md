# Memory Index — Pomodoro Application

ไฟล์นี้เป็น index ของ AI context memory ทั้งหมด
อัปเดตทุกครั้งที่เพิ่มหรือแก้ไข memory file

> โฟลเดอร์ `memory/` นี้เป็น **project management** ที่เราสร้างเอง
> ไม่ใช่ `agent-memory/` ที่ Claude สร้างอัตโนมัติ (auto-generated อยู่ใน `.claude/agent-memory/`)

## Active Memories

- [Project Overview](project_overview.md) — เป้าหมาย ขอบเขต และ success criteria
- [Tech Stack](tech_stack.md) — การตัดสินใจเลือก technology และเหตุผล
- [Architecture](architecture.md) — FSD architecture, Zustand stores, timer drift strategy
- [User Preferences](user_preferences.md) — preference ของ developer ในการทำงาน
- [Feedback History](feedback_history.md) — สิ่งที่ได้ผล / ไม่ได้ผลจาก iterations ก่อนหน้า

## Memory Writing Rules

1. ห้ามบันทึก code patterns หรือ file paths — อ่านจาก source code โดยตรง
2. ห้ามบันทึก git history — ใช้ `git log` แทน
3. บันทึกเฉพาะสิ่งที่ไม่สามารถ derive ได้จาก codebase ปัจจุบัน
4. แปลง relative dates เป็น absolute dates เสมอ (เช่น "พรุ่งนี้" → "2026-05-29")
5. ตรวจสอบ memory ก่อน verify ว่าข้อมูลยังถูกต้องอยู่ก่อนนำไปใช้
