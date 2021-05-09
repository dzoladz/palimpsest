Mailman
=======
A few commonly used mailman commands to make my life more enjoyable. Find binaries in `/usr/lib/mailman/bin`

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
