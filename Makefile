ifeq ($(ENV),)
	ENV := development
endif
-include .env.$(ENV)
export

up:
	@docker-compose up -d

down:
	@docker-compose down

# So that we don't need to manually input password.
PGPASSWORD := $(DB_PASS)
CONN_STRING := postgresql://${DB_USER}:${DB_PASS}@${DB_HOST}:${DB_PORT}

# Runs migration to a temporary database to get the "new" schema.
migrate:
	@psql -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USER} -d 'postgres' -c 'drop database if exists temp;'
	@psql -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USER} -d 'postgres' -c 'create database temp;'
	@psql -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USER} -d 'temp' -f schemas/main.sql

# Runs a diff in sql between the target database, and the source
# database with newer migrations (aka our temp).
diff:
	@migra ${CONN_STRING}/${DB_NAME} ${CONN_STRING}/temp >&1 | tee temp.migrations.sql

# Apply the diff in migrations to the target database.
apply:
	@psql -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USER} -d ${DB_NAME} --single-transaction -f temp.migrations.sql
	@rm temp.migrations.sql

# Dump all schemas only to a local file.
dump:
	@PGPASSWORD=${DB_PASS} pg_dump --no-owner --no-privileges --schema-only -f schema.dump.sql --dbname=${DB_NAME} --host=${DB_HOST} --port=${DB_PORT} --username=${DB_USER} --no-password
