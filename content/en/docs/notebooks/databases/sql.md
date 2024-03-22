---
title: "SQL"
description: >
    Structured Query Language
---

SQL (Structured Query Language) is used to manage data in a relational database management system.

Diagrams from [ByteByteGo](https://bytebytego.com/)

## Execution Order

![](../assets/execution_order.jpg)

## SQL Components

Engineering relational databases required an understanding of the following components

- **DDL**: (data definition language)
  - syntax for creating and modifying database objects such as tables, indices, and users
  - e.g., CREATE, ALTER, DROP
- **DQL**: (data query language)
  - used for performing queries on the data within schema objects
  - e.g., SELECT
- **DML**: (data manipulation language)
  - used for adding (inserting), deleting, and modifying (updating) data
  - e.g., INSERT, UPDATE, DELETE
- **DCL**: (data control language)
  - used to control access to data stored in a database i.e., authorization
  - e.g., GRANT, REVOKE
- **TCL**: (transaction control language)
  - used to maintain the integrity and consistency of the data stored in the database
  - e.g., COMMIT, ROLLBACK

![](../assets/sql_components.png)

## Types of Joins

![](../assets/join_types.png)