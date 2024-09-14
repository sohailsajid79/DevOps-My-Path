# Level 13 -> 14

The password for the next level is stored in /etc/bandit_pass/bandit14 and can only be read by user bandit14. For this level, you don’t get the next password, but you get a private SSH key that can be used to log into the next level. Note: localhost is a hostname that refers to the machine you are working on

[SSH/OpenSSH/Keys](https://help.ubuntu.com/community/SSH/OpenSSH/Keys)

## Solution

```
exit
```

```
ssh bandit13@bandit.labs.overthewire.org -p 2220
```

Password reminder: `FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn`

```
ll
```

```
cat sshkey.private
```

```
ssh bandit14@localhost -i sshkey.private -p 2220
```

```
cat /etc/bandit_pass/bandit14
```

Returns: `MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS`
