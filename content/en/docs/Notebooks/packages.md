
## Intro

#### What is a Package?

An archive file format containing source code, executable files, and metadata used by a package manager.

#### What is a Package Manager?

A tool to manage installed applications, automatically compute dependencies, and figure out what things should occur to install packages.

## Debian-based (Debian, Ubuntu)

#### Package Format
.deb package format
.snap (single, compressed filesystem)

#### Package Manager
dpkg - can install .deb directly
apt - works with software repos

```bash
# Example - Search for a linux-image and install it.
apt search linux-image | grep linux-image-4.18.0-22-generic
apt install linux-image-4.18.0-22-generic
update-grub
reboot
```

## RedHat-based (Fedora, CentOS, Amazon Linux)

#### Package format
.rpm package format

#### Package Manager
[yum](http://yum.baseurl.org/) - works with software repos
[dnf](https://dnf.readthedocs.io/en/latest/)
