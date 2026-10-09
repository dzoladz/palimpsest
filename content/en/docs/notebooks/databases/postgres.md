---
title: "PostgreSQL"
description: >
    Installation on MacOS using Homebrew services
---

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

## PSQL Commands

|                 |                                           |
|-----------------|-------------------------------------------|
| Command         | Description                               |
| `\?`            | List all available commands               |
| `\q`            | Quit/Exit                                 |
| `\l`            | List databases                            |
| `\c <database>` | Connect to a database                     |
| `\du`           | List all users                            |
| `\d`            | List tables                               |
| `\d <table>`    | Show table definition, including triggers |
| `\d+ <table>`   | Show additional info about a table        |
| `\dy`           | List events                               |
| `\df`           | List functions                            |
| `\di`           | List indexes                              |
| `\dn`           | List schemas                              |
| `\dv`           | List views                                |
| `\dx`           | List extensions                           |
| `\e`            | Open default text editor in psql shell    |
| `\timing`       | Turn on query timing                      |
| `\x`            | Pretty-format query results               |

It's also possible to export a table as CSV

```psql
\copy (SELECT * FROM __table_name__) TO 'file_path_and_name.csv' WITH CSV
```

## Backup and Restore

|                                     |                                                |
|-------------------------------------|------------------------------------------------|
| Command                             | Description                                    |
| `pg_dump <dbname> > db.sql`         | Dump database to stdout                        |
| `pg_dump -Fc <dbname> > db.sql.bin` | Dump database to a compressed binary file      |
| `pg_dump -Ft <dbname> > db.tar`     | Dump database to a tarball file                |
| `pg_restore -Fc <dbname>`           | Restore database from a compressed binary file |
| `pg_restore -Ft <dbname>`           | Restore database from a tarball file           |

If creating the database new from a dump, you'll need to add the `-C` flag.

### Import, as a new database
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

## Resolve collation mismatch

If you get the following error when connecting to a database:

> WARNING:  database "postgres" has a collation version mismatch
> DETAIL:  The database was created using collation version 2.39, but the operating system provides version 2.43.

Execute the following commands:

1. `REINDEX DATABASE <dbname>;`
2. `ALTER DATABASE <dbname> REFRESH COLLATION VERSION;`
