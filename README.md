<div align="center">

# DataManagement

Source code for the **Data Management** course

</div>

### Programming Languages
<div>
  <img src="https://img.shields.io/badge/SQL-336791?style=for-the-badge&logoColor=white" alt="SQL" />
</div>

### Database
<div>
  <img src="https://img.shields.io/badge/Oracle%20Database-F80000?style=for-the-badge&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAyNCAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU%2BT3JhY2xlPC90aXRsZT48cGF0aCBmaWxsPSJ3aGl0ZSIgZD0iTTE2LjQxMiA0LjQxMmgtOC44MmE3LjU4OCA3LjU4OCAwIDAgMC0uMDA4IDE1LjE3Nmg4LjgyOGE3LjU4OCA3LjU4OCAwIDAgMCAwLTE1LjE3NnptLS4xOTMgMTIuNTAySDcuNzg2YTQuOTE1IDQuOTE1IDAgMCAxIDAtOS44MjhoOC40MzNhNC45MTQgNC45MTQgMCAxIDEgMCA5LjgyOHoiLz48L3N2Zz4%3D" alt="Oracle Database" />
</div>

### Version Control
<div>
  <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white" alt="Git" />
  <img src="https://img.shields.io/badge/GitHub-586069?style=for-the-badge&logo=github&logoColor=white" alt="GitHub" />
</div>

### IDE
<div>
  <img src="https://img.shields.io/badge/Visual%20Studio%20Code-007ACC?style=for-the-badge&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAyNCAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU%2BVmlzdWFsIFN0dWRpbyBDb2RlPC90aXRsZT48cGF0aCBmaWxsPSJ3aGl0ZSIgZD0iTTIzLjE1IDIuNTg3TDE4LjIxLjIxYTEuNDk0IDEuNDk0IDAgMCAwLTEuNzA1LjI5bC05LjQ2IDguNjMtNC4xMi0zLjEyOGEuOTk5Ljk5OSAwIDAgMC0xLjI3Ni4wNTdMLjMyNyA3LjI2MUExIDEgMCAwIDAgLjMyNiA4Ljc0TDMuODk5IDEyIC4zMjYgMTUuMjZhMSAxIDAgMCAwIC4wMDEgMS40NzlMMS42NSAxNy45NGEuOTk5Ljk5OSAwIDAgMCAxLjI3Ni4wNTdsNC4xMi0zLjEyOCA5LjQ2IDguNjNhMS40OTIgMS40OTIgMCAwIDAgMS43MDQuMjlsNC45NDItMi4zNzdBMS41IDEuNSAwIDAgMCAyNCAyMC4wNlYzLjkzOWExLjUgMS41IDAgMCAwLS44NS0xLjM1MnptLTUuMTQ2IDE0Ljg2MUwxMC44MjYgMTJsNy4xNzgtNS40NDh2MTAuODk2eiIvPjwvc3ZnPg%3D%3D" alt="Visual Studio Code" />
  <img src="https://img.shields.io/badge/Oracle%20SQL%20Developer-C74634?style=for-the-badge&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAyNCAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU%2BT3JhY2xlPC90aXRsZT48cGF0aCBmaWxsPSJ3aGl0ZSIgZD0iTTE2LjQxMiA0LjQxMmgtOC44MmE3LjU4OCA3LjU4OCAwIDAgMC0uMDA4IDE1LjE3Nmg4LjgyOGE3LjU4OCA3LjU4OCAwIDAgMCAwLTE1LjE3NnptLS4xOTMgMTIuNTAySDcuNzg2YTQuOTE1IDQuOTE1IDAgMCAxIDAtOS44MjhoOC40MzNhNC45MTQgNC45MTQgMCAxIDEgMCA5LjgyOHoiLz48L3N2Zz4%3D" alt="Oracle SQL Developer" />
</div>

### AI Agents
<div>
  <img src="https://img.shields.io/badge/Claude%20Code-D97757?style=for-the-badge&logo=claude&logoColor=white" alt="Claude Code" />
</div>

---
## Project Overview
**Course:** Data Management  
**University:** Tech University of Korea (TUK)

This repository contains Oracle SQL practice code written while studying Data Management.
All exercises run against a K League soccer sample schema (`STADIUM`, `TEAM`, `SCHEDULE`, `PLAYER`) created by [model.sql](model.sql).

The purpose of this project is to:

- build a practice schema with DDL and load sample data with DML
- practice core SQL querying (`SELECT`, `WHERE`, `ORDER BY`) on Oracle
- keep a structured, dated record of lecture exercises

---
## Project Structure

```
DataManagement/
├── model.sql              # Practice schema: DROP/CREATE tables + sample data INSERTs
├── 0928/
│   └── system.sql         # Oracle environment check (SELECT * FROM HELP)
├── 0930/
│   └── model_check.sql    # DESCRIBE, SELECT, alias, ORDER BY, WHERE exercises
├── LICENSE                # MIT License
├── .gitignore
└── README.md
```

Practice folders are named by lecture date (`MMDD`).

---
## Practice Schema (`model.sql`)

| Table | Description | Primary Key | Foreign Key | Rows |
|-------|-------------|-------------|-------------|-----:|
| `STADIUM`  | Stadium info (name, home team, seats, address) | `STADIUM_ID` | – | 20 |
| `TEAM`     | Team info (region, name, founding year, contact) | `TEAM_ID` | `STADIUM_ID` → `STADIUM` | 15 |
| `SCHEDULE` | Match schedule and scores | `STADIUM_ID`, `SCHE_DATE` | `STADIUM_ID` → `STADIUM` | 180 |
| `PLAYER`   | Player info (position, back number, height, weight) | `PLAYER_ID` | `TEAM_ID` → `TEAM` | 480 |

```
STADIUM ─┬─< TEAM ─< PLAYER
         └─< SCHEDULE
```

The script drops the tables in reverse dependency order (`PLAYER` → `SCHEDULE` → `TEAM` → `STADIUM`) before recreating them, so it can be re-run to reset the practice data.

---
## What I Learned

### DDL — Defining Tables
- `CREATE TABLE` with Oracle data types: `CHAR`, `VARCHAR2`, `NUMBER(p)`
- `NOT NULL` constraints
- `PRIMARY KEY` constraints, including a composite key (`SCHEDULE`)
- `FOREIGN KEY ... REFERENCES` to link tables
- `DROP TABLE` order when foreign keys exist (child tables first)

### DML / TCL — Loading Data
- Inserting sample rows with `INSERT INTO ... VALUES`
- Making changes permanent with `COMMIT`

### Checking the Environment and Table Structure
- `SELECT * FROM HELP` to confirm the Oracle connection works
- `DESCRIBE` / `DESC` to see column names, nullability, and types
- `DESC` is a SQL\*Plus / SQL Developer command, not standard SQL

### SELECT Basics
- Selecting all columns with `*` vs. listing only needed columns
- Column aliases with `AS` (optional keyword, double quotes for spaces/case)
- Sorting with `ORDER BY ... ASC | DESC`
  - `ASC` is the default
  - In Oracle, `NULL` sorts last in `ASC` and first in `DESC`
  - Character columns sort lexicographically (`'9'` > `'10'`)
  - A column can be used in `ORDER BY` without being in the `SELECT` list
- Filtering rows with `WHERE`
  - String literals use single quotes, and values are case-sensitive (`'mf'` ≠ `'MF'`)
  - Written order: `SELECT → FROM → WHERE → ORDER BY`
  - Execution order: `FROM → WHERE → SELECT → ORDER BY`

---
## How to Run

1. Connect to an Oracle Database in Oracle SQL Developer (or SQL\*Plus).
2. Run [model.sql](model.sql) as a script to create the tables and load the sample data.
   - On the very first run the `DROP TABLE` lines fail because the tables don't exist yet; that is expected.
3. Open a dated practice file (e.g. [0930/model_check.sql](0930/model_check.sql)) and run each statement.

---

## License

This project is licensed under the MIT License.

See the [LICENSE](LICENSE) file for details.


## Author
Name: Jiyong Kim (ZYONGE)  
Profile: https://github.com/ZYONGE  

## Motivation
For A+ !!!
