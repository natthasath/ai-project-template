---
description: Persistent memory สำหรับ subagents — จัดการโดย Claude อัตโนมัติ
---

# Agent Memory

โฟลเดอร์นี้เก็บ memory ที่ subagents เขียนและอ่านระหว่าง sessions

## สิ่งสำคัญ

- **Claude จัดการให้อัตโนมัติ** — ไม่ต้องสร้างหรือแก้ไขไฟล์เองด้วยมือ
- แต่ละ agent เขียน context ที่ต้องการจำข้ามเข้าที่นี่
- ต่างจาก `context/memory/` ซึ่งเป็น project management ที่คุณเขียนเอง

## ความแตกต่างจาก context/memory/

| | `agent-memory/` | `context/memory/` |
|---|---|---|
| ใครเขียน | Claude (อัตโนมัติ) | คุณ (มือ) |
| เนื้อหา | Agent state ข้าม sessions | Project decisions, preferences |
| วัตถุประสงค์ | Subagent continuity | AI context สำหรับ future sessions |
