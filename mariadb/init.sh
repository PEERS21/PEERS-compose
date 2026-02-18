#!/bin/bash
set -e

AUTH_DB_PASS=$(cat /run/secrets/mariadb_auth_db_pass)
RENTALDISK_DB_PASS=$(cat /run/secrets/auth_db_pass)

mysql -u root -p"$(cat /run/secrets/mariadb_root_password)" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS auth_db;
    CREATE USER IF NOT EXISTS 'auth_user'@'%' IDENTIFIED BY '$AUTH_DB_PASS';
    GRANT ALL PRIVILEGES ON auth_db.* TO 'auth_user'@'%';
    FLUSH PRIVILEGES;
EOSQL

mysql -u root -p"$(cat /run/secrets/mariadb_root_password)" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS rentaldisk_db;
    CREATE USER IF NOT EXISTS 'rentaldisk_user'@'%' IDENTIFIED BY '$RENTALDISK_DB_PASS';
    GRANT ALL PRIVILEGES ON rentaldisk_db.* TO 'rentaldisk_user'@'%';
    FLUSH PRIVILEGES;
EOSQL