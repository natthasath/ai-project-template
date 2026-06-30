#!/usr/bin/env bash
# ใช้หลัง clone template — reset git history แล้วเตรียมพร้อมสำหรับโปรเจคใหม่

set -e

echo "🗂️  Resetting git history from template..."
rm -rf .git
git init
git add .
git commit -m "chore: init from template"

echo ""
echo "✅ Done! เปิด Claude Code แล้วรัน:"
echo ""
echo '   /init "<project-name>" "<brief description>"'
echo ""
echo "ตัวอย่าง:"
echo '   /init "my-app" "E-commerce platform for Thai SMEs"'
