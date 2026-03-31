#!/bin/bash
# Wrapper: resolves venv Python from config.json and invokes protect_sensitive_files.py.
# Called by Claude Code PreToolUse hook. Passes stdin through to the Python script.

SCRIPT_DIR="$CLAUDE_PROJECT_DIR/.claude/hooks"
CONFIG="$CLAUDE_PROJECT_DIR/config.json"

# Extract venv_name from config.json using system Python (stdlib only)
VENV_NAME=$(python3 -c "import json; print(json.load(open('$CONFIG'))['venv_name'])" 2>/dev/null \
         || python  -c "import json; print(json.load(open('$CONFIG'))['venv_name'])" 2>/dev/null)

if [ -z "$VENV_NAME" ]; then
    echo "Hook error: could not read venv_name from config.json" >&2
    exit 1
fi

# Resolve venv Python (Windows: Scripts/python, Mac/Linux: bin/python)
VENV_PYTHON="$CLAUDE_PROJECT_DIR/$VENV_NAME/Scripts/python"
if [ ! -f "$VENV_PYTHON" ] && [ ! -f "${VENV_PYTHON}.exe" ]; then
    VENV_PYTHON="$CLAUDE_PROJECT_DIR/$VENV_NAME/bin/python"
fi

exec "$VENV_PYTHON" "$SCRIPT_DIR/protect_sensitive_files.py"
