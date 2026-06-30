#!/usr/bin/env bash
# Run after cloning the template — resets git history and prepares a clean project

set -e

echo "🗂️  Resetting git history from template..."
rm -rf .git
git init
git add .
git commit -m "chore: init from template"

echo ""
echo "✅ Done! Open Claude Code and run:"
echo ""
echo '   /init "<project-name>" "<brief description>"'
echo ""
echo "Example:"
echo '   /init "my-app" "E-commerce platform for Thai SMEs"'
