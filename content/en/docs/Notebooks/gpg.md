GPG key - Verified Git Commits
==============================

1. Get `gpg` command
```bash
brew install gnupg
```

2. Generate GPG key
```bash
gpg --full-generate-key
```

3. List GPG keys for `derek@derekzoladz.com`
```bash
gpg --list-secret-keys --keyid-format LONG derek@derekzoladz.com
```

4. Copy the GPG key ID that starts with `sec`. In the following example,
   `488652B776349D07`:
```bash
sec   rsa4096/488652B776349D07 2019-12-14 [SC]
      8AAF3B17369BFB6A36171FFA76349D07488652B7
uid                 [ultimate] Derek Zoladz (None) <derek@derekzoladz.com>
ssb   rsa4096/8A3A7957EECFC9AA 2019-12-14 [E]
```

5. Export the public key of that ID
```bash
gpg --armor --export 488652B776349D07
```

6. Copy the public GPG key and it to both GitLab and GitHub accounts

7. Tell Git to use your GPG key to sign commits
```bash
git config --global user.signingkey 488652B776349D07
 ```

8. Tell Git to sign your commits automatically, to avoid using the `-S` flag with every
commit
```bash
git config --global commit.gpgsign true
```

9. Export GPG key
```bash
# temporary
export GPG_TTY=$(tty)
```
-or-
```bash
# add to .bashrc or .zshrc to load at each session
GPG_TTY=$(tty)
export GPG_TTY
```
