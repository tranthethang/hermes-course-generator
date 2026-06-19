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
for agent in ".gemini/config" ".agents" ".claude"; do
    if [ -f "$HOME/$agent/skills/hermes-course-generator/SKILL.md" ]; then
        echo "[OK] Skill registered for: $agent"
    else
        echo "[WARN] Skill NOT registered for: $agent"
    fi
done
if [ $FAILED -eq 0 ]; then
    echo "Verification PASSED! Everything is set up correctly."
else
    echo "Verification FAILED!"
    exit 1
fi
