#!/bin/bash

while true; do
    echo "Select option:"
    echo "1. Check disk space"
    echo "2. Show system uptime"
    echo "3. List users"
    echo "4. List all users"
    echo "5. Exit"
    read -p "Enter option [1-5]: " choice

    case $choice in
        1)
            echo "Checking disk space..."
            df -h
            ;;
        2)
            echo "System uptime:"
            uptime
            ;;
        3)
            echo "Listing users currently logged in:"
            who
            ;;
        4)
            echo "Listing all usernames on the system:"
            cut -d: -f1 /etc/passwd
            ;;
        5)
            echo "Exiting!"
            break
            ;;
        *)
            echo "Invalid option."
            ;;
    esac

    echo
    read -p "Press Enter to continue..."

done

### Grant executable permissions
# chmod +x ./14-Solution.sh 

### Test case #1:
# ./14-Solution.sh
# Select option:
# 1. Check disk space
# 2. Show system uptime
# 3. List users
# 4. List all users
# 5. Exit
# Enter option [1-5]: 

# Enter option [1-5]: 3
# Listing users currently logged in:
# sohailsajid      console      Sep 18 16:40 

### Resources
# https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script
# https://codeahoy.com/learn/introtobash/ch14/
