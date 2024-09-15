#!/bin/bash

dir_to_monitor="$1"

if [ -z "$dir_to_monitor" ] || [ ! -d "$dir_to_monitor" ]; then
    echo "Provide a valid directory to monitor."
    exit 1
fi

echo "Monitoring $dir_to_monitor"

inotifywait -m -e create -e modify -e delete "$dir_to_monitor" |
while read path event file; do
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$timestamp - $event detected: $path$file"
done

# ### Grant executable permissions
# chmod +x ./09-Solution.sh 

### Test
# sajid@sajids:~/Desktop$ ./09-Solution.sh 09-Level/
# Monitoring 09-Level/
# Setting up watches.
# Watches established.
# 2024-09-15 22:32:11 - CREATE detected: 09-Level/.goutputstream-3Z1BU2
# 2024-09-15 22:32:11 - MODIFY detected: 09-Level/.goutputstream-3Z1BU2
# 2024-09-15 22:32:23 - CREATE detected: 09-Level/.goutputstream-RRJ6T2
# 2024-09-15 22:32:23 - MODIFY detected: 09-Level/.goutputstream-RRJ6T2

### Resources inotifywait
# https://serverfault.com/questions/1669/shell-command-to-monitor-changes-in-a-file
# https://unix.stackexchange.com/questions/283868/bash-script-detecting-change-in-files-from-a-directory
# https://unix.stackexchange.com/questions/323901/how-to-use-inotifywait-to-watch-a-directory-for-creation-of-files-of-a-specific
# inotifywait man page: https://www.man7.org/linux/man-pages/man1/inotifywait.1.html
# Prerequisites: sudo apt-get install inotify-tools



