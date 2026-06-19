#!/bin/bash
set -e

# Detect mode
# When piped through curl | bash, SCRIPT_DIR might not point to local files.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"
TEMP_DIR=""

if [ -f "$SCRIPT_DIR/bin/hermes-course-generator" ] && [ -d "$SCRIPT_DIR/templates" ]; then
    echo "Installer running in Local Mode..."
    SRC_DIR="$SCRIPT_DIR"
else
    echo "Installer running in Remote Mode..."
    TEMP_DIR=$(mktemp -d)
    
    echo "Downloading release archive..."
    if command -v curl >/dev/null 2>&1; then
        curl -fsSL -o "$TEMP_DIR/hermes-course-generator.tar.gz" "https://github.com/tranthethang/hermes-course-generator/releases/download/latest/hermes-course-generator.tar.gz"
    elif command -v wget >/dev/null 2>&1; then
        wget -q -O "$TEMP_DIR/hermes-course-generator.tar.gz" "https://github.com/tranthethang/hermes-course-generator/releases/download/latest/hermes-course-generator.tar.gz"
    else
        echo "Error: Neither curl nor wget was found. Please install one of them to proceed."
        rm -rf "$TEMP_DIR"
        exit 1
    fi

    echo "Extracting archive..."
    tar -xzf "$TEMP_DIR/hermes-course-generator.tar.gz" -C "$TEMP_DIR"
    SRC_DIR="$TEMP_DIR"
fi

echo "Installing Hermes Course Generator globally..."
mkdir -p ~/.config/hermes-course-generator/templates
cp "$SRC_DIR"/templates/* ~/.config/hermes-course-generator/templates/
mkdir -p ~/.local/bin
cp "$SRC_DIR/bin/hermes-course-generator" ~/.local/bin/hermes-course-generator
chmod +x ~/.local/bin/hermes-course-generator

# Register skills
mkdir -p ~/.gemini/config/skills/hermes-course-generator
cp "$SRC_DIR/skills/SKILL.md" ~/.gemini/config/skills/hermes-course-generator/SKILL.md
mkdir -p ~/.agents/skills/hermes-course-generator
cp "$SRC_DIR/skills/SKILL.md" ~/.agents/skills/hermes-course-generator/SKILL.md
mkdir -p ~/.claude/skills/hermes-course-generator
cp "$SRC_DIR/skills/SKILL.md" ~/.claude/skills/hermes-course-generator/SKILL.md
mkdir -p ~/.hermes/skills/hermes-course-generator
cp "$SRC_DIR/skills/SKILL.md" ~/.hermes/skills/hermes-course-generator/SKILL.md

# Cleanup temp dir if remote mode
if [ -n "$TEMP_DIR" ] && [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi

echo "Installation complete!"
echo "Please make sure ~/.local/bin is in your PATH."
