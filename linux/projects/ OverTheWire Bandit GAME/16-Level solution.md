# Level 15 -> 16

The password for the next level can be retrieved by submitting the password of the current level to port 30001 on localhost using SSL/TLS encryption.

Helpful note: Getting “DONE”, “RENEGOTIATING” or “KEYUPDATE”? Read the “CONNECTED COMMANDS” section in the manpage.

## Solution

```
exit
```

```
ssh bandit15@bandit.labs.overthewire.org -p 2220
```

Password reminder: `8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo`

```
openssl --help
```

[openssl man](https://man.openbsd.org/openssl.1)

```
openssl s_client -connect localhost:30001
```

Manually enter password: `8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo`

Returns: `Correct! kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx`
