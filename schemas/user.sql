CREATE TABLE IF NOT EXISTS users (
	id uuid DEFAULT gen_random_uuid(),
	name text NOT NULL DEFAULT '',
	age integer NOT NULL DEFAULT 0,
	bio text NOT NULL DEFAULT '',
	email citext NOT NULL,
	created_at timestamptz NOT NULL DEFAULT current_timestamp,
	updated_at timestamptz NOT NULL DEFAULT current_timestamp,
	deleted_at timestamptz NULL,
	PRIMARY KEY (id),
	UNIQUE (email)
);
