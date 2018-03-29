Add your basedn to basedn (eg: `echo o=denkn,c=at > basedn`).

For initialization, first shutdown slapd and delete the content of `/var/lib/ldap/` (you will loose all of your data!),
then use:

	./00.root.ldif.sh | slapadd -b `cat basedn` -v
	chown -R openldap:openldap /var/lib/ldap/

Now you can start slapd with your fresh config.

Add these lines to `/etc/ldap/ldap.conf`:

	cat > /etc/ldap/ldap.conf <<EOF
	BASE    `cat basedn`
	URI     ldapi://
	EOF

Via `ldapadd -Y EXTERNAL` you can add any other ldif.

For adding 10 and 20 use: [BROKEN, do it manually in `/etc/...`]

	ldapmodify -Y EXTERNAL -f 10.acls.ldif
	ldapmodify -Y EXTERNAL -f 20.passwordhash.ldif

For adding an user run:

	./90.user.ldif.sh username givenname surname emailaddr | ldapadd -Y EXTERNAL

It will print the password on STDERR.

For changing password use:

	ldappasswd -xASD YOURDN
