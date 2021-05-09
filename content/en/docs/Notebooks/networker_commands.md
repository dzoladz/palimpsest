# Networker Commands

## Service
Daemon is `nsrexecd`

```bash
service networker stop
service networker start
```

## Logging

Logging for previous versions of Networker configured logs to `/nsr/logs/daemon.raw`

#### Enter Administrative Shell of Networker
```bash
nsradmin -p nsrexec
```

#### Render `.log` from `.raw`

```bash
cd /nsr/logs/
nsr_render_log -mepathy daemon.raw > daemon.log
```

#### View most recent 25 entries in log
```bash
tail -n 25 daemon.log
```

#### View logging configuration
From `nsradmin` shell:
```bash
print type: NSR log
```

#### Update Runtime Loggging Location
```bash
update runtime rendered log:/nsr/logs/daemon.log
```

#### Configure master server at `/nsr/res/servers`
```bash
echo "[backup server domain]" >> /nsr/res/servers
```

## Connection Issue
Render `daemon.raw` and check latest entries.

#### Refresh Networker
1. Stop Networker service
2. Rename "res" to "res.old"
3. Rename "tmp" to "tmp.old"
4. Start Networker service
5. Move "res.old/servers" to "res/servers"

#### Fresh Install
1. Navigate to the location of the `.deb`
2. `sudo apt install ./networker_client.deb`

#### Reset Peer Information
From `nsradmin` shell

```bash
print type: nsr peer information
delete
```

## External Links
[Legato Commands](www.ipnom.com/legato-NetWorker-Commands)

[EMC NetWorker 8.2 Admin Guide](https://www.emc.com/collateral/TechnicalDocument/docu53903.pdf)
