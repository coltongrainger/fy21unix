# git concepts simplified

## SHA-1 hashes

<https://en.wikipedia.org/wiki/Cryptographic_hash_function>

```
$ echo "hello" > tmp.txt
$ echo "hello" > tmp2.txt
$ echo "hello!" > tmp3.txt
$ sha1sum tmp.txt
f572d396fae9206628714fb2ce00f72e94f2258f  tmp.txt
$ sha1sum tmp2.txt
f572d396fae9206628714fb2ce00f72e94f2258f  tmp2.txt
$ sha1sum tmp3.txt
b44f872802b6ead96c0126acb3b42d52810b1e51  tmp3.txt
```
