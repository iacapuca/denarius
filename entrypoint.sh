# entrypoint.sh

#!/bin/bash
# Docker entrypoint script.

# Wait until Postgres is ready.
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $POSTGRES_USER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

# Create, migrate, and seed database if it doesn't exist.
if [[ -z `psql -Atqc "\\list $POSTGRES_DATABASE"` ]]; then
  echo "Database $POSTGRES_DATABASE does not exist. Creating..."
  mix ecto.create
  mix ecto.migrate
  echo "Database $POSTGRES_DATABASE created."
fi

exec mix run --no-halt