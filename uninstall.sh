#!/bin/bash
echo "Uninstalling Hermes Course Generator..."
rm -rf ~/.config/hermes-course-generator
rm -f ~/.local/bin/hermes-course-generator
rm -rf ~/.gemini/config/skills/hermes-course-generator
rm -rf ~/.agents/skills/hermes-course-generator
rm -rf ~/.claude/skills/hermes-course-generator
echo "Uninstall complete!"
