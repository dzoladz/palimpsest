Tasks
=====
A collection commands for tasks that I've needed to perform multiple times.

## Convert PuTTY SSH2 Public Key to OpenSSH

```bash
ssh-keygen -if ssh2publickey.pub >> opensshpublickey.pub
```

## Identify Responding Server
```
curl -s -I sts.psychiatrist.com|sed -n 's/^S[erv]*: //p'
```

## Byte Order Mark (BOM)

When EZproxy configuration files are edited in Microsoft NotePad, EZproxy will complain - upon restart - about the single byte character `ï»¿` that begins the `config.txt` file. EZproxy expects UTF-8 encoding that does not start with a non-ASCII byte, like a BOM.

Using vim, does current file have a BOM?

```bash
:set bomb?
```

Remove BOM and write file back to disk:

```bash
:set nobomb
```

## Print the Number of Lines in a File

Because I can never remember the command I need

```bash
wc -l <file>
```

## Delete Old Kernels, Classic Version

```bash
uname -r # the kernel in use
```

```bash
dpkg -l | grep linux-image | awk '{print$2}'
```

```bash
apt remove --purge linux-image-3.1.0-131-generic
```

```bash
update-grub
```

## Convert .mov -> .mp4 With FFMPEG

```bash
ffmpeg -i Untitled.mov -vcodec h264 -acodec mp2 Untitled.mp4
```

## Convert .pdf -> .jpg with ImageMagick

```bash
# %d will iterate using 1 digit, %3d 3 digits
convert -density 150 art.pdf -quality 90 %d.jpg
``` 

## Find the Size of a Directory

```bash
du -hs /path/to/directory
```

## Locate all files with a specific name in the entire directory and search through those files for a line of text using regex, sort

```bash
find . -iname config.txt -exec grep "^[A-Za-z ]*\.ohionet\.org" {} \; -print | grep Name | sort
```

## Imagemagick, Convert to Progressive JPEG

#### entire directory
`mogrify -interlace plane *.jpg`

#### single file
`convert inputfile.jpg -interlace plane outputfile.jpg`

#### Progressive JPEG will state, Interlace: JPEG
`identify -verbose file.jpg`


## Globbing

```bash
# Minutes flag
-mmin +360

# Days flag
-mtime +7

# Include only files with an extension of 'txt'
find /sftp/plc/incoming/ -type f -name '*.txt' -print0

# Exclude any directories with a name that start with 'pl'. Include only files older than 30 hours.
find /sftp/[^pl]*/incoming/ -type f -mmin +1800  -print0

# Include directories with a specific name. Remove all matching files that are older than 30 hours.
find /sftp/[\(antioch\|findlay\|franciscan\|wilmington\)]*/incoming/ -type f -mmin +1800  -print0 | xargs -r0 rm --
```

## Tuning with Sysctl

File Location on Ubuntu

```bash
nano -w /etc/sysctl.conf
```

Count instances of SYN received

```bash
netstat -ant|grep SYN_RECV|wc -l
```

Check States
```bash
netstat -nta | egrep "State|443"
netstat -nta | egrep "State|80"
```

Check Current Value for Parameter

```bash
sysctl -n net.ipv4.tcp_syncookies
sysctl -n net.ipv4.tcp_max_syn_backlog
sysctl -n net.ipv4.tcp_synack_retries
sysctl -n net.core.somaxconn
```

Reload configuration

```bash
sysctl -p
```

## Batch Updating Files on the Server

#### Find files owned by a user

```bash
#find {path} -user {username}
find /usr/local -user derek
```

#### Find files assigned to a group

```bash
find {path} -group {username}
find /usr/local -group derek
```

#### Change Ownership or Group

```bash
#chown --from=olduser newuser * -R
chown --from=david derek * -R
chown --from=:1053 :derek * -R
```

#### Show Me the Redirects!

```bash
wget http://libguides.heidelberg.edu/asc 2>&1 | grep Location:
```
