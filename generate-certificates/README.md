# OpenSSL Certificate Creation Guide

This guide shows how to create a self-signed certificate with `digitalSignature` as key usage and `codeSigning` as extended key usage using OpenSSL.

## 1. Generate a Private Key

Run the following command to generate a private key using the RSA algorithm.

```bash
openssl genpkey -algorithm RSA -out private.key
```

## 2. Prepare Configuration File

Create a new file named `openssl.cnf` with the content below. This configuration file specifies the details of the certificate request.

```bash
cat > openssl.cnf << "EOF"
[ req ]
default_bits        = 2048
default_keyfile     = private.key
distinguished_name  = req_distinguished_name
req_extensions     = req_ext

[ req_distinguished_name ]
countryName                 = Country Name (2 letter code)
countryName_default         = US
stateOrProvinceName         = State or Province Name (full name)
stateOrProvinceName_default = Washington 
localityName                = Locality Name (eg, city)
localityName_default        = Seattle
organizationName            = My Organization (eg, company)
organizationName_default    = My Company
commonName                  = Common Name (eg, YOUR name)
commonName_max              = 64

[ req_ext ]
keyUsage=critical,digitalSignature
extendedKeyUsage=critical,codeSigning
EOF
```

## 3. Generate a Certificate Signing Request

Run the following command to generate a Certificate Signing Request (CSR) based on the private key and the configuration file.

```bash
openssl req -new -key private.key -out certificate.csr -config openssl.cnf
```

## 4. Generate a Self-Signed Certificate

Run the following command to generate a self-signed certificate from the CSR, the private key, and the configuration file.

```bash
openssl x509 -req -days 365 -in certificate.csr -signkey private.key -out certificate.crt -extensions req_ext -extfile openssl.cnf
```

## 5. Output the Details of the Certificate

Run the following command to output the details of the certificate.

```bash
openssl x509 -in certificate.crt -text -noout
```

Please replace the distinguished_name placeholders in the `openssl.cnf` file with your actual information.
