---
title: "EZproxy"
description: >
    Useful snippets for administering EZproxy
---

A snippet of fragments useful for administering EZproxy

## Reject connections that originate from IPs outside of Ohio region.

Region codes should be specified using the two-character [ISO 3166-2 subcountry code for the US](https://geolite.maxmind.com/download/geoip/misc/region_codes.csv).

GeoLite data must also be configured on EZproxy (see the [Location](https://help.oclc.org/Library_Management/EZproxy/Configure_resources/Location) section of the EZproxy manual).

```bash
::Common
Set access = "deny";
If Region() eq "OH"; Set access = "allow"
If access eq "deny"; Deny irefused.htm
/Common
```

Regex for use in the main authentication block. Deny all access, unless the location contains OH, IA, OR MI in the string.

```bash
Set access = "deny";
If Region() =~ "/.*(OH|IA|MI).*/"; Set access = "allow"
If access eq "deny"; Deny irefused.htm
```

The above should be placed before any `IfRefused; Deny irefused.htm` or `IfExpired; Deny iexpired.htm` directives in the main authentication block.

It's also possible to restrict authentication to US-based IPs, using the `IfCountry` function. `IfCountry` used the two-letter [ISO 3166 Country Codes](https://dev.maxmind.com/geoip/legacy/codes/iso3166/).

```bash
Set access = "deny";
IfCountry US; Set access = "allow"
If access eq "deny"; Deny irefused.htm
```

__NOTE__: The above snippet of code needs to be placed __within__ the authentication block to be actively restriction authentication attempts that originate from a non-US country code.

## Supply Resource Credentials within an iFrame
There are times when you might need to Find/Replace username and password values within an `<iframe>` element The example below is a working draft of two auto-triggered functions to input credentials into the proper form fields.
```bash
Find </iframe>
Replace </iframe><script>(function() { setTimeout(function() {window.frames[0].document.getElementById('username').value = "USERNAME";}, 1000); })();(function() { setTimeout(function() {window.frames[0].document.getElementById('password').value = "PASSWORD";}, 1000); })();</script>
```

## Regex Validation of SAML Attributes in the Auth: Namespace
SAML authorization check, within `shibuser.txt`, against the `userid` attribute released to EZproxy
> Authorize `userid`, if it begins with  1, 3, or 5. Otherwise, record `userid` and deny with `itype.htm`
```bash
If !(auth:userid =~ "/^(1|3|5).+$/"); Audit -expr auth:userid; Deny itype.htm; Stop
```

## Grab Username, When EZproxy Login with Email Address
This function uses an onclick event hook, i.e. `<input onclick="processUsername()" type="submit" value="Sign in">`
```bash
function processUsername() {
  var email = document.getElementsByName('user')[0].value;
  var username = email.split('@')[0];
	document.getElementsByName('user')[0].value = username;
	console.log('the username value submitted is: ' + document.getElementsByName('user')[0].value);
}
```

## Auto-trigger attribute replacement via EZproxy Find/Replace 
```bash
(function() {
        var url = document.getElementById('ctl00_BodyContent_ucShare_txtTitleURL').value;
        var fixed_url = url.replace('fod.infobase.com', 'fod-infobase-com');
        document.getElementById('ctl00_BodyContent_ucShare_txtTitleURL').setAttribute('value', fixed_url);
})();
```

## OhioLINK EJC - Proxy Rave URLs through EZproxy
This is an example Find/Replace directive which adds jQuery to the OhioLINK Electronic Journal Center's UI to rewrite article permalinks by prepending a proxy prefix to any RAVE URLs on the item details interface.

```bash
Find </body>
Replace <script type="text/javascript">$(document).ready(function() {if (window.location.href.indexOf("bw.opal-libraries.org") > -1) {$('a[href*="rave.ohiolink.edu"]').each(function() {var href=$(this).prop('href');var prefix='https://login.bw.opal-libraries.org/login?url=';var result=prefix+href;$(this).attr("href", result);$(this).text(result);console.log(result);});}});</script></body>
```

## Cron Jobs for Monitoring Activity
```bash
10 0 * * * find /usr/local -name messages.txt | xargs grep -E "Unrecognized|DANGER|hosts\s36[0-9][0-9]" | mail -E -s "EZproxy Warning Messages" -a "From: root \<root@{hostname}\>" recipient@derekzoladz.com

20 0 * * * find /usr/local/ezproxy/audit/$(date --date='yesterday' "+\%Y\%m\%d").txt -type f | xargs grep -E "exceeded" | mail -E -s "EZproxy Exceeding Usage Limit" -a "From: root \<root@{hostname}\>" recipient@derekzoladz.com

30 0 * * * find /usr/local/ezproxy/audit/$(date --date='yesterday' "+\%Y\%m\%d").txt -type f -print| xargs grep -E "Login.Intruder.IP" | mail -E -s "EZproxy Login.Intruder.IP" -a "From: root \<root@{hostname}\>" recipient@derekzoladz.com

40 0 * * * find /usr/local/ezproxy/audit/$(date --date='yesterday' "+\%Y\%m\%d").txt -type f -print | xargs grep -E "Session.ReconnectBlocked" | mail -E -s "EZproxy Session.ReconnectBlocked" -a "From: root \<root@{hostname}\>" recipient@derekzoladz.com

00 8 * * 1-5 find /usr/local/ezproxy/cookies -cmin +720 -type f | mail -E -s "EZproxy Sessions Over 12 Hours" -a "From: root \<root@{hostname}\>" recipient@derekzoladz.com
```

## DOI System - Strip Parameters from DOIs
Although valid extensions of the Document Object Model, passing parameters in the doi can cause resolution issues within EZproxy sessions.
> {host}?locatt=label:secondary_bloomsburyCollections
```bash
SPUEditVar proxy_login=login?url=
SPUEdit @^(https:\/\/doi.org\/)(10.[0-9]*\/)([0-9]*)(\?locatt=label.*)$@${proxy_login}$1$2$3@ir
```

## DOI System - Force Legacy Mode
Force DOI system resolution to the platform of the primary depositor using `mode:legacy`
```bash
SPUEditVar proxy_login=login?url=
SPUEditVar legacy_mode=?locatt=mode:legacy
SPUEdit @^(https:\/\/doi.org\/)(10.[0-9]*\/)([0-9]*)(\?locatt=label.*)$@${proxy_login}$1$2$3${legacy_mode}@ir
```

## Group-based Access to /Loggedin Files

1. In `user.txt`, create the authenticated group
```bash
::group=SecretFiles+Admin.Groups
user:password
```

2. Establish a `../loggedin/` directory for the named Group from `user.txt`
```bash
./docs/loggedin/SecretFiles
```

## Issue a Manual Call to the Sierra Patron API
Given a Sierra Patron Record containing `P BARCODE[pb]=fakeuser1234`
```bash
curl --interface eth0:48 https://{sierra-server-domain}:54620/PATRONAPI/fakeuser1234/dump
```

If successful, the call will return patron data; otherwise, a failure message will be returned with additional information to diagnose the issue. For example:
```bash
<BODY>ERRNUM=2<BR>
ERRMSG=Record ID not unique<BR>
</BODY>
```

## Temp Access, III Server Migrations

Migrating from local to III-hosted Sierra involves 6-8 hours of server downtime. If EZproxy relies on the Sierra Patron API for authentication, remote database access will be unavailable during the server migration. The following snippet will present `/login.htm` to the user, but will accept credentials and grant access to _all_. Use with extreme caution.

```bash
::III
Host https://sierra.catalog.org:54620
IfRefused; Ignore
IfInvalid; Ignore
IfUnauthenticated; Stop
/III
```

## Transparent Language & SAML-based SSO
When accessing Ohio's statewide subscription to Transparent Language Online though an EZProxy instance that connects tp a SAML-based authentication server, the platform will not recognize the IP to allow people to sign up. This solution basically forces everyone to log into EZproxy, but with a RedirectSafe entry so that Transparent Language can look for your EZproxy Referer.

In `config.txt`, you'll add the following stanza above any `ExcludeIP` directives.

```text
# -------------------------------------------------------
# **All users must authenticate through ezproxy**
#
T Transparent Language Redirect
U -Refresh transparent-language https://library.transparent.com/ohio
#
T Transparent Language
U https://library.transparent.com/ohio
HJ library.transparent.com
DJ transparent.com
NeverProxy transparent.com
NeverProxy library.transparent.com
# -------------------------------------------------------

```

The contents of the HTML file placed in the `docs/limited/transparent_langauges.htm` file are as follows:

```html
<head>
  <meta name="referrer" content="always">
  <noscript>
    <META http-equiv="refresh" content="0;URL=https://library.transparent.com/ohio">
  </noscript>
  <title>Redirecting to Transparent Languages</title>
</head>
<script>window.opener = null; location.replace("https://library.transparent.com/ohio")</script>
```

The SPU for Transparent Languages becomes:
```html
https://login.{EZproxy Hostname}/limited/transparent_languages.htm
```
