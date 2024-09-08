#!/bin/bash

dir="Battlefield"
files_to_create=("knight.txt" "sorcerer.txt" "rogue.txt")
dest_dir="Archive"

if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    
    for file in "${files_to_create[@]}"; do
    touch "$dir/$file"
    done
fi

if [ -f "$dir/knight.txt" ]; then
    # echo "knight.txt exists in the Battlefield directory"
    if [ ! -d dest_dir ]; then 
        mkdir "$dest_dir"
    fi
    mv "$dir/knight.txt" "$dest_dir"
    echo "knight.txt file has been successfully moved to the $dest_dir directory."
fi

# List the contents of both directories.
for entry in "$dir"/* "$dest_dir"/*
do
  echo "$entry"
done

# The solution checks if the "Battlefield" directory exists. If not, it creates the directory and three text files (knight.txt, sorcerer.txt, and rogue.txt).
# If knight.txt exists in the "Battlefield" directory, we check if the "Archive" directory exists. If not, it creates it.
# The knight.txt file is then moved to the "Archive" directory.
# The script loops through both the "Battlefield" and "Archive" directories, printing out the names of the files they contain.

# Terminal Output

# ❯ /bin/bash "/Users/sohailsajid/Desktop/corderco-devops/bash/projects/Bash Battle Arena GAME/05-Solution.sh"
# knight.txt file has been successfully moved to the Archive directory.
# Battlefield/rogue.txt
# Battlefield/sorcerer.txt
# Archive/knight.txt