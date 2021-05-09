## sed (stream editor)
**To perform an operation, use `sed -i`; otherwise, `sed` performs a dry-run.**  

You got 60+ logrotate configuration files in `/etc/logrotate.d` and you need to add the `delaycompress` directive, after the `compress` directive, to each of the files. The name of each configuration file that needs to be updated begins with `ezproxy_`. No problem!

```bash
sed '/compress/a\    delaycompress' ezproxy_*
```

You've got 60+ Let's Encrypt certificate `.conf` files that you need to increase
the delay for propogation of the DNS TXT file challenge. In the example below,
if a line in the configuration file contains `dns_google_propagation_seconds`,
find the value `60` and replace it with the value `90`.

```bash
sed '/dns_google_propagation_seconds/s/60/90/' *.conf
```

You need to add a temporary set of limited administrative credentials to all of
your `user.txt` files and you want to the new code after either `::limit=2` or
`::Limit=2`.

```bash
find . -iname user.txt -exec sed '/::[lL]imit=2/a ::group=+Admin.StatusUpdate+Admin.Restart \
username:password \
::group=-Admin.StatusUpdate-Admin.Restart' {} \;| less
``` 

Or, when a vendor transitions to HTTPS and you need to update 60+ EZproxy stanzas to specifically allow a new protocol.

#### Here are a few one-liners:

```
# Print All Matching Lines
sed -n '/^IncludeFile.*/p' config.txt

# Print the First Occurrence of Matching Line
sed -n '/^IncludeFile.*/ {p;q}' config.txt

# Print Last Occurrence of a Match
tac config.txt | sed -n '/^IncludeFile.*/ {p;q}'
```

## awk (columnar data processor)

Read through a directory of log files, find entries for a specific user, sort the results, print only the "interesting" data points

```bash
grep -rni "username" | sort | awk 'BEGIN {OFS="\t"}; {split($1,date,":"); print date[3], $2, $3, $4}'
```

You can also find IPs that hit the proxy server most frequently
```bash
awk '{ print $4}' $PATH_TO_LOGFILE | sort | uniq -c | sort -nr | head -n 20
```