# Level 8 -> 9

The password for the next level is stored in the file data.txt and is the only line of text that occurs only once

## Solution

```
exit
```

```
ssh bandit8@bandit.labs.overthewire.org -p 2220
```

Password reminder: `dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc`

```
ll
```

```
cat data.txt | sort | uniq -u
```

Returns: `4CKMh1JI91bUIZZPXDqGanal4xvAg0JM`
