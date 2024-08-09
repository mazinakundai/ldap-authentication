# PHP and Apache with LDAP support
FROM php:7.4-apache

# Install LDAP dependencies and utilities
RUN apt-get update && apt-get install -y \
    libldap2-dev \
    ldap-utils \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install ldap \
    && rm -rf /var/lib/apt/lists/*

# Copy the application code to the container
# COPY www/ /var/www/html/

# Copy the custom Apache config
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html/

# Copy LDIF generation and import script
COPY generate_and_import_ldif.sh /usr/local/bin/generate_and_import_ldif.sh
RUN chmod +x /usr/local/bin/generate_and_import_ldif.sh

# Run Apache server in the foreground
CMD ["apache2-foreground"]
