### 1. What is PostgreSQL?

PostgreSQL is a powerful open-source relational database management system. It stores data in structured tables and allows users to perform Create, Read, Update, and Delete operations using SQL. PostgreSQL supports advanced features like:

- Foreign keys
- Joins
- Indexes
- JSON data types

It is widely used in both small-scale and enterprise applications.

---

### 2. What is the purpose of a database schema in PostgreSQL?

A **schema** in PostgreSQL is like a container within a database. It helps organize and group related database objects such as tables, views, and functions.

- Schemas help avoid naming conflicts.
- Multiple schemas can exist in one database.

#### Example:
```sql
CREATE SCHEMA wildlife;
```

---

##  3. Explain the Primary Key and Foreign Key concepts in PostgreSQL

### Primary Key

A **Primary Key** is a column that uniquely identifies each row in a table.  
- It **cannot be NULL**.
- It **must be unique**.
- Every table should have a primary key to maintain data integrity.

#### Example:
```sql
CREATE TABLE rangers (
  ranger_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  region VARCHAR(50)
);
```

### Foreign Key

A **Foreign Key** is a column in one table that refers to the primary key of another table.
- It is used to create a relationship between tables.
- Ensures referential integrity

#### Example:
```sql
CREATE TABLE sightings (
  sighting_id SERIAL PRIMARY KEY,
  species_name VARCHAR(100),
  location VARCHAR(100),
  date DATE,
  ranger_id INT REFERENCES rangers(ranger_id)
);
```

---

##  5. Explain the purpose of the `WHERE` clause in a `SELECT` statement

The `WHERE` clause in SQL is used to **filter rows** in a query based on specific conditions.  
It lets you retrieve **only the records** that match those conditions, instead of fetching all data.

---

###  Basic Syntax

```sql
SELECT column1, column2
FROM table_name
WHERE condition;
```

---

##  7. Explain the `GROUP BY` clause and its role in aggregation operations

The `GROUP BY` clause groups rows with the same values in specified columns.  
It is used with functions like `COUNT()`, `SUM()`, `AVG()` to get totals or summaries for each group.

---

###  Purpose:
- Group similar data together
- Useful for reports (totals, averages, counts)
- Often used with `HAVING` to filter grouped results

---

###  Example:

```sql
SELECT ranger_id, COUNT(*) AS total_sightings
FROM sightings
GROUP BY ranger_id;
```

---
