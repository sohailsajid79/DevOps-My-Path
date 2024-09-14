# Level 9 -> 10

The password for the next level is stored in the file data.txt in one of the few human-readable strings, preceded by several ‘=’ characters.

## Solution

```
exit
```

```
ssh bandit9@bandit.labs.overthewire.org -p 2220
```

Password reminder: `4CKMh1JI91bUIZZPXDqGanal4xvAg0JM`

```
ll
```

```
cat data.txt | strings | grep ==
```

Returns:

`\a!;========== the`<br>
`========== passwordf`<br>
`========== isc`<br>
`========== FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey`<br>
