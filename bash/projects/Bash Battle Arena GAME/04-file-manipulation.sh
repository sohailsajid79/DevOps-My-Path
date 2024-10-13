#!/bin/bash

dir="Arena"
filetype="./Arena/*.txt"
dest_dir="Backup"

if [ -d "$source_dir" ]; then
    echo "Arena directory exists"
    
    if ls $filetype 1> /dev/null 2>&1; then
        echo ".txt files exist"
    else
        echo "No .txt files found"
    fi

    if [ ! -d "$dest_dir" ]; then
        mkdir "$dest_dir"
    fi

    cp "$source_dir"/*.txt "$dest_dir"
    echo "All .txt files copied from $source_dir to $dest_dir"
fi

# The solution checks if the Arena directory exists on our Desktop. 
# If it does, we use a wildcard expression to check if any .txt files 
# are present therein. We then check if a directory named Backup exists; 
# if not, we create it. Finally, we proceed to copy the .txt files from 
# the Arena directory to the Backup directory.