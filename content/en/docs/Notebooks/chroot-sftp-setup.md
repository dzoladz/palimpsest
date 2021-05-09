Setup Chroot SFTP (No SSH)
==========================

**Scenario**: Callimachus works at Miskatonic University. Callimachus is working on a project that requires the placement of data files onto a remote server owned by Permissible Data Corp. (PDC). PDC will be processing the files with an automated script and returning them to Callimachus. 

You'll need some users that will only be able to perform chrooted SFTP. You'll probably want to place them into a group for simplfied administration. 

```bash
#create SFTP only group
groupadd sftponly
```

Since we'll be using this SFTP user group to allow some of our libraries to upload files for automated processing, we'll call the SFTP directory `/incoming`, to identify the functional role of the directory in the automated processing chain. 

```bash
# create user miskatonic, assign to STFP group, and disable SSH access 
useradd -g sftponly -d /incoming -s /sbin/nologin miskatonic 
```

Set up the password for user miskatonic

```bash
passwd miskatonic
```

Confirm that you've set up this user properly

```bash
grep miskatonic /etc/passwd
# miskatonic:x:500:500::/incoming:/sbin/nologin
```

### Modify SSH Configuration

Setting up the chroot jail environment will require the directory path be created to act as the SFTP user's home directory, a number of modifications to the SSH configuration, and some permissions adjustments.  

Let's start with some SSH configuration changes. You'll also need to enable the internal-sftp server. To do so, you'll need to modify the configuration for SSH.

```bash
nano /etc/ssh/sshd_config
```

Comment out the default SFTP server and add the internal SFTP to the SSH daemon config file.

```bash
#Subsystem	sftp	/usr/libexec/openssh/sftp-server
Subsystem	sftp	internal-sftp
```

You'll want to place any users that are assigned to group sftponly into the chrooted jail. You might also want to enable passwordless SFTP access with SSH keys. To make this happen, add a matchpoint to the SSH configuration file and then define the directives for the group. 

```bash
Match Group sftponly
		ChrootDirectory /sftp/%u #%u indicates the user
		AuthorizedKeysFile /sftp/%u/.ssh/authorized_keys # SFTP-only user's public key
		ForceCommand internal-sftp
```

You'll also want to ensure that key-based logins are enabled in the SSH configuration. Find the following lines in ```/etc/ssh/sshd_config``` and make sure they are present and uncomments.

```bash
Pubkey Authentication yes
RSAAuthentication yes
```

### Create Supporting Directory Structure

Create the substitute ```/home``` directory for your SFTP-only users.

```bash
mkdir /sftp
```

Establish the SFTP-only user directory in the new path. This will become the root ```/``` for the SFTP-only users. 

```bash
mkdir /sftp/miskatonic
```

Since we want our SFTP-only users to see the ```/incoming``` directoy when they ```cd```, we'll need to create it. This will be the location that they place any uploaded files to be processed by the automated script.

```bash
mkdir /sftp/miskatonic/incoming
```

Set up the proper permission on the newly created directory for the SFTP-only user

```bash
chown miskatonic:sftponly /sftp/miskatonic/incoming

# root should continue to own /sftp/miskatonic and /sftp
```

Set up the ```/.ssh``` to hold the public keys that will be granted access to an SFTP-only user's pseudo-home directory.

```bash
cd /sftp/miskatonic/
mkdir .ssh
cd /sftp/miskatonic/.ssh
nano authorized_keys # add the public keys to file and save
```

Set proper permissions for key-based SSH logins

```bash
chown -R miskatonic:miskatonic /sftp/miskatonic/.ssh
chmod 700 /sftp/miskatonic/.ssh
chmod 600 /sftp/miskatonic/.ssh/authorized_keys
```

Restart SSH to pull in the changes

```bash
service sshd restart
```

### Test the configuration

These are steps that need to be taken on the client. You'll need to generate a key-pair for the key-based SSH authentication. Most likely, you'll want to place the sftp-only key into your user's ```/.ssh/``` directory.

```bash
cd /home/callimachus/.ssh
ssh-keygen -t rsa -b 4096 # Increase bits to 4096 (brute force hardening)

# You can change the name of the keypair to identify its role or function. 
# Keep an eye for 'Your public key has been saved in /home/callimachus/.ssh/FILENAME.pub'
```

You'll need to copy FILENAME.pub to the remote server's /sftp/miskatonic/.ssh/authorized_keys file.

```bash

```

Test the connection to the SFTP-only directory from your client. 

```bash
# if using key-based SSH login

sftp -i /path/to/private-key.pem miskatonic@IPADDRESS 
```

```bash
# If not using key-based SSH login:

sftp miskatonic@IPADDRESS
# miskatonic@IPADDRESS password:

sftp> pwd
# Remote working directory: /incoming
```




