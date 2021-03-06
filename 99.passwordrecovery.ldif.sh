#!/bin/sh

if ! [ 1 -eq $# ]
then
	echo "Usage: $0 \$userdn" >&2
	echo "random password will be printed.  Use ldappasswd for changing it" >&2
	exit 1
fi

user="$1"
pw=`pwgen 12 1`
echo "# Password: $pw" >&2

cat <<EOF
dn: $1
changeType: modify
replace: userPassword
userPassword:: `echo "$pw" | base64 -w0`
EOF

#userPassword:: `/usr/sbin/slappasswd -h '{CRYPT}' -c '$5$rounds=8000$%.16s$' -s "$pw" | base64 -w0`
