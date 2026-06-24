#!/bin/bash
# Wrapper script to verify section files in a course workspace.

if [ -z "$1" ]; then
    echo "Usage: ./verify_sections.sh <workspace_path> [level]"
    echo "  - workspace_path: Absolute path to the course workspace (e.g. /path/to/course/output)"
    echo "  - level: Optional. begin, advance, master, or all (default)"
    exit 1
fi

WORKSPACE_PATH="$1"
LEVEL="${2:-all}"

echo "Running verification on workspace: $WORKSPACE_PATH for level: $LEVEL..."
hermes-course-generator verify --path "$WORKSPACE_PATH" --level "$LEVEL"
exit $?
