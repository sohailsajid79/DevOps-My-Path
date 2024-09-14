#!/bin/bash

count_file_lines(){
    local file=$1

    if [ ! -f "$file" ]; then
        echo 'No file provided.'
    else
        line_count=$(wc -l < "$file")
        echo "'$file' has $line_count lines."
    fi
}

count_file_lines "$1"

### Grant executable permissions
# chmod +x ./script_name.sh

### Test Case #2:
# ❯ ./06-Solution.sh
# No file provided.

### Test Case #2:
# ❯ ./06-Solution.sh 06-Level.txt
# '06-Level.txt' has       18 lines.