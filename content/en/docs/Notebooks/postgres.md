Postgres
============
Installation on MacOS using Homebrew services

## First Steps

1. Install PostgreSQL, preferably a pinned version
```bash
brew install postgresql@10
```

2. If you don't have one, get the `psql` client.

```bash
brew install libpq
```

> `libpq` won't install itself in the `/usr/local/bin` directory like other Homebrew applications. To make that happen, you need to run:

```bash
brew link --force libpq
```

3. Start Postgres services

```bash
brew services start postgresql
```

> Check `brew info postgresql`

4. Create a database, and...

```bash
createdb `first`
```

> Fix role "postgres" does not exist error

```bash
createuser -s postgres
```
## Initial Reading
[PostgreSQL Guide](http://postgresguide.com/)

## PSQL
- Run psql client as user postgres - `psql -U postgres`
- Connect to local postgres database as a specific user - `psql -h localhost -U <postgres_user> <database>``

#### Quick Start
- `\?` - List all available commands
- `\q` - Quit/Exit
- `\l` - List databases
- `\c <database>` - Connect to a database


#### Up and Running, Informational
- `\d` - List tables
- `\d <table>` - Show table definition, including triggers
- `\d+ <table>` - Show additional info about a table

- `\dy` - List events
- `\df` - List functions
- `\di` - List indexes
- `\dn` - List schemas
- `\dv` - List views
- `\e` - Open default text editor in psql shell
- `\copy (SELECT * FROM __table_name__) TO 'file_path_and_name.csv' WITH CSV` - Export a table as CSV

#### Settings
- `\timing` - Turn on query timing
- `\x` - Pretty-format query results

## Backup and Restore

#### Backup, plain text
- `pg_dump <dbname> > db.sql` - plain text

#### Backup, for persistence and storage
- `pg_dump -Fc <dbname> > db.bak` - compressed binary format
- `pg_dump -Ft <dbname> > db.tar` - tarball format

#### Restore
If the database already exists,
- `pg_restore -Fc db.bak` - restore compressed binary format
- `pg_restore -Ft db.tar` - restore tarball format

If creating the database new from a dump, you'll need to add the `-C` flag.

#### Import, as a new database
Create the database
- `createdb -T template0 <dbname>`

Import database from dump
- `pg_restore --clean --no-owner --verbose -d <dbname> db.bak` -


## Database Commands, outside of psql

- Create database `createdb <database_name>`
- Drop database `dropdb <database_name>`
- Restore database `pg_restore --no-owner --dbname <database> <database.dump>`

## Database Commands, inside of PSQL (DON'T FORGET `;`)

- Create database `CREATE DATABASE <database>`
- Remove database `DROP DATABASE <database>`
