Networking
==========
A section for notating useful networking commands, tasks, or related discoveries.

## Google Cloud
Installing the SDK [https://cloud.google.com/sdk/docs/](https://cloud.google.com/sdk/docs/)

#### A Few Commands for Migrating a DNS zone

```bash
gcloud auth login --project managed-dns-migration

gcloud dns managed-zones create myzone --dns-name="myzone.org" --description="Zone for all the things" --visibility=public

gcloud dns record-sets import -z=myzone --zone-file-format /path/to/zonefile/myzone.org.zonefile.txt --delete-all-existing

gcloud dns managed-zones describe myzone
```

## DNS
General DNS commands

#### dig

```bash
# Query Cloudflare primary DNS to reply with the name servers for the cool-cat.org domain
dig +short NS cool-cat.org 1.1.1.1

# Ask for the name servers every 2 seconds. Useful for monitoring propagation
watch dig +short NS cool-cat.org 1.1.1.1
```
