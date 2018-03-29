Add your basedn to basedn (eg: `echo o=denkn,c=at > basedn`).

For initialization, first shutdown slapd and delete `/var/lib/ldap/` (you will loose all of your data!),
then use:

	./00.root.ldif.sh | slapadd -b `cat basedn` -v

For adding 10 and 20 use:

	slapadd -b `cat basedn` -v -l 10.acls.ldif
	slapadd -b `cat basedn` -v -l 20.passwordhash.ldif

Now you can start slapd with your fresh config.

Via `ldapadd -Y EXTERNAL` you can add any other ldif.

For adding an user run `./90.user.ldif.sh username givenname surname emailaddr | ldapadd -Y external`.
