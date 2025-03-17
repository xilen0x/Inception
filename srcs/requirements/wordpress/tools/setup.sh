#!/bin/bash

# this script run in the building container
# it changes the ownership of the /var/www/inception/ folder to www-data user
# then sure that the wp-config.php file is in the /var/www/inception/ folder
# then it downloads the wordpress core files if they are not already there
# then it installs wordpress if it is not already installed
# and set the admin user and password if they are not already set
# this variables are set in the .env file
# the penultimate line download and activate the raft theme, that I liked most
# at the end, exec $@ run the next CMD in the Dockerfile.
# In this case: starts the php-fpm7.4 server in the foreground

# set -ex # print commands & exit on error (debug mode)

chown -R www-data:www-data /var/www/inception/

if [ ! -f "/var/www/inception/wp-config.php" ]; then
   mv /tmp/wp-config.php /var/www/inception/
fi

# Esperar a que MariaDB esté listo para aceptar conexiones
echo "Esperando a que la base de datos esté disponible..."
max_attempts=10
attempt=0
while ! mysqladmin ping -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" --silent && [ $attempt -lt $max_attempts ]; do
    attempt=$((attempt+1))
    echo "Intento $attempt de $max_attempts, esperando 5 segundos..."
    sleep 5
done

if [ $attempt -eq $max_attempts ]; then
    echo "No se pudo conectar a la base de datos después de $max_attempts intentos"
    exit 1
fi

echo "Base de datos disponible, continuando con la instalación..."

wp --allow-root --path="/var/www/inception/" core download || true

if ! wp --allow-root --path="/var/www/inception/" core is-installed;
then
    wp  --allow-root --path="/var/www/inception/" core install \
        --url=$WP_URL \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL
fi;

if ! wp --allow-root --path="/var/www/inception/" user get $WP_USER;
then
    wp  --allow-root --path="/var/www/inception/" user create \
        $WP_USER \
        $WP_EMAIL \
        --user_pass=$WP_PASSWORD \
        --role=$WP_ROLE
fi;

wp --allow-root --path="/var/www/inception/" theme install raft --activate 

exec "$@"