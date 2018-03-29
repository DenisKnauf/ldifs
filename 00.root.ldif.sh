#!/bin/sh -e

basedn=$(cat basedn)
_x=${basedn%%,*}
dc=${_x#*=}
pw=`pwgen 8 1`
echo "# Password for cn=root,$basedn: $pw" >&2

cat <<EOF
dn: $basedn
objectClass: top
objectClass: dcObject
objectClass: organization
dc: $dc
o: $dc
structuralObjectClass: organization

dn: cn=root,$basedn
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: root
description: LDAP administrator
userPassword:: `slappasswd -h '{CRYPT}' -c '$5$rounds=8000$%.16s' -s "$pw" | base64`
structuralObjectClass: organizationalRole

dn: ou=People,$basedn
objectClass: top
objectClass: organizationalUnit
structuralObjectClass: organizationalUnit
ou: People

dn: ou=Groups,$basedn
objectClass: top
objectClass: organizationalUnit
structuralObjectClass: organizationalUnit
ou: Groups
EOF
