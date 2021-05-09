Monit
======
[website](https://mmonit.com/monit/)

[configuration examples](https://mmonit.com/wiki/Monit/ConfigurationExamples)

## Setup Notes

You'll need to ensure that the standard mailutils are installed on the server. 

```
apt-get install postfix mailutils
```

Afterwards, modify the `/etc/monit/monitrc` file by uncommenting the following lines to enable emailed notifications

```
set mailserver localhost  #Use localhost for email delivery.

set mail-format {
      from: monit@$HOST
   subject: monit alert --  $EVENT $SERVICE
   message: $EVENT Service $SERVICE
                 Date:        $DATE
                 Action:      $ACTION
                 Host:        $HOST
                 Description: $DESCRIPTION
}

set alert derekz@example.org #Alert recipient
```

If you want to store notifications for dispatch, you'll need to enable the notifications queue.

```
set eventqueue
	basedir /var/lib/monit/events # notifications store
	slots 100                     # limit the queue size
```

I don't need to be informed when the instance state has changed or reloaded, so I silence those alerts by uncommenting this `instance` filter

```
## Do not alert when Monit starts, stops or performs a user initiated action.
 set alert derekz@example.org not on {instance}
```

Make sure to comment out any include file directories at the end of `/etc/monit/monitrc`. If a path is in the configuration file, but the file does not exist, monit will fail to start.

## Commands

##### Monit Daemon
```bash
monit
monit reload
monit status
monit quit
```

##### Test Configuration
```bash
monit -t
```

##### Controlling Monitors
```
monit unmonitor all
monit monitor all
```

## Alerts

##### Alert if new MARC files are added or removed from a directory
```bash
check directory marcfiles with path /home/admin/marc/
      if changed timestamp then alert
```
##### Alert if registered users file has not been updated in the past 24 hours 
```bash
check directory registeredusers with path /home/admin/users
      if timestamp > 24 hour then alert
```
##### Call home every 500 cycles
```bash
check file testalert with path /.nonexistent
    alert derek@example.com with reminder on 500 cycles
```
##### Alert on low disk space

```bash    
check filesystem rootfs with path /
    if space usage > 90% then alert
```    
##### Monitor System Load
```bash
check system example.com
    if loadavg (1min) > 4 then alert
    if loadavg (5min) > 2 then alert
    if memory usage > 75% then alert
    if swap usage > 25% then alert
    if cpu usage (user) > 70% for 2 cycles then alert
    if cpu usage (system) > 30% for 2 cycles then alert
    if cpu usage (wait) > 20% for 2 cycles then alert
```
##### Double check the automated Let's Encrypt SSL renewal process
```bash
check host mmonit.com with address mmonit.com
      if failed
         port 443
         with protocol https
         and certificate valid > 30 days
         use ssl options {verify: enable}
      then alert
```
##### Restart EZproxy, if service halts
```bash
check process ezproxy with pidfile /var/run/ezproxy.pid
      restart program  = "/usr/local/ezproxy/ezproxy restart"
      if failed port 80 protocol http for 2 cycles then restart
```
##### Alert on Apache Timeouts
```bash
check file apache-error with path /var/log/apache2/error.log
    if match "^timed out" then alert
```
##### Process patrons when a new file is uploaded
```bash
check directory patrons with path /home/admin/patrons/
      if changed timestamp then exec "/home/admin/scripts/process-patrons.py"
```

