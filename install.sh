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
for skill in "hermes-course-setup" "hermes-course-writer" "hermes-course-reviewer"; do
    mkdir -p ~/.gemini/config/skills/"$skill"
    cp "$SRC_DIR/skills/$skill/SKILL.md" ~/.gemini/config/skills/"$skill"/SKILL.md
    mkdir -p ~/.agents/skills/"$skill"
    cp "$SRC_DIR/skills/$skill/SKILL.md" ~/.agents/skills/"$skill"/SKILL.md
    mkdir -p ~/.claude/skills/"$skill"
    cp "$SRC_DIR/skills/$skill/SKILL.md" ~/.claude/skills/"$skill"/SKILL.md
    mkdir -p ~/.hermes/skills/"$skill"
    cp "$SRC_DIR/skills/$skill/SKILL.md" ~/.hermes/skills/"$skill"/SKILL.md
done

# Cleanup temp dir if remote mode
if [ -n "$TEMP_DIR" ] && [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi

echo "Installation complete!"
echo "Please make sure ~/.local/bin is in your PATH."
