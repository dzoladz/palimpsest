---
title: "Supervisor"
description: >
    Process Control System
---

# Intro

Using [Supervisor](https://supervisord.org/) on Ubuntu systems as the primary process controller for Django applications
managed by Gunicorn as the WSGI server. A [program file](https://supervisord.org/configuration.html#programx-section) 
template (i.e., via Ansible) can be used to produce the process controller for the gunicorn process serving the 
application.

Preference is given to the APT package manager to install the Supervisor daemon, rather than Python's PIP, to link the
version of supervisor to the underlying release of the OS. Program files that initiate a controlled process can be 
placed into `/etc/supervisor/conf.d`, as long as the main supervisor configuration file in includes this directory.

A basic program file example is below:

```bash
[program:thisappname]
command=/home/thisappuser/.local/uv run gunicorn --workers 3 project.wsgi:application
process_name=%(program_name)s
directory=/var/www/html/thisappname/src
user=thisappuser
autostart=true
autorestart=true
stdout_logfile=/var/log/supervisor/thisappname.log
stderr_logfile=/var/log/supervisor/thisappname.log
numprocs=1
startretries=3
```

# Commands

There are the obvious supervisorctl commands:

* `supervisorctl start all`
* `supervisorctl stop all`
* `supervisorctl restart all`
* `supervisorctl start <process name>`

In production, there might be times when a supervisor-managed process is killed outside the supervisor management
lifecycle. It's not uncommon for a `lsof -i :8000` to be issued, followed by `kill -9 $(sudo lsof -ti :8000)` to kill
all running processes on port 8000.

If this occurs, supervisor may enter an zombie-like state until the new configuration files are read and the
dead processes are removed from the daemon's memory.

* `sudo supervisorctl reread`
* `sudo supervisorctl update`