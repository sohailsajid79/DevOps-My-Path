#!/bin/bash

check_disk_usage() {
    local directory="$1"
    local threshold="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M')

    if [ ! -d "$directory" ] || [ -z "$threshold" ]; then
        echo "Both directory path and threshold (e.g. 90) are required, but have not been provided."
        return 1
    fi
    
    # du -sk Desktop | awk '{print $1}' 
    local usage=$(du -sk "$directory" | awk '{print $1}')
    
    # df -k Desktop/ | awk 'NR==2 {print $2}' (NR==2 will process only the second line)
    local total_space=$(df -k "$directory" | awk 'NR==2 {print $2}')

    local usage_percent=$((usage * 100 / total_space))

    if [ "$usage_percent" -gt "$threshold" ]; then
        local alert_message="$timestamp - Alert: Disk usage of $directory has reached $usage_percent%, which exceeds the $threshold% threshold."
        echo "$alert_message"
    else
        echo "$timestamp - Disk usage of $directory is at $usage_percent%, which is within the $threshold% threshold."
    fi
}

# Call the function to check disk usage
check_disk_usage "$1" "$2"

### Grant executable permissions
# chmod +x ./11-Solution.sh 

### Test case #1:
# ./11-Solution.sh 09-Level/ 5
# 2024-09-16 21:32 - Disk usage of 09-Level/ is at 0%, which is within the 5% threshold.

### Resources
# https://www.youtube.com/watch?v=8R5mWnwuosw&ab_channel=VirtualITLearning
# https://www.tecmint.com/check-linux-disk-usage-of-files-and-directories/
# du man page https://man7.org/linux/man-pages/man1/du.1.html
# df man page https://www.man7.org/linux/man-pages/man1/df.1.html