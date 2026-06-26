#!/bin/bash
echo "Verifying installation..."
FAILED=0
if [ -x "$(command -v hermes-course-generator)" ]; then
    CLI_VERSION=$(hermes-course-generator --version 2>&1)
    echo "[OK] CLI tool 'hermes-course-generator' is installed and executable."
    echo "   Version: $CLI_VERSION"
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
    for skill in "hermes-course-setup" "hermes-course-writer" "hermes-course-reviewer" "hermes-course-validator" "hermes-course-evaluator"; do
        if [ -f "$HOME/$agent/skills/$skill/SKILL.md" ]; then
            echo "[OK] Skill '$skill' registered for: $agent"
        else
            echo "[FAIL] Skill '$skill' NOT registered for: $agent"
            FAILED=1
        fi
    done
done
if [ $FAILED -eq 0 ]; then
    echo "Verification PASSED! Everything is set up correctly."
else
    echo "Verification FAILED!"
    exit 1
fi
