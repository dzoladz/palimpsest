Git
======
Version control

# Configuration
```bash
git config
git config --global user.name "derekz"
git config --global user.email derekz@derekzoladz.com

# Remember my creds for 15 minutes
git config credential.helper cache

# Store my creds in a plain-text .git-credentials file
git config --global credential.helper store
```

# Clone
```bash
# Clone a Repository and history
git clone https://github.com/dzoladz/dzoladz.git

# Clone & Rename to 'website'
git clone https://github.com/dzoladz/dzoladz.git website

# Clone a branch, <branch> <remote repo>
git clone -b collab/berick/ansible-installer-ubuntu-16.04  git://git.evergreen-ils.org/working/random.git
```

# Basics
#### Initialize Git Repository
```bash
mkdir repo_name
cd repo_name
git init
```

#### Remotes
```bash
# Add initial remote named 'origin'
git remote add origin https://github.com/dzoladz/dzoladz.git

# Rename remote 'origin' to 'upstream'
git remote rename origin upstream

# List all remotes
git remote -v

# Remote remote named 'upstream'
git remote rm upstream
```

#### Files
```bash
# List new and modified files, branch, etc...
git status

# Track file.txt
git add file.txt

# Add all untracked files to be staged for commit
git add .

# Show file differences between previous version and working version  
git diff

# Remove file.txt from staging for commit
git reset file.txt

# Remove file.txt from tracking
git rm --cached file.txt

# Undo act of commit
git reset --soft HEAD^

# Rename file.txt
git mv file.txt newfile.txt

# Commit tracked files to repo
git commit -m "COMMIT MESSAGE"

# Push files to remote repository
git push <remote_name> <branch_name>

# Incorporate changes from remote repository
git pull
```

#### Branches
```bash
# List all branches in the local repository
git branch

# Show all local and remote branches
git branch -a

# Create a branch named 'bugfix'
git branch bugfix

# Switch to branch 'bugfix'
git checkout bugfix

# Delete branch 'bugfix'
git branch -d bugfix

# Merge bugfix into master
git checkout master # local working master branch
git pull origin master # incorporate remote updates
git merge bugfix # merge changes into master
git push origin master # push to remote
```

#### Clean up a dirty pull
git stash
git pull origin master
git stash pop


#### Search Repo
```bash
# Case-insensitive search for files containing `commit`
git grep -i 'commit'

# List files in repo using file globbing
git ls-files *.py
```

#### History
```bash
# List commit history of current branch
git log

# Show commit d2b557da6450c3dc77766b86d6d7b832af6d3d6a
git show d2b557da6450c3dc77766b86d6d7b832af6d3d6a

# Show commits by specific author
git log --author=dzoladz
```

# Just for Fun
```bash
# Who has the most commits in this repo
git shortlog -s -n
```
