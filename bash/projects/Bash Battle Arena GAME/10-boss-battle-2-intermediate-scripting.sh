#!/bin/bash

source_dir="Arena_Boss"
target_dir="Victory_Archive"
search_word="Victory"

if [ ! -d "$source_dir" ]; then
    mkdir "$source_dir"
fi

for i in $(seq -w 1 5); do 
    file="$source_dir/file${i}.txt"
    num_lines=$((RANDOM % 11 + 10))
    
    for ii in $(seq 1 $num_lines); do
        echo "Line $ii: $(date +%s%N | head -c 20)" >> "$file"
    done
    ### test case
    # echo "$search_word" >> "$source_dir/file3.txt"
done

find "$source_dir" -type f -exec ls -l {} + | sort -k 5 -n

if [ ! -d "$target_dir" ]; then
    mkdir "$target_dir"
fi

for file in "$source_dir"/*.txt; do
    if grep -q "$search_word" "$file"; then
        mv "$file" "$target_dir/"
        echo "$file moved to $target_dir"
    else
        echo "$search_word does not exist in $file"
    fi
done

# ### Grant executable permissions
# chmod +x ./10-Solution.sh 

### Test Case #1:
# ./10-Solution.sh
# -rw-r--r--  1 sohailsajid  staff  201 Sep 16 17:50 Arena_Boss/file5.txt
# -rw-r--r--  1 sohailsajid  staff  222 Sep 16 17:50 Arena_Boss/file1.txt
# -rw-r--r--  1 sohailsajid  staff  348 Sep 16 17:50 Arena_Boss/file4.txt
# -rw-r--r--  1 sohailsajid  staff  369 Sep 16 17:50 Arena_Boss/file2.txt
# -rw-r--r--  1 sohailsajid  staff  411 Sep 16 17:50 Arena_Boss/file3.txt
# Victory does not exist in Arena_Boss/file1.txt
# Victory does not exist in Arena_Boss/file2.txt
# Victory does not exist in Arena_Boss/file3.txt
# Victory does not exist in Arena_Boss/file4.txt
# Victory does not exist in Arena_Boss/file5.txt

### Test Case #2:
# ./10-Solution.sh
# -rw-r--r--@ 1 sohailsajid  staff  507 Sep 16 17:55 Arena_Boss/file5.txt
# -rw-r--r--@ 1 sohailsajid  staff  549 Sep 16 17:55 Arena_Boss/file1.txt
# -rw-r--r--  1 sohailsajid  staff  612 Sep 16 17:55 Arena_Boss/file4.txt
# -rw-r--r--  1 sohailsajid  staff  675 Sep 16 17:55 Arena_Boss/file2.txt
# -rw-r--r--  1 sohailsajid  staff  757 Sep 16 17:55 Arena_Boss/file3.txt
# Victory does not exist in Arena_Boss/file1.txt
# Victory does not exist in Arena_Boss/file2.txt
# Arena_Boss/file3.txt moved to Victory_Archive
# Victory does not exist in Arena_Boss/file4.txt
# Victory does not exist in Arena_Boss/file5.txt

# cd Victory_Archive
# ls
# file3.txt