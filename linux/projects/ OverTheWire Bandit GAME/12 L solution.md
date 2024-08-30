# Level 11 -> 12

The password for the next level is stored in the file data.txt, where all lowercase (a-z) and uppercase (A-Z) letters have been rotated by 13 positions

## Solution

```
exit
```

```
ssh bandit11@bandit.labs.overthewire.org -p 2220
```

Password reminder: `dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr`

```
ll
```

```
cat data.txt
```

Returns: `Gur cnffjbeq vf 7k16JArUVv5LxVuJfsSVdbbtaHGlw9D4`

```
cat data.txt | tr `A-Za-z` `N-ZA-Mn-za-m`
```

Returns: `7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4`

`tr 'A-Za-z' 'N-ZA-Mn-za-m'` tells tr to translate all uppercase letters (A-Z) to their ROT13 counterparts (N-Z and A-M) and all lowercase letters (a-z) to their ROT13 counterparts (n-z and a-m).

### How ROT13 Works

ROT13 is a specific type of Caesar cipher where each letter is shifted by 13 positions in the alphabet. Since the alphabet has 26 letters, a 13-position shift is exactly half the alphabet, so applying ROT13 twice will return the original text.
