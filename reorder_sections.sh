#!/bin/bash
# Wrapper script to scan, fix missing metadata, and reorder sidebar positions.

if [ -z "$1" ]; then
    echo "Usage: ./reorder_sections.sh <workspace_path> [level] [mode]"
    echo "  - workspace_path: Absolute path to the course workspace (e.g. /path/to/course/output)"
    echo "  - level: Optional. begin, advance, master, or all (default)"
    echo "  - mode: Optional. flat (default: 1..N) or nested (1..6 per lesson)"
    exit 1
fi

WORKSPACE_PATH="$1"
LEVEL="${2:-all}"
MODE="${3:-flat}"

echo "Running reorder and metadata auto-fix on workspace: $WORKSPACE_PATH (level: $LEVEL, mode: $MODE)..."
hermes-course-generator reorder --path "$WORKSPACE_PATH" --level "$LEVEL" --mode "$MODE"
exit $?
