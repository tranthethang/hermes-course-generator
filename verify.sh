#!/bin/bash
echo "Verifying installation..."
FAILED=0
if [ -x "$(command -v hermes-course-generator)" ]; then
    echo "[OK] CLI tool 'hermes-course-generator' is installed and executable."
else
    echo "[FAIL] CLI tool 'hermes-course-generator' is NOT in PATH or not executable."
    FAILED=1
fi
if [ -d "$HOME/.config/hermes-course-generator/templates" ]; then
    echo "[OK] Template folder exists at ~/.config/hermes-course-generator/templates."
    count=$(ls -1 "$HOME/.config/hermes-course-generator/templates" | wc -l)
    echo "   Found $count template files."
else
    echo "[FAIL] Template folder NOT found at ~/.config/hermes-course-generator/templates."
    FAILED=1
fi
for agent in ".gemini/config" ".agents" ".claude" ".hermes"; do
    for skill in "hermes-course-setup" "hermes-course-writer" "hermes-course-reviewer"; do
        if [ -f "$HOME/$agent/skills/$skill/SKILL.md" ]; then
            echo "[OK] Skill '$skill' registered for: $agent"
        else
            echo "[WARN] Skill '$skill' NOT registered for: $agent"
        fi
    done
done
if [ $FAILED -eq 0 ]; then
    echo "Verification PASSED! Everything is set up correctly."
else
    echo "Verification FAILED!"
    exit 1
fi
