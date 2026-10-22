#!/usr/bin/env bash

set -u

FRONTEND_URL="${FRONTEND_URL:-http://localhost:8081}"
BACKEND_URL="${BACKEND_URL:-http://localhost:5001/api/store}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/../logs"
LOG_FILE="${LOG_FILE:-$LOG_DIR/health-check.log}"

mkdir -p "$(dirname "$LOG_FILE")"

frontend="OK"
backend="OK"

curl --silent --fail --max-time 5 "$FRONTEND_URL" > /dev/null || frontend="FAIL"
curl --silent --fail --max-time 5 "$BACKEND_URL"  > /dev/null || backend="FAIL"

status="HEALTHY"
code=0
if [[ "$frontend" != "OK" || "$backend" != "OK" ]]; then
    status="UNHEALTHY"
    code=1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - $status - frontend=$frontend backend=$backend" | tee -a "$LOG_FILE"
exit "$code"
