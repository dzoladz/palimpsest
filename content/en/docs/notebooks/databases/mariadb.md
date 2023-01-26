---
title: "MariaDB"
description: >
    MariaDB CLI commands 
---
### Connect as a user

```bash
mysql -u root -p
mysql -u derek -p
```

### Create a new user

```bash
CREATE USER 'derek'@'%' IDENTIFIED BY 'SOMEPASSWORDSTRING';
```

### Grant all privileges to the new user

```bash
GRANT ALL PRIVILEGES ON *.* TO 'derek'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;
```

### Alter a current user

```bash
ALTER USER 'derek'@'localhost' IDENTIFIED BY 'SOMEPASSWORDSTRING';
FLUSH PRIVILEGES;
EXIT;
```

### Show grants for a user

```bash
SHOW GRANTS FOR 'derek';
```

### Backup & Restore

```bash
# Dump structure and data
mysqldump -u root -p database > /path/to/database.sql

# If you only want the database structure, no data
mysqldump -u root -p database --no-data > /path/to/database.sql

# Restore a database from SQL backup
mysql -u root -p database < /path/to/database.sql
```