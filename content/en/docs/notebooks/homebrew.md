---
title: "Homebrew"
description: >
    MacOS Package Manager
---

1. Get it!

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## COMMAND CHEAT SHEET

#### Globals
- `brew update`	update packages
- `brew list --versions`	show installed packages
- `brew cask list --versions`	show installed casks
- `brew doctor` check system for potential problems
- `brew help` print help info

#### Packages
- `brew install hugo`	install package
- `brew uninstall hugo`	uninstall package
- `brew cask install atom`	install cask atom
- `brew upgrade hugo`	upgrade a package
- `brew switch hugo 0.5.3` switch package to specific version
- `brew info hugo`	list versions, caveats
- `brew cleanup hugo`	remove old versions
- `brew edit hugo`	edit formula
- `brew cat hugo`	print formula
- `brew home hugo`	open project homepage
- `brew pin hugo` prevent the specified formulae from being upgraded
- `brew unpin hugo` unpin package and allow upgrades

#### Repos
- `brew search hugo` search repos based on the substring text.
- `brew tap myrepo/myapp` tap a personal repo with my own brew formula

#### Services
- `brew services start postgresql` start service
- `brew services restart postgresql` restart service
- `brew services stop postgresql` stop service
- `brew services list` list service statuses

#### Hugo - Install Specific Version
1. Review commit logs and identify the commit for the version of Hugo you want to install
- https://github.com/Homebrew/homebrew-core/commits/master/Formula/hugo.rb

2. Add the commit to the shell script below and execute.
```bash
#!/usr/local/bin/bash

FORMULA=hugo
COMMIT=############
RAW_PATH=https://raw.githubusercontent.com/Homebrew/homebrew-core

brew unlink ${FORMULA} && \
brew install ${RAW_PATH}/${COMMIT}/Formula/${FORMULA}.rb
```
