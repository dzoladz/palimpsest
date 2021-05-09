#!/usr/local/bin/bash
echo "Which domain to search (e.g. ohionet.org)?"
read domain_name

declare -A dns_servers
dns_servers["Google_DNS"]="8.8.8.8"
dns_servers["OpenDNS"]="208.67.222.222"
dns_servers["Cloudflare"]="1.1.1.1"
dns_servers["Quad9"]="9.9.9.9"
dns_servers["AT&T"]="68.94.156.1"
dns_servers["Verisign"]="64.6.64.6"
dns_servers["Dyn"]="216.146.35.35"
dns_servers["CenturyLink"]="209.244.0.3"
dns_servers["Level3"]="4.2.2.1"

for x in "${!dns_servers[@]}";
do
  sleep 1
  echo ""
  echo "TESTING ==> $x"
  echo ""
  dig @${dns_servers[$x]} +short NS $domain_name;
done
