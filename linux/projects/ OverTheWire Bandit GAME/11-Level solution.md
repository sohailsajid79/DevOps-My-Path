# Level 10 -> 11

The password for the next level is stored in the file data.txt, which contains base64 encoded data

## Solution

```
exit
```

```
ssh bandit10@bandit.labs.overthewire.org -p 2220
```

Password reminder: `FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey`

```
ll
```

```
base64 -d data.txt
```

Returns: `The password is dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr`
