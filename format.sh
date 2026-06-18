#!/bin/bash
set -e

echo "🔍 Locating markdown files..."
# Find all .md files in the repository (excluding hidden files/dirs)
MD_FILES=$(find . -type f -name "*.md" -not -path '*/.*')

if [ -z "$MD_FILES" ]; then
    echo "No markdown files found to format."
    exit 0
fi

echo "Formatting files:"
echo "$MD_FILES" | sed 's/^/ - /'
echo ""

if command -v npx &> /dev/null; then
    # Run prettier via npx
    npx prettier --write $MD_FILES
    echo "✅ Formatting complete!"
else
    echo "❌ Error: 'npx' (Node Package Runner) is not found."
    echo "Please install Node.js/npm to use this script."
    exit 1
fi
