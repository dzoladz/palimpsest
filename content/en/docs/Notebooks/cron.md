Scheduling Tasks with Cron
==========================

`minute:hour:day-of-month:month:day-of-week /command/to/execute.sh`

| Field | Values | Notes |
| --- | --- | --- |
| Minute | 0-59 | |
| Hour | 0-23 | |
| Day of Month | 1-31 | |
| Month | 1-12 | |
| Day Of Week	 | 0-6 | [0 is Sunday]|

## Common Commands w/ Cron

```bash
crontab -l  	# List current Linux user's crontab entries

crontab -u <username> -l # List other Linux user's crontan entries

crontab -e 		# Edit crontab entries

crontab /path/to/cronjobs.txt # Load cron jobs from file
```
## Examples of Crontab Entries

##### Execute job every ten minutes
```bash
*/10 * * * * /path/to/command.sh
```

##### Run job every hour, between 8am - 5pm, Monday - Friday
```bash
00 08-17 * * 1-5 /path/to/command.sh
```

#### Run job twice a day, at noon and 6pm
```bash
00 12,18 * * * /path/to/command.sh
```

##### Run job at 4:30am on Saturday, send stderr to stdout to null device
```bash
30 5 * * 6 /home/s3backup/backup_ftpdata.sh > /dev/null 2>&1
```

##### Conditional: Execute job only on 1st Tuesday of the month
```bash
0 3 1-7 * *  if [ `date +\%a` = Tue ]; then /path/to/ami-genie.sh; fi
```

##### At 11:30 on Sunday, download the EZproxy RejectIP Blacklist from GitHub and write the file to `/usr/local/ezmanage/includes/global_reject_ip.txt`. Send an email with the download details.
```bash
30 11 * * 0 root /usr/bin/wget --output-document global_reject_ip.txt https://raw.githubusercontent.com/prbutler/EZProxy_IP_Blacklist/master/EZProxy_IP_Blacklist_RejectIP.txt -O /usr/local/ezmanage/includes/global_reject_ip.txt 2>&1 | mail -s "EZproxy: Refresh RejectIP File" -a "From: someuser \<someuser@epv1.example.org\>" anotheruser@example.org
```
