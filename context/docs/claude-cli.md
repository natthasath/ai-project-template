# Claude CLI — คู่มืออ้างอิงภาษาไทย

> อ้างอิงจาก official docs: https://code.claude.com/docs/en/commands
>
> **[Skill]** = bundled skill (prompt ที่ส่งให้ Claude)
> **[Workflow]** = bundled dynamic workflow (fan-out หลาย subagents)
> `<arg>` = required, `[arg]` = optional

---

## เริ่มต้น Session (CLI flags)

```bash
claude                          # เปิด interactive session
claude "prompt ทันที"           # ส่ง prompt แล้วเข้า session
claude --continue               # ต่อจาก session ล่าสุด
claude --resume                 # เลือก session เก่าจาก list
claude --print "prompt"         # ตอบแล้วออก (non-interactive)
claude -p "prompt"              # ย่อของ --print
claude --debug                  # เปิด debug logging ตั้งแต่เริ่ม
```

---

## Slash Commands — จัดกลุ่มตามการใช้งาน

### Session แรกใน Repo

| คำสั่ง | ประเภท | ทำอะไร |
|---|---|---|
| `/init` | built-in | สร้าง `CLAUDE.md` starter จาก codebase ปัจจุบัน (ตั้ง `CLAUDE_CODE_NEW_INIT=1` สำหรับ interactive flow ครบชุด) |
| `/memory` | built-in | แก้ไข `CLAUDE.md` memory files, เปิด/ปิด auto-memory, ดู auto-memory entries |
| `/mcp` | built-in | จัดการ MCP server connections และ OAuth |
| `/agents` | built-in | จัดการ agent configurations |
| `/permissions` | built-in | ตั้งกฎ allow/ask/deny สำหรับ tools (alias: `/allowed-tools`) |
| `/fewer-permission-prompts` | [Skill] | scan transcripts แล้วเพิ่ม allowlist ใน `settings.json` เพื่อลด prompts |

---

### ระหว่างทำงาน (Context & Conversation)

| คำสั่ง | ประเภท | ทำอะไร |
|---|---|---|
| `/plan [description]` | built-in | เข้า plan mode ก่อนเริ่ม task ใหญ่ |
| `/compact [instructions]` | built-in | สรุป conversation ให้สั้นลง ประหยัด context window |
| `/context [all]` | built-in | แสดง context usage แบบ colored grid พร้อม optimization suggestions |
| `/btw <question>` | built-in | ถาม side question โดยไม่เพิ่มเข้า conversation history |
| `/clear [name]` | built-in | เริ่ม conversation ใหม่ (session เก่าเข้า `/resume` ได้) (alias: `/reset`, `/new`) |
| `/rewind` | built-in | ย้อน conversation และ/หรือ code กลับไปจุดก่อนหน้า (alias: `/checkpoint`, `/undo`) |
| `/recap` | built-in | สรุป session ปัจจุบันเป็น one-liner |
| `/export [filename]` | built-in | export conversation เป็น plain text |
| `/copy [N]` | built-in | copy response ล่าสุดไป clipboard (ใส่ N เพื่อเลือก response ย้อนหลัง) |

---

### Model & Performance

| คำสั่ง | ประเภท | ทำอะไร |
|---|---|---|
| `/model [model]` | built-in | เปลี่ยน model และบันทึกเป็น default (กด `s` เพื่อเปลี่ยนเฉพาะ session นี้) |
| `/effort [level\|auto]` | built-in | ตั้ง effort level: `low`, `medium`, `high`, `xhigh`, `max`, `ultracode` |
| `/fast [on\|off]` | built-in | toggle Fast mode (Opus ที่ output เร็วขึ้น) |

**Effort levels อธิบาย:**
- `low` — เร็ว ประหยัด ใช้กับ task ง่ายๆ
- `medium` — default สมดุล
- `high` / `xhigh` — reasoning เพิ่มขึ้น
- `max` — สูงสุด (เฉพาะ session นี้)
- `ultracode` — `xhigh` reasoning + auto workflow orchestration

---

### Code Tools

| คำสั่ง | ประเภท | ทำอะไร |
|---|---|---|
| `/code-review [level] [--fix] [--comment] [target]` | [Skill] | review diff สำหรับ correctness bugs และ cleanups; `--fix` apply fixes, `--comment` post เป็น GitHub PR comments, `ultra` = multi-agent cloud review |
| `/simplify [target]` | [Skill] | review cleanup-only (ไม่หา bugs) แล้ว apply fixes อัตโนมัติ (4 agents parallel) |
| `/security-review` | built-in | วิเคราะห์ pending changes บน branch ปัจจุบันสำหรับ security vulnerabilities |
| `/review [PR]` | built-in | review pull request ใน session ปัจจุบัน |
| `/diff` | built-in | interactive diff viewer — uncommitted changes + per-turn diffs |
| `/debug [description]` | [Skill] | เปิด debug logging และ troubleshoot โดยอ่าน session debug log |
| `/run` | [Skill] | launch project's app และ drive มันเพื่อ verify change ทำงานจริง (v2.1.145+) |
| `/verify` | [Skill] | build + run app แล้ว observe result แทนที่จะรัน tests อย่างเดียว (v2.1.145+) |
| `/run-skill-generator` | [Skill] | สอน `/run` และ `/verify` วิธี build/launch project นี้ (v2.1.145+) |

**ระดับ code-review:**
`low` → `medium` → `high` → `xhigh` → `max` → `ultra` (cloud)

---

### Parallel Work (Agents & Background)

| คำสั่ง | ประเภท | ทำอะไร |
|---|---|---|
| `/agents` | built-in | จัดการ subagent configurations |
| `/tasks` | built-in | list และจัดการ background tasks (alias: `/bashes`) |
| `/background [prompt]` | built-in | detach session ให้รันเป็น background agent (alias: `/bg`) |
| `/batch <instruction>` | [Skill] | orchestrate large-scale changes — แยกงานเป็น 5-30 units แล้วรัน parallel ใน worktrees |
| `/stop` | built-in | หยุด background session ปัจจุบัน (เฉพาะตอน attach อยู่) |
| `/workflows` | built-in | ดู progress ของ workflows ที่กำลังรัน — watch, pause, resume, save |
| `/deep-research <question>` | [Workflow] | fan-out web searches → fetch sources → synthesize cited report |

**ตัวอย่าง `/batch`:**
```bash
/batch migrate src/ from JavaScript to TypeScript
/batch add JSDoc to all public functions in src/shared/
```

---

### Session Management

| คำสั่ง | ประเภท | ทำอะไร |
|---|---|---|
| `/resume [session]` | built-in | ต่อ conversation เก่าจาก ID หรือ name (alias: `/continue`) |
| `/branch [name]` | built-in | fork conversation ณ จุดนี้ ของเดิมยังอยู่ (alias: `/fork`) |
| `/rename [name]` | built-in | ตั้งชื่อ session ปัจจุบัน (ไม่ใส่ชื่อ = auto-generate) |
| `/goal [condition\|clear]` | built-in | ตั้ง goal — Claude ทำซ้ำจนกว่าจะสำเร็จ |
| `/loop [interval] [prompt]` | [Skill] | รัน prompt ซ้ำๆ ตาม interval (ไม่ใส่ interval = Claude self-paces) (alias: `/proactive`) |
| `/add-dir <path>` | built-in | เพิ่ม working directory เข้า session |

**ตัวอย่าง `/goal`:**
```bash
/goal all tests in src/features/timer pass and tsc --noEmit is clean
/goal              # ดู status (turns used, evaluator reason)
/goal clear        # หยุด goal (alias: stop, off, reset, none, cancel)
```

---

### Project & Team

| คำสั่ง | ประเภท | ทำอะไร |
|---|---|---|
| `/skills` | built-in | list skills ที่มี (กด `t` sort by token count, `Space` hide/show) |
| `/reload-skills` | built-in | re-scan skills ที่เพิ่ม/แก้ใน session นี้โดยไม่ restart (v2.1.152+) |
| `/hooks` | built-in | ดู hook configurations สำหรับ tool events |
| `/autofix-pr [prompt]` | built-in | spawn cloud session ที่ watch PR แล้ว push fixes เมื่อ CI fail (ต้องการ `gh` CLI) |
| `/install-github-app` | built-in | ติดตั้ง Claude GitHub Actions app สำหรับ repo |
| `/team-onboarding` | built-in | generate onboarding guide จาก session history 30 วันที่ผ่านมา |
| `/ultraplan <prompt>` | built-in | draft plan ใน ultraplan session → review ใน browser → execute remotely |
| `/schedule [description]` | built-in | สร้าง/จัดการ routines บน Anthropic cloud (alias: `/routines`) |
| `/insights` | built-in | วิเคราะห์ session history — project areas, patterns, friction points |

---

### UI & Settings

| คำสั่ง | ประเภท | ทำอะไร |
|---|---|---|
| `/config` | built-in | เปิด Settings UI (theme, model, output style) (alias: `/settings`) |
| `/theme` | built-in | เปลี่ยน color theme (รวม auto, light/dark, daltonized, ANSI, custom) |
| `/color [color\|default]` | built-in | ตั้งสี prompt bar session นี้: `red`, `blue`, `green`, `yellow`, `purple`, `orange`, `pink`, `cyan` |
| `/tui [default\|fullscreen]` | built-in | เปลี่ยน terminal UI renderer (`fullscreen` = flicker-free alt-screen) |
| `/focus` | built-in | toggle focus view (แสดงแค่ last prompt + tool summary + response) |
| `/scroll-speed` | built-in | ปรับ mouse wheel scroll speed (fullscreen เท่านั้น) |
| `/keybindings` | built-in | เปิด keybindings config file |
| `/terminal-setup` | built-in | configure Shift+Enter shortcuts (สำหรับ VS Code, Cursor, Windsurf, Alacritty, Zed) |
| `/statusline` | built-in | configure status line ใน shell prompt |
| `/ide` | built-in | จัดการ IDE integrations |
| `/statusline` | built-in | configure Claude Code's status line |
| `/sandbox` | built-in | toggle sandbox mode |

---

### Diagnostics & Info

| คำสั่ง | ประเภท | ทำอะไร |
|---|---|---|
| `/doctor` | built-in | ตรวจสอบ Claude Code install + settings (กด `f` ให้ Claude fix issues) |
| `/status` | built-in | แสดง version, model, account, connectivity (ใช้ได้ขณะ Claude กำลังตอบ) |
| `/usage` | built-in | แสดง session cost, plan limits, activity stats (alias: `/cost`, `/stats`) |
| `/context [all]` | built-in | visualize context window usage |
| `/help` | built-in | แสดง help และ commands ทั้งหมด |
| `/release-notes` | built-in | ดู changelog แบบ interactive version picker |
| `/heapdump` | built-in | เขียน JS heap snapshot ไปที่ Desktop สำหรับ diagnose memory issues |
| `/feedback [report]` | built-in | report bug พร้อม session context (alias: `/bug`, `/share`) |
| `/powerup` | built-in | interactive lessons แนะนำ Claude Code features |

---

### Account & Plans

| คำสั่ง | ประเภท | ทำอะไร |
|---|---|---|
| `/login` | built-in | sign in Anthropic account |
| `/logout` | built-in | sign out |
| `/upgrade` | built-in | เปิดหน้า upgrade plan |
| `/usage-credits` | built-in | configure usage credits เมื่อถึง limit |
| `/privacy-settings` | built-in | ดู/อัปเดต privacy settings (Pro/Max เท่านั้น) |
| `/passes` | built-in | แชร์ free week ให้เพื่อน (ถ้า account eligible) |

---

### Remote & Cross-Device

| คำสั่ง | ประเภท | ทำอะไร |
|---|---|---|
| `/remote-control` | built-in | ทำให้ session นี้ controllable จาก claude.ai (alias: `/rc`) |
| `/teleport` | built-in | pull web session เข้า terminal นี้ (alias: `/tp`) |
| `/remote-env` | built-in | configure default remote environment สำหรับ web sessions |
| `/desktop` | built-in | ต่อ session ไปที่ Claude Code Desktop app (macOS/Windows) (alias: `/app`) |
| `/web-setup` | built-in | connect GitHub account สำหรับ Claude Code on the web |
| `/install-slack-app` | built-in | ติดตั้ง Claude Slack app |

---

### เบ็ดเตล็ด

| คำสั่ง | ทำอะไร |
|---|---|
| `/plugin` | จัดการ Claude Code plugins |
| `/reload-plugins` | reload plugins ที่แก้ไขโดยไม่ restart |
| `/claude-api [migrate\|managed-agents-onboard]` | [Skill] โหลด Claude API reference สำหรับภาษาที่ใช้ |
| `/mobile` | แสดง QR code ดาวน์โหลด Claude mobile app (alias: `/ios`, `/android`) |
| `/radio` | เปิด Claude FM lo-fi radio ใน browser |
| `/stickers` | สั่ง Claude Code stickers |
| `/exit` | ออกจาก session (alias: `/quit`) |

---

## Keyboard Shortcuts

| Shortcut | ทำอะไร |
|---|---|
| `Ctrl+C` | ยกเลิก generation ที่กำลังรัน |
| `Ctrl+D` | ออกจาก session |
| `↑` / `↓` | เลื่อนดู prompt history |
| `Tab` | autocomplete คำสั่ง |
| `Shift+Enter` | ขึ้นบรรทัดใหม่ใน prompt (multiline) |
| `Esc` | ล้าง prompt ปัจจุบัน |
| `/` | แสดง command picker (กรองได้โดยพิมพ์ต่อ) |
| `←` (ใน background session) | detach โดยไม่หยุด session |

---

## MCP Prompts

MCP servers expose prompts เป็น commands ในรูปแบบ:

```
/mcp__<server-name>__<prompt-name>
```

ดู servers ที่ active ได้จาก `/mcp`

---

## Non-interactive Mode

```bash
# ถามแล้วได้ผลลัพธ์เดียว ไม่เข้า session
claude -p "อธิบาย architecture ของโปรเจคนี้"

# pipe เข้า Claude
git diff | claude -p "สรุปเป็น commit message"

# output JSON สำหรับ parse ต่อ
claude --output-format json -p "list TypeScript errors"
claude --output-format stream-json -p "..."   # streaming version

# จำกัดจำนวน turns
claude --max-turns 5 -p "..."

# ควบคุม tools
claude --allowedTools "Read,Grep,Glob" -p "..."
claude --disallowedTools "Bash,Write" -p "..."
claude --allowedTools "Bash(npm run *)" -p "..."   # pattern matching
```

---

## ตัวอย่าง Workflow ที่ใช้บ่อย

```bash
# เริ่มงานวันใหม่
claude --continue

# ทำ feature จนกว่า tests ผ่าน (ไม่ต้องพิมพ์ซ้ำ)
/goal npm test -- --run passes with no failures and tsc --noEmit is clean

# Review ก่อน merge
/code-review high
/security-review

# Debug แบบ deep
/debug timer slows down after switching tabs

# Refactor ขนาดใหญ่แบบ parallel
/batch migrate all class components in src/ to function components

# ประหยัด context เมื่อ session ยาว
/compact focus on the timer feature changes
/context              # ดูว่า context ใช้ไปเท่าไหร่แล้ว

# ดูงานทั้งหมดในครั้งเดียว
/status
/tasks
```
