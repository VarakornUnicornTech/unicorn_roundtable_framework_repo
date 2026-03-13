#!/usr/bin/env bash
# RoundTable Hook: log-file-change
# Event: PostToolUse (Write|Edit)
# Purpose: Appends file change to today's session log for audit trail.
# Always exits 0 (logging should never block work).

FILE_PATH="$1"
TODAY=$(date +%d-%m-%Y)
LOG_DIR="RoundTable"

# Skip logging for log files themselves (prevent recursion)
case "$FILE_PATH" in
  *RoundTable/*|*Team\ Chat/*|*TeamChat/*|*OverseerReport/*)
    exit 0
    ;;
esac

# Find today's RoundTable file
LOG_FILE=$(ls "$LOG_DIR"/${TODAY}_RoundTable_Vol*.md 2>/dev/null | tail -1)

if [ -z "$LOG_FILE" ]; then
  LOG_FILE=$(ls "$LOG_DIR"/${TODAY}_RoundTable.md 2>/dev/null | head -1)
fi

if [ -n "$LOG_FILE" ]; then
  echo "" >> "$LOG_FILE"
  echo "> [Hook] File modified: \`$FILE_PATH\` at $(date +%H:%M:%S)" >> "$LOG_FILE"
fi

exit 0
