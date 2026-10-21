#!/usr/bin/env bash

set -u

FRONTEND_URL="http://localhost:8081"
BACKEND_URL="http://localhost:5001/api/store"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/../logs"
LOG_FILE="$LOG_DIR/health-check.log"

mkdir -p "$LOG_DIR"

check_service() {
    local name="$1"
    local url="$2"

    if curl --silent --fail --max-time 5 "$url" > /dev/null; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - OK - $name is responding"
        return 0
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR - $name is not responding"
        return 1
    fi
}

overall_status=0
output_file="$(mktemp)"
trap 'rm -f "$output_file"' EXIT

{
    check_service "Frontend" "$FRONTEND_URL" || overall_status=1
    check_service "Backend API" "$BACKEND_URL" || overall_status=1

    if [[ "$overall_status" -eq 0 ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - RESULT - All services healthy"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - RESULT - One or more services failed"
    fi
} > "$output_file"

cat "$output_file" | tee -a "$LOG_FILE"

exit "$overall_status"
