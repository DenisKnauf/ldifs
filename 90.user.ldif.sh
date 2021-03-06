#!/bin/sh

if ! [ 4 -eq $# ]
then
	echo "Usage: $0 username givenname surname mailaddr" >&2
	echo "random password will be printed.  Use ldappasswd for changing it" >&2
	exit 1
fi

pw=`pwgen 8 1`
echo "# Password: $pw" >&2

cat <<EOF
dn: uid=$1,ou=People,`cat basedn`
objectClass: top
objectClass: simpleSecurityObject
objectClass: organizationalPerson
objectClass: inetOrgPerson
cn: $1
uid: $1
givenName: $2
sn: $3
mail: $4
userPassword:: `echo "$pw" | base64 -w0`
EOF
