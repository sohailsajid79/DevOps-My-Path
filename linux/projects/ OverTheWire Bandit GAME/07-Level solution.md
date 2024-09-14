# Level 6 -> 7

The password for the next level is stored somewhere on the server and has all of the bytes in size <br>following properties:

owned by user bandit7 <br>
owned by group bandit6 <br>
33 bytes in size <br>

## Solution

```
exit
```

```
ssh bandit6@bandit.labs.overthewire.org -p 2220
```

Password reminder: `HWasnPhtq9AVKe0dmk45nxy20cvUa6EG`

```
ll
```

```
find / -type f -user bandit7 -group bandit6 -size 33c
```

The command is sufficient to find password location but since we're scanning the entire server we'll encounter permission denied errors because we don't have privlleages to read them:

`find: ‘/sys/kernel/tracing’: Permission denied` <br>
`find: ‘/sys/kernel/debug’: Permission denied` <br>
`find: ‘find: ‘/sys/fs/pstore’: Permission denied`<br>
`so on...`<br>

#### Working Command

```
find / -type f -user bandit7 -group bandit6 -size 33c 2> /dev/null
```

Returns: `/var/lib/dpkg/info/bandit7.password`

```
cat /var/lib/dpkg/info/bandit7.password
```

`morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj`
