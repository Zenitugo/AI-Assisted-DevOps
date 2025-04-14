#!/bin/bash

# Function to check CPU utilization
check_cpu() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo $cpu_usage
}

# Function to check memory utilization
check_memory() {
    local mem_total=$(free -m | awk '/Mem:/ {print $2}')
    local mem_used=$(free -m | awk '/Mem:/ {print $3}')
    local mem_usage=$(echo "scale=2; ($mem_used/$mem_total)*100" | bc)
    echo $mem_usage
}

# Function to check disk utilization
check_disk() {
    local disk_usage=$(df -h / | awk '/\// {print $5}' | tr -d '%')
    echo $disk_usage
}

# Main function to determine health status
check_health() {
    local explain=$1
    
    # Get utilization values
    local cpu=$(check_cpu)
    local mem=$(check_memory)
    local disk=$(check_disk)
    
    # Determine health status
    local status="healthy"
    local reasons=()
    
    if (( $(echo "$cpu > 60" | bc -l) )); then
        status="unhealthy"
        reasons+=("CPU utilization is ${cpu}% (threshold: 60%)")
    fi
    
    if (( $(echo "$mem > 60" | bc -l) )); then
        status="unhealthy"
        reasons+=("Memory utilization is ${mem}% (threshold: 60%)")
    fi
    
    if (( $(echo "$disk > 60" | bc -l) )); then
        status="unhealthy"
        reasons+=("Disk utilization is ${disk}% (threshold: 60%)")
    fi
    
    # Output results
    echo "VM Health Status: $status"
    
    if [[ "$explain" == "true" ]]; then
        if [ ${#reasons[@]} -eq 0 ]; then
            echo "All systems are within healthy thresholds:"
            echo "- CPU: ${cpu}%"
            echo "- Memory: ${mem}%"
            echo "- Disk: ${disk}%"
        else
            echo "Reasons for unhealthy status:"
            for reason in "${reasons[@]}"; do
                echo "- $reason"
            done
            
            # Also show other metrics even if they're healthy
            if (( $(echo "$cpu <= 60" | bc -l) )); then
                echo "- CPU is healthy: ${cpu}%"
            fi
            if (( $(echo "$mem <= 60" | bc -l) )); then
                echo "- Memory is healthy: ${mem}%"
            fi
            if (( $(echo "$disk <= 60" | bc -l) )); then
                echo "- Disk is healthy: ${disk}%"
            fi
        fi
    fi
}

# Check if explain argument is provided
explain="false"
if [[ "$1" == "explain" ]]; then
    explain="true"
fi

# Run health check
check_health "$explain"