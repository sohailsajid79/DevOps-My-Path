# Level 5 -> 6

The password for the next level is stored in a file somewhere under the inhere directory and has all of the following properties:

human-readable <br>
1033 bytes in size <br>
not executable <br>

## Solution

```
exit
```

```
ssh bandit5@bandit.labs.overthewire.org -p 2220
```

Password reminder: `4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw`

```
cd inhere/
```

```
find . -type f -size 1033c ! -perm /a+x
```

`./maybehere07/.file2`

```
cat ./maybehere07/.file2
```

`HWasnPhtq9AVKe0dmk45nxy20cvUa6EG`
