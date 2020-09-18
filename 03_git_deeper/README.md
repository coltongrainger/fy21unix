# notes from "git concepts simplified"

*git concepts to understand*

- [ ] blobs
- [ ] trees
- [ ] commits
- [ ] tags

*references*

- <https://gitolite.com>
- <https://git-scm.com/book/en/v2/Git-Internals-Git-References>

## basics

### commits are identified by SHA-1 values

A commit is uniquely identified by a 160-bit hex value, the 'SHA-1 value' (or colloquially, the 'SHA'), computed from the following information:

- the SHA of the “tree” of files and directories as they exist in that commit
- the SHA of the parent commit(s)
- the commit message
- the author's and committer's name/email/timestamp

```
$ git show <commit-SHA>

commit <commit-SHA> (HEAD -> master)
Author: Colton Grainger <colton.grainger@colorado.edu>
Date:   Thu Sep 17 15:16:25 2020 -0600

    Try to checkout a commit and detach HEAD

<diff contents>
```

### secure hash algorithms deterministically map data to fixed-length hashes

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

## refs (e.g., branches, tags) are pointers to SHA-1 values

(Except for HEAD which is usually soft, but sometimes "hard" when it's detached.)

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
$ echo 1a410efbd13591db07496601ebc7a059dd55cfe9 > .git/refs/heads/test
```

But don't do that, use `git update-ref .git/refs/heads/test 1a410e`!

> When you run commands like `git branch <branch>`, Git basically runs that `update-ref` command to add the SHA-1 of the last commit of the branch you’re on into whatever new reference you want to create.
> 
> The question now is, when you run `git branch <branch>`, how does Git know the SHA-1 of the last commit? The answer is the HEAD file.
> 
> Usually the HEAD file is a symbolic reference to the branch you’re currently on. By symbolic reference, we mean that unlike a normal reference, it contains a pointer to another reference.
> 
> However in some rare cases the HEAD file may contain the SHA-1 value of a git object. This happens when you checkout a tag, commit, or remote branch, which puts your repository in "detached HEAD" state.
>
> If you look at the file, you’ll normally see something like this:

```
$ cat .git/HEAD
ref: refs/heads/master
```

But if I go like `git checkout 01b6091` (with all changes either committed or stashed) then `git log` shows the detached HEAD:

```
* 0d8a2cd (master) Try to checkout a commit and detach HEAD
* 0dff54a Delete pdfs and temp files
* 01b6091 (HEAD) Talk about SHA-1
* 9e98ea5 (origin/master) Sed example
* d7f184b Add lecture notes and set up iterative directory structure.
```

To get back, just `git checkout master`:

```
Previous HEAD position was 01b6091 Talk about SHA-1
Switched to branch 'master'
Your branch is ahead of 'origin/master' by 3 commits.
```

### a repo is a graph of commits!

> a repo is like a single linked list 
>
> every commit knows what its parent commit is

But wasn't the point of SHA-1 to make preimage attacks hard?! No, the point is to give parent's UUIDs: "When you run `git commit`, git creates the commit object, specifying the parent of that commit object to be whatever SHA-1 value the reference in HEAD points to."

> It cannot be a double linked list – this is because any change to the contents would change the SHA!

### a tag is a pointer to a commit!

> The tag object is very much like a commit object — it contains a tagger, a date, a message, and a pointer. The main difference is that a tag object generally points to a commit rather than a tree. It’s like a branch reference, but it never moves — it always points to the same commit but gives it a friendlier name.

> There are two types of tags: annotated and lightweight. You can make a lightweight tag by running something like this:

```
$ git update-ref refs/tags/v1.0 9e98ea52b1aee1a9e49f433e5d17d20812d66933
```

> That is all a lightweight tag is — a reference that never moves. An annotated tag is more complex, however. If you create an annotated tag, Git creates a tag object and then writes a reference to point to it rather than directly to the commit. You can see this by creating an annotated tag (using the -a option):

