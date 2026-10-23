#!/usr/bin/env bash

set -u

PROJECT_DIR="/home/dejijo/zuri-market--capstone/zuri-market-platform"
EVIDENCE_LOG="$PROJECT_DIR/logs/cron-evidence.log"
SCRIPT="$PROJECT_DIR/scripts/health-check.sh"

mkdir -p "$PROJECT_DIR/logs"

"$SCRIPT"
result=$?

if [ "$result" -eq 0 ]; then
    status="PASS"
else
    status="FAIL"
fi

printf '%s - status=%s - exit_code=%s\n' \
    "$(date '+%Y-%m-%d %H:%M:%S %Z')" \
    "$status" "$result" | tee -a "$EVIDENCE_LOG"

exit "$result"
