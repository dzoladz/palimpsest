Expanding Volumes - Ubuntu
=======================

At some point, you're going to run out of space and need to provision some additional storage. 

Steps:

- Expand Volume Capacity
- Expand Partition to Volume Capacity
- Extend Filesystem to the size of partition

You'll need to know a few things like:

##### What block devices are available?

```bash
lsblk
```

##### What filesystem am I using on a partition?
```bash
file -s /dev/sda1
lsblk -f
blkid
```

##### What is the current capacity of storage in the filesystem?
```bash
df -h
```

##### Grow the first partition to the size of the volume
```bash
growpart /dev/sda 1
```

##### Resize the filesystem to the size of the partition
*command specific to filesystem used, this for ext*

```bash
resize2fs /dev/sda1
```

##### List disk usage -s summarize of a user
```bash
du -hs /home/marcload
```

