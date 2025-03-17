#! /bin/bash

if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ] || [ -z "$DB_PASS_ROOT" ]; then
    echo "Error: una o más variables de entorno faltan!"
    exit 1
fi

# Iniciar MariaDB y configurar la base de datos solo si no está ya configurada
if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
    # Inicializar el directorio de datos si es necesario
    mysql_install_db --datadir=/var/lib/mysql

    service mariadb start

    # Configurar la base de datos
    mariadb -v -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_PASS_ROOT';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_PASS_ROOT');
EOF

    service mariadb stop
fi

# Ejecutar el comando principal (mysqld_safe)
exec "$@"
