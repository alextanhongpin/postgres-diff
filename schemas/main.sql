-- To preserve order, we manually sort them in main.sql.
BEGIN;
\i schemas/extension.sql
\i schemas/user.sql
COMMIT;
