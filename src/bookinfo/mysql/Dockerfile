FROM mysql:8.0.20
# MYSQL_ROOT_PASSWORD must be supplied as an env var

EXPOSE 3306

COPY ./mysqldb-init.sql /docker-entrypoint-initdb.d