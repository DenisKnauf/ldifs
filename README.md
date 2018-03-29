Add your basedn to basedn (eg: `echo o=denkn,c=at > basedn`).

For initialization, first shutdown slapd and delete `/var/lib/ldap/` (you will lost all your data!),
then use `./90.root.ldif | slapadd -b \`cat basedn\` -v`.

Now you can start slapd again.

Via `ldapadd -Y external` you can add any other ldif.

For adding an user run `./90.user.ldif.sh username givenname surname emailaddr | ldapadd -Y external`.
