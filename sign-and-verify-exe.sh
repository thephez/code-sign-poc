#!/bin/bash

# Signs the provided binary using the provided certificate/key info

EXE_UNSIGNED="dashcore-0.12.3.2-win32-setup-unsigned.exe"
EXE_SIGNED="dashcore-0.12.3.2-win32-setup-signed.exe"
CERT_FILE="cert-files/myKeyStore.p12"

# Delete signed file if already present
if [ -f $EXE_SIGNED ] ; then
    rm $EXE_SIGNED
fi

printf '\n%s\n\n' "Sign: $EXE_UNSIGNED"
osslsigncode sign -pkcs12 $CERT_FILE -pass "" -n "My Application Name" -i "https://www.mywebsite.com" -t "http://timestamp.comodoca.com/authenticode" -in "$EXE_UNSIGNED" -out "$EXE_SIGNED"

printf '\n%s\n\n' "Verify signature for: $EXE_SIGNED"
osslsigncode verify "$EXE_SIGNED"

