# Level 7 -> 8

The password for the next level is stored in the file data.txt next to the word millionth

## Solution

```
exit
```

```
ssh bandit7@bandit.labs.overthewire.org -p 2220
```

Password reminder: `morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj`

```
ll
```

```
cat data.txt | grep "millionth"
```

Returns: `millionth dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc`
