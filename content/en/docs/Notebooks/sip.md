SIP SERVER - EVERGREEN
======================
- [NISO SIP](https://www.niso.org/standards-committees/sip)
- [3M SIP2 Protocol](http://multimedia.3m.com/mws/media/355361O/sip2-protocol.pdf)
- [pysip2-client](https://github.com/berick/pysip2)

##### Connect
```bash
telnet cool-cat.org 6001
```

##### Format to pass credentials
```bash
9300CN<username>|CO<password>|CP<institutionid>
9300CNdz1|CO<password>|CPCOOL
```
*connection responses*

- 941 # success
- 940 # failed

##### Patron information request
```bash
6300320170218          201700    AO<institutionid>|AA<patronbarcode>
```