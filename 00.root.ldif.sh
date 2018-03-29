#!/bin/sh -e

basedn=$(cat basedn)
_x=${basedn%%,*}
dc=${_x#*=}
en=${_x%%=*}
if [ Xdc = "X$en" ]
then
	en=""
else
	en=`printf '\n%s' "$en: $dc"`
fi
pw=`pwgen 8 1`
echo "# Password for cn=root,$basedn: $pw" >&2

cat <<EOF
dn: $basedn
objectClass: top
objectClass: dcObject
objectClass: organization
dc: ${dc}${en}
structuralObjectClass: organization

dn: cn=root,$basedn
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: root
description: LDAP administrator
userPassword:: `echo "$pw" | base64`
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