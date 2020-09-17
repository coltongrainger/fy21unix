# notes from "git concepts simplified"

source: <https://gitolite.com>

## basics

### commits are identified by SHA-1 hashes!

A commit is uniquely identified by a 160-bit hex value, the 'SHA-1 value' (or colloquially, the 'SHA'), computed from the following information:

- the SHA of the “tree” of files and directories as they exist in that commit
- the SHA of the parent commit(s)
- the commit message
- the author's and committer's name/email/timestamp

Note: secure hash algorithms deterministically map variably-size data to fixed-length hashes!

<https://en.wikipedia.org/wiki/Cryptographic_hash_function>

<https://en.wikipedia.org/wiki/Secure_Hash_Algorithms>

```
$ echo "hello" > tmp && sha1sum tmp
f572d396fae9206628714fb2ce00f72e94f2258f  tmp

$ echo "hello" > tmp2 && sha1sum tmp2
f572d396fae9206628714fb2ce00f72e94f2258f  tmp2

$ ssh colton@coltongrainger.com
$ echo "hello" > tmp && sha1sum tmp
f572d396fae9206628714fb2ce00f72e94f2258f  tmp
$ exit

$ echo "hello!" > tmp3 && sha1sum tmp3
b44f872802b6ead96c0126acb3b42d52810b1e51  tmp3
```

## refs are (all except for HEAD) pointers to SHAs! 

> In Git, these simple names are called “references” or “refs”; you can find the files that contain those SHA-1 values in the `.git/refs` directory. In the current project, this directory contains no files, but it does contain a simple structure:

```
$ find .git/refs
.git/refs
.git/refs/heads
.git/refs/tags
$ find .git/refs -type f
```

> To create a new reference that will help you remember where your latest commit is, you can technically do something as simple as this:

```
$ echo 1a410efbd13591db07496601ebc7a059dd55cfe9 > .git/refs/heads/master
```


