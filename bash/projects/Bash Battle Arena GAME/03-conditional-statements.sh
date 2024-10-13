#!/bin/bash

if test -e ./Arena/hero.txt; then
    echo "Hero found!"
else
    echo "Hero missing!"
fi

# The `test` command evaluates a conditional expression - refer to the [man page](https://linuxcommand.org/lc3_man_pages/testh.html)

# File operators include:

# `-a FILE/PATH` True if file exists.<br>
# `-e FILE/PATH` True if file exists.<br>
# `-f FILE/PATH` True if file exists and is a regular file.<br>

# Terminal Output

# ❯ /bin/bash "/Users/sohailsajid/Desktop/find_hero.sh"
# Hero missing!