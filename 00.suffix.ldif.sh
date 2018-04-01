#!/bin/sh

basedn=`cat basedn`

cat <<EOF
dn: olcDatabase={1}mdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: $basedn
-
replace: olcRootDN
olcRootDN: cn=admin,$basedn
EOF
