#!/bin/bash
# Wrapper script to verify section files in a course workspace.

if [ -z "$1" ]; then
    echo "Usage: ./verify_sections.sh <workspace_path> [level] [--build]"
    echo "  - workspace_path: Absolute path to the course workspace"
    echo "  - level: Optional. begin, advance, master, or all (default)"
    echo "  - --build: Optional. Run a real Docusaurus build compiler check"
    exit 1
fi

WORKSPACE_PATH="$1"
LEVEL="all"
BUILD_FLAG=""

# Check arguments
if [ "$2" == "--build" ]; then
    BUILD_FLAG="--build"
elif [ -n "$2" ]; then
    LEVEL="$2"
    if [ "$3" == "--build" ]; then
        BUILD_FLAG="--build"
    fi
fi

echo "Running verification on workspace: $WORKSPACE_PATH for level: $LEVEL..."
if [ -n "$BUILD_FLAG" ]; then
    hermes-course-generator verify --path "$WORKSPACE_PATH" --level "$LEVEL" --build
else
    hermes-course-generator verify --path "$WORKSPACE_PATH" --level "$LEVEL"
fi
exit $?
