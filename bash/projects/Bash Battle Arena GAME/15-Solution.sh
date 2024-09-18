#!/bin/bash

arena_dir="15-Level/Arena/"
backup_dir="15-Level/backup/"

get_disk_space() {
    echo "Checking disk space..."
    df -h
}

get_system_uptime() {
    echo "Showing system uptime..."
    uptime
}

backup_arena() {
    echo "Backing up $arena_dir"
    timestamp=$(date +"%Y%m%d%H%M")
    backup_file="$backup_dir/arena_backup_$timestamp.tar.gz"
    
    # create the backup
    tar -czf "$backup_file" "$arena_dir"
    
    # remove older backups, keeping only the last 3
    ls -t $backup_dir/arena_backup_*.tar.gz | tail -n +4 | xargs rm -f
}

config_parser() {
    config_file="15-Level/settings.conf"
        while IFS='=' read -r key value; do
            # remove empty lines and lines starting with '#'
            if [[ -n "$key" && "$key" != \#* ]]; then
                # trim whitespaces
                key=$(echo "$key" | xargs)
                value=$(echo "$value" | xargs)
                echo "Key: $key, Value: $value"
            fi
        done < "$config_file"
}

while true; do
    echo "Select option:"
    echo "1. Check disk space"
    echo "2. Show system uptime"
    echo "3. Backup Arena/ x3 backups"
    echo "4. Parse configuration file"
    echo "5. Exit"
    read -p "Enter option [1-5]: " choice
    
    case $choice in
        1) get_disk_space ;;
        2) get_system_uptime ;;
        3) backup_arena ;;
        4) config_parser ;;
        5) echo "Exiting script"; break ;;
        *) echo "Invalid option." ;;
    esac
    echo
    read -p "Press Enter to continue..."
done

### Grant executable permissions
# chmod +x ./15-Solution.sh 

### Test case #1:
# ./15-Solution.sh

# Select option:
# 1. Check disk space
# 2. Show system uptime
# 3. Backup Arena/ x3 backups
# 4. Parse configuration file
# 5. Exit
# # Enter option [1-5]: 3
# Backing up 15-Level/Arena/