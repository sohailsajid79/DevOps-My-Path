#!/bin/bash

source_dir="assets"
backup_dir="backups"

if [ ! -d "$backup_dir" ]; then
    mkdir "$backup_dir"
fi

timestamp=$(date +"%Y-%m-%d_%H-%M")
backup_="backup_$timestamp.tar.gz"

# creating backup
tar -czf "$backup_dir/$backup_" "$source_dir"
echo "Created backup: $backup_"

# removing older backups, keeping only the latest 5
cd "$backup_dir" || exit
ls -tp | grep -v '/$' | tail -n +6 | xargs -r rm --


# The solution uses 'ls -tp', where the -t flag sorts files by modification time, and -p adds a / to directories. When paired this with grep -v '/$', it filters out directories so that only files are selected.
# Next, tail -n +6 is used to skip the first 5 lines, so it lists just the older files to target. The xargs -r rm -- command is used to handle file deletion in one go, reducing the process overhead. The -r flag makes sure rm isn’t called if there are no files to delete.

### Grant executable permissions
# chmod +x ./13-Solution.sh 

### Test case #1:
# ./13-Solution.sh
# Created backup: backup_2024-09-18_18-00.tar.gz

### Resources
# tar man: https://www.man7.org/linux/man-pages/man1/tar.1.html
# ls man: https://man7.org/linux/man-pages/man1/ls.1.html
# grep man: https://man7.org/linux/man-pages/man1/grep.1.html
# xargs man: https://www.man7.org/linux/man-pages/man1/xargs.1.html