#!/bin/bash

# Function to calculate CPU utilization
get_cpu_utilization() {
  # Calculate CPU usage from /proc/stat
  cpu_idle_before=$(grep 'cpu ' /proc/stat | awk '{print $5}')
  cpu_total_before=$(grep 'cpu ' /proc/stat | awk '{print $2+$3+$4+$5+$6+$7+$8}')
  sleep 1
  cpu_idle_after=$(grep 'cpu ' /proc/stat | awk '{print $5}')
  cpu_total_after=$(grep 'cpu ' /proc/stat | awk '{print $2+$3+$4+$5+$6+$7+$8}')
  
  cpu_idle=$((cpu_idle_after - cpu_idle_before))
  cpu_total=$((cpu_total_after - cpu_total_before))
  
  cpu_util=$((100 * (cpu_total - cpu_idle) / cpu_total))
  echo $cpu_util
}

# Function to calculate memory utilization
get_memory_utilization() {
  mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
  mem_available=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
  
  mem_used=$((mem_total - mem_available))
  mem_util=$((100 * mem_used / mem_total))
  echo $mem_util
}

# Function to calculate disk utilization on root partition
get_disk_utilization() {
  disk_util=$(df / | grep / | awk '{print $5}' | sed 's/%//')
  echo $disk_util
}

# Main health check logic
cpu_util=$(get_cpu_utilization)
mem_util=$(get_memory_utilization)
disk_util=$(get_disk_utilization)

status="Healthy"
reason=""

if [[ $cpu_util -gt 60 || $mem_util -gt 60 || $disk_util -gt 60 ]]; then
  status="Non-Healthy"
fi

if [[ $1 == "--explain" ]]; then
  reason+="CPU Utilization: $cpu_util% | Memory Utilization: $mem_util% | Disk Utilization: $disk_util%"
fi

# Output health status
echo "VM Health Status: $status"
if [[ $1 == "--explain" ]]; then
  echo "Explanation: $reason"
fi



#!/bin/bash

# Function to get CPU utilization
get_cpu_usage() {
    cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
    cpu_usage=$(echo "100 - $cpu_idle" | bc)
    echo "${cpu_usage%.*}"  # Remove decimal places
}

# Function to get memory utilization
get_memory_usage() {
    free | grep Mem | awk '{print int(($3/$2) * 100)}'
}

# Function to get disk utilization
get_disk_usage() {
    df -h / | awk 'NR==2 {print int($5)}'
}

# Get all metrics
cpu_usage=$(get_cpu_usage)
memory_usage=$(get_memory_usage)
disk_usage=$(get_disk_usage)

# Initialize health status
health_status="healthy"
reasons=()

# Check each metric against 60% threshold
if [ "$cpu_usage" -gt 60 ]; then
    health_status="non-healthy"
    reasons+=("CPU usage is ${cpu_usage}%")
fi

if [ "$memory_usage" -gt 60 ]; then
    health_status="non-healthy"
    reasons+=("Memory usage is ${memory_usage}%")
fi

if [ "$disk_usage" -gt 60 ]; then
    health_status="non-healthy"
    reasons+=("Disk usage is ${disk_usage}%")
fi

# Print results
echo "VM Health Status: $health_status"

# If explain argument is provided, show detailed information
if [ "$1" = "explain" ]; then
    echo -e "\nCurrent Usage Statistics:"
    echo "CPU Usage: ${cpu_usage}%"
    echo "Memory Usage: ${memory_usage}%"
    echo "Disk Usage: ${disk_usage}%"
    
    if [ "$health_status" = "non-healthy" ]; then
        echo -e "\nReasons for non-healthy status:"
        for reason in "${reasons[@]}"; do
            echo "- $reason"
        done
    fi
fi
