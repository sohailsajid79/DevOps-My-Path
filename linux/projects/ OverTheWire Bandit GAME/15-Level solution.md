# Level 14 -> 15

The password for the next level can be retrieved by submitting the password of the current level to port 30000 on localhost.

## Solution

```
exit
```

```
ssh bandit14@bandit.labs.overthewire.org -p 2220
```

Password reminder: `MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS`

```
ll
```

```
echo "MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS" | nc localhost 30000
```

Returns: `Correct! 8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo`
