fail2ban
=========

- List Active Jails: `fail2ban-client status`
- Show Banned IPs in sshd Jail: `fail2ban-client status sshd`
- Manually Unban an IP from a Jail: `fail2ban-client set {jail name} unbanip {ip address}`
- Manually Ban an IP to a Jail: `fail2ban-client set {jail name} banip {ip address}`