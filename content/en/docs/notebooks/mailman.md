---
title: "Mailman"
description: >
    A few commonly used mailman commands to make my life more enjoyable. Find binaries in `/usr/lib/mailman/bin`
---

## Mailman Operator Binaries

1. Remove an email address from all lists on the server
`remove_members --fromall --nouserack username@domain.edu`

2. Add a single user to a list 
`echo 'username@domain.edu' | add_members -r - listname`

3. List Membership
`list_members listname`

4. Export Member List for Migration
`list_members --fullnames -o membership.txt listname`
   
5. List All Mailing Lists
`list_lists`
   
6. Find a Member in All Lists
`find_member username@domain.edu`

## Migration Tasks
Mailman provides a few scripts to assist with migration tasks. Check out those scripts to see if something is already available for a specific task before using the one-liners below.

1. Move List Archives to Another Server
```bash
scp -r /path/to/list_archive user@mailman.example.org:/var/lib/mailman/archives/private/list_archive
```

2. Fix the Hostname in `*.html` Archive Files
```bash
find . -type f -name "*.html" -print0 | xargs -0 sed -e 's/list.ohionet.org/lists.ohionet.org/g'
```