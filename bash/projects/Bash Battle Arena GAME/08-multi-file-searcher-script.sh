#!/bin/bash

search_logs(){
    local dir="$1"
    local search_term="$2"

    if [ ! -d "$dir" ]; then
        echo 'No directory provided.'
        exit
    fi

    if [ -z "$search_term" ]; then
        echo 'No word or phrase provided.'
        exit 
    fi

    # test
    # terminal: find 08-Level -name "*.log" -exec grep -l "CPU usage is at 90%." {} + 2> /dev/null
    # output: 08-Level/4-text-case.log

    find_file=$(find "$dir" -name "*.log" -exec grep -l "$search_term" {} + 2> /dev/null)
    
    if [ -z "$find_file" ]; then
        echo "No log files contain the word or phrase you've provided"
    else
        echo "$find_file"
    fi
}

search_logs "$1" "$2"

# The solution accepts two input parameters: a directory path and a search word or phrase.
# It first validates if the directory exists and checks if a search term is provided. If either is missing, an appropriate error message is displayed.
# If both inputs are valid, the script uses the find command in combination with grep to search through .log files for the specified term.
# The find command uses {} and + to handle file paths, allowing grep to process multiple files at once for efficiency. The 2> /dev/null part suppresses error messages, like "Permission denied," to keep the output clean.
# The script then outputs the names of the files containing the search term. If no matches are found, it displays a message indicating that no .log files contain the term.

### Grant executable permissions
# chmod +x ./08-Solution.sh

### Test Case #1: No Directory
# ./08-Solution.sh
# No directory provided.

### Test Case #2: No Phrase
# ./08-Solution.sh 08-Level
# No word or phrase provided.

### Test Case #3: Phrase
# ./08-Solution.sh 08-Level "CPU usage is at 90%."
# 08-Level/4-text-case.log

### Test Case #4: Single Number
# ./08-Solution.sh 08-Level "95%"
# 08-Level/5-text-case.log

### Test Case #5: Single Word
# ./08-Solution.sh 08-Level "zebra"
# No log files contain the word or phrase you've provided

### Man Pages:
# find - https://man7.org/linux/man-pages/man1/find.1.html
# test - https://www.man7.org/linux/man-pages/man1/test.1.html
# grep - https://man7.org/linux/man-pages/man1/grep.1.html