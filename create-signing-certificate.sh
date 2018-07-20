#!/bin/bash

# Creates a certificate and exports PKCS12 file for use in signing tool

# File locations
CERT_DIR="cert-files"
KEY_FILE="$CERT_DIR/myKey.pem"
CERT_FILE="$CERT_DIR/myCert.pem"
PKCS_FILE="$CERT_DIR/myKeyStore.p12"

# Certificate fields
COUNTRY=AU
STATE="My State"
LOCALE="My Locality"
ORG="My Org"
ORG_UNIT="My org unit"
CN="thephez.com"
EMAIL="devnull@thephez.com"

mkdir -p $CERT_DIR

# Create certificate
openssl req -x509 -newkey rsa:4096 -keyout $KEY_FILE -out $CERT_FILE -days 365 -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALE/O=$ORG/OU=$ORG_UNIT/CN=$CN/emailAddress=$EMAIL" -nodes

# Export to PKCS12 (with no password) for osslsigncode use
openssl pkcs12 -export -out $PKCS_FILE -inkey $KEY_FILE -in $CERT_FILE -passout pass:
