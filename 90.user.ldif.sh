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
dn: cn=$1,ou=People,o=denkn,c=at
objectClass: top
objectClass: simpleSecurityObject
objectClass: organizationalPerson
objectClass: inetOrgPerson
cn: $1
uid: $1
givenName:: `echo "$2" | base64`
sn:: `echo "$3" | base64`
mail:: `echo "$4" | base64`
userPassword:: `echo "$pw" | base64`
EOF
