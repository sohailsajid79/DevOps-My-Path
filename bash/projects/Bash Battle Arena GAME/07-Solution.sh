#!/bin/bash

sort_file_size(){
    local dir=$1

    if [ ! -d "$dir" ]; then
        echo 'No directory provided.'
    else
        if ls "$dir"/*.txt 1> /dev/null 2>&1; then
            ls -l "$dir"/*.txt | sort -k5 -n | awk '{print $9, $5}' 
        else
            echo "No .txt files found in the directory."
        fi
    fi
}

sort_file_size "$1"

### Grant executable permissions
# chmod +x ./07-Solution.sh

### Test Case #1:
# # ❯ ./07-Solution.sh
# No directory provided.

### Test Case #2:
# ❯ ./07-Solution.sh 07-Level
# 07-Level/03-text-case.txt 3000
# 07-Level/04-text-case.txt 14336
# 07-Level/05-text-case.txt 27648
# 07-Level/06-text-case.txt 30720
# 07-Level/02-text-case.txt 1000000
# 07-Level/01-text-case.txt 3000000


# The script sorts .txt files in a specified directory by their size and displays the sorted list. 
# It first checks if the directory is provided and exists. If not, it prints an error message. 
# Then, it checks for .txt files in the directory. If no .txt files are found, it informs the user.
# If .txt files are present, the script uses the ls -l command to list the files with detailed information,
# including file size. This output is piped to sort -k5 -n, which sorts the files numerically based on their size; found in the 5th column.
#  inally, awk '{print $9, $5}' extracts and prints the filenames along with their sizes; from smallest to largest.