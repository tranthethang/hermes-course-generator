#!/bin/bash
set -e

echo "Locating markdown and mdx files..."
# Find all .md and .mdx files in the repository (excluding hidden files/dirs and node_modules)
MD_FILES=$(find . -type f \( -name "*.md" -o -name "*.mdx" \) -not -path '*/.*' -not -path '*/node_modules/*')

if [ -z "$MD_FILES" ]; then
    echo "No markdown files found to format."
    exit 0
fi

echo "Formatting files:"
echo "$MD_FILES" | sed 's/^/ - /'
echo ""

if command -v npx &> /dev/null; then
    # Run prettier via npx with enforcement for prose wrap and line width
    npx prettier --write --parser mdx --prose-wrap always --print-width 100 $MD_FILES
    echo "Formatting complete!"
else
    echo "Error: 'npx' (Node Package Runner) is not found."
    echo "Please install Node.js/npm to use this script."
    exit 1
fi
