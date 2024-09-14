# Level 12 -> 13

The password for the next level is stored in the file data.txt, which is a hexdump of a file that has been **<span style="color:red">repeatedly compressed</span>**. For this level it may be useful to create a directory under /tmp in which you can work. Use mkdir with a hard to guess directory name. Or better, use the command “mktemp -d”. Then copy the datafile using cp, and rename it using mv (read the manpages!)

[Hex dump on Wikipedia](https://en.wikipedia.org/wiki/Hex_dump)

## Solution

```
exit
```

```
ssh bandit12@bandit.labs.overthewire.org -p 2220
```

Password reminder: `7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4`

```
ll
```

```
cat data.txt
```

```
tempdir=$(mktemp -d)
```

```
cp data.txt "$tempdir"
```

```
mv "$tempdir/data.txt" "$tempdir/data.hex"
```

```
cd "$tempdir"
```

```
xxd -r data.hex data.bin
```

```
file data.bin
```

Returns: `data.bin: gzip compressed data, was "data2.bin", last modified: Wed Jul 17 15:57:06 2024, max compression, from Unix, original size modulo 2^32 577`

```
mv data.bin data.gz
```

```
gunzip data.gz
```

```
file data
```

Returns: `data: bzip2 compressed data, block size = 900k`

```
mv data data.bz2
```

```
bunzip2 data.bz2
```

```
file data
```

Returns: `data: gzip compressed data, was "data4.bin", last modified: Wed Jul 17 15:57:06 2024, max compression, from Unix, original size modulo 2^32 20480`

```
mv data data.gz
```

```
gunzip data.gz
```

```
file data
```

Returns: `data: POSIX tar archive (GNU)`

```
tar -xvf data
```

Returns: `data5.bin`

```
file data5.bin
```

Returns: `data5.bin: POSIX tar archive (GNU)`

```
tar -xvf data5.bin
```

Returns: `data6.bin`

```
file data6.bin
```

Returns: `data6.bin: bzip2 compressed data, block size = 900k`

```
mv data6.bin data6.bz2
```

```
bunzip2 data6.bz2
```

```
ll
```

```
tar -xvf data6
```

Returns: `data8.bin`

```
file data8.bin
```

Returns: `data8.bin: gzip compressed data, was "data9.bin", last modified: Wed Jul 17 15:57:06 2024, max compression, from Unix, original size modulo 2^32 49`

```
mv data8.bin data8.gz
```

```
gunzip data8.gz
```

```
file data8
```

Returns: `data8: ASCII text`

```
cat data8
```

Returns: `The password is FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn` 🥳
