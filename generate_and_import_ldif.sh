#!/bin/bash

# Generate an LDIF file from your MySQL database and import it into LDAP
php /var/www/html/export_users_to_ldap.php

# Import the generated LDIF file into LDAP
ldapadd -x -D "cn=admin,dc=example,dc=org" -w admin -f /var/www/html/users.ldif
