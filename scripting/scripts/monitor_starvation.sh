#!/bin/bash

# Define output log file
LOG_FILE="process_performance.log"
STARVATION_THRESHOLD=1  # CPU usage threshold in percentage to consider a process starving (e.g., 1%)

# Function to log process stats to the log file
log_process_stats() {
    echo "----- $(date) -----" >> "$LOG_FILE"
    ps -eo pid,ni,%cpu,%mem,comm --sort=-%cpu | head -n 20 >> "$LOG_FILE"
    echo "" >> "$LOG_FILE"
}

# Function to check for starvation
check_starvation() {
    echo "Checking for processes that might be starving..."
    starving_processes=$(ps -eo pid,ni,%cpu,%mem,comm --sort=-%cpu | awk -v threshold=$STARVATION_THRESHOLD '$3 < threshold {print $0}')
    
    if [ -n "$starving_processes" ]; then
        echo "Starving processes detected (CPU usage < $STARVATION_THRESHOLD%):" >> "$LOG_FILE"
        echo "$starving_processes" >> "$LOG_FILE"
    else
        echo "No starving processes detected." >> "$LOG_FILE"
    fi
    echo "" >> "$LOG_FILE"
}

# Monitor process performance every 5 seconds
while true; do
    log_process_stats
    check_starvation
    sleep 5  # Adjust the sleep time to monitor at the desired frequency
done
