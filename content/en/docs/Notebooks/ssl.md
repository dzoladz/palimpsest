The private key used to generate a CSR needs to match the private .key file placed on the server to match the .crt file.

#### X509 File Extensions

| Extension | Description |
| :---------: | ----------- |
| .der | Binary DER encoded certificates. These files may also bear the CER or the CRT extension.|
| .pem | Extension is used for different types of X.509v3 files which contain ASCII (Base64) armored data prefixed with a “—– BEGIN …” line.|
| .crt | Used for certificates. The certificates may be encoded as binary DER or as ASCII PEM. The CER and CRT extensions are nearly synonymous.|
| .cer | Alternate form of .crt (Microsoft Convention)|
| .key | Used both for public and private keys. The keys may be encoded as binary DER or as ASCII PEM.|

Generate the necessary files

```bash
# generate the private RSA key
openssl genrsa -out some-domain-private.key 2048

# Generating the CSR
openssl req -new -key /path/to/some-domain-private.key -out /path/to/some-domain.csr

# Generate .p12 bundle, PKCS #12
openssl pkcs12 -export -out some-domain.p12 -inkey some-domain-privatekey.pem -in some-domain-cert.pem -certfile some-domain-intermediatecert.pem
```

PEM encoded certificates are not human readable.

```bash
openssl x509 -in some-domain.pem -text -noout
openssl x509 -in some-domain.cer -text -noout
openssl x509 -in some-domain.crt -text -noout
```

Viewing .der certificates
```bash
openssl x509 -in some-domain.der -inform der -text -noout
```

Check if a private key matches a certificate. If the results of the following commands match, the private key is a match to the certificate.

```bash
openssl x509 -noout -modulus -in some-domain.crt | openssl md5 
openssl rsa -noout -modulus -in some-domain.key | openssl md5
```

#### General
 
- Check Available Entropy (0 - 4096): `cat /proc/sys/kernel/random/entropy_avail`
- Watch Available Entropy: `watch -n .1 cat /proc/sys/kernel/random/entropy_avail`

Supporting low entropy states with the HAVEGE algorithm

```bash
# Ubuntu, install haveged package
apt-get install haveged

# Tuning - /etc/default/haveged
# -w sets low entropy watermark (in bits)
DAEMON_ARGS="-w 2048"

# Start Service at reboot
update-rc.d haveged defaults 00 99

# test system entropy
apt-get install rng-tools

# Run FIPS-140 tests
cat /dev/random | rngtest -c 1000
```

Ask the `urandom` device to spit out 1k of gooey randomness
```bash
head -c 1k /dev/urandom | tr -dc 'a-zA-Z0-9!@#$%^&' | fold -w 100 && printf  "\n"
```