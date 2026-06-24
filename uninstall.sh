#!/bin/bash
echo "Uninstalling Hermes Course Generator..."
rm -rf ~/.config/hermes-course-generator
rm -f ~/.local/bin/hermes-course-generator
for skill in "hermes-course-setup" "hermes-course-writer" "hermes-course-reviewer" "hermes-course-validator" "hermes-course-generator"; do
    rm -rf ~/.gemini/config/skills/"$skill"
    rm -rf ~/.agents/skills/"$skill"
    rm -rf ~/.claude/skills/"$skill"
    rm -rf ~/.hermes/skills/"$skill"
done
echo "Uninstall complete!"
