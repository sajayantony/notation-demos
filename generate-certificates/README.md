# Using local keys with Notation

## OpenSSL Certificate Creation Guide

### Create a Self-Signed Certificate

This guide shows how to create a self-signed certificate with `digitalSignature` as key usage and `codeSigning` as extended key usage using OpenSSL.

```bash
name="test"
openssl req -x509 -sha256 -nodes -newkey rsa:2048 \
    -keyout "$name.key" -out "$name.crt" -days 365 \
    -subj "/C=US/ST=WA/L=Seattle/O=Notary/CN=$name" \
    -addext "basicConstraints=CA:false" \
    -addext "keyUsage=critical,digitalSignature" \
    -addext "extendedKeyUsage=codeSigning"
```

### Output the Details of the Certificate

Run the following command to output the details of the certificate.

```bash
openssl x509 -in certificate.crt -text -noout
```

## Use this key with Notation

Notation does not allow using local keys by default and requires a plugin. 
For debugging we can configure notation to use this key by adding 
the following to the `~/.config/notation/signingkeys.json` file.

```json
{
    "default": "test-local",
    "keys": [
        {
            "name": "test-local",
            "keyPath": "/notation-demos/generate-certificates/test.key",
            "certPath": "/notation-demos/generate-certificates/test.crt"
        }
    ]
}
```
