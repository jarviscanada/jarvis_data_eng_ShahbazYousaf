# Introduction
Jarvis has a Linux Cluster Administration (LCA) team that manages a Linux CentOS 7 cluster of 10 servers. The main project goal is to create an MVP for the LCA team that records the hardware specs for each server, and monitors and records real-time linux server usage data from CPU to memory usage. This data is stored in a PostgreSQL RDBMS for future resource planning, such as adding or removing servers. The collected data is used to generate reports for resource planning, optimizing underused servers with more software and apps and acquiring new servers to reduce the load for overused ones. The project utilizes Bash scripts for hardware and server usage data collection, Docker for PostgreSQL RDBMS provisioning, and Git/GitHub for code version control, ensuring efficient data management and development.

# Quick Start

1. **Start a PostgreSQL instance using `psql_docker.sh`:**
This script sets up a Docker container running PostgreSQL, which allows you to quickly create and manage the database.
```
To create the PostgreSQL docker container
./scripts/psql_docker.sh create db_username db_password
# Example 
./scripts/psql_docker.sh create postgres password
```
2. **Create tables using `ddl.sql`:**
- The ddl.sql script defines the structure of the host_agent database, including the two tables used to store hardware specifications and resource usage data. against the psql instance
```
-- connect to the psql instance
psql -h localhost -U postgres -W
-- create the host_agent database 
postgres=# CREATE DATABASE host_agent; 
-- connect to the new database
postgres=# \c host_agent;
-- disconnect to the new host_agent database
postgres=# \q

-- Execute ddl.sql script on the host_agent database against the psql instance to create the tables
psql -h localhost -U postgres -d host_agent -f sql/ddl.sql
```

3. **Insert hardware specifications data into the database using `host_info.sh`:**
   - Run this script on each server to collect hardware specifications. This information is inserted into the database and only needs to be executed once during installation.
```
# Script usage 
bash scripts/host_info.sh psql_host psql_port db_name psql_user psql_password 
# Example 
bash scripts/host_info.sh localhost 5432 host_agent postgres password
```
4. **Collect and insert hardware usage data into the database using `host_usage.sh`:**
   - This script continuously collects real-time server usage data, including CPU and Memory, and inserts it into the database. The script is scheduled to run every minute using crontab.
```
# Script usage 
bash scripts/host_usage.sh psql_host psql_port db_name psql_user psql_password 
# Example 
bash scripts/host_usage.sh localhost 5432 host_agent postgres password
```
5. **Set up the crontab to automate data collection:**
   - Configure the crontab to execute `host_usage.sh` at regular intervals, ensuring that data is collected and stored in the database every minute.
```
# edit crontab jobs
bash> crontab -e

# add this to crontab
# make sure you are using the correct file location for your script
* * * * * bash /home/centos/dev/jrvs/bootcamp/linux_sql/host_agent/scripts/host_usage.sh localhost 5432 host_agent postgres password 

# list crontab jobs
crontab -l
```
# validate your result from the psql instance
```
psql -h localhost -U postgres -W
\l to list the dbs
\c host_agent
\dt to list he tables/relations
> SELECT * FROM host_usage;
\q to quit psql instance
```

# Implemenation
Discuss how you implement the project.
## Architecture
Draw a cluster diagram with three Linux hosts, a DB, and agents (use draw.io website). Image must be saved to the `assets` directory.

## Scripts
Shell script description and usage (use markdown code block for script usage)
- psql_docker.sh
- host_info.sh
- host_usage.sh
- crontab
- queries.sql (describe what business problem you are trying to resolve)

## Database Modeling
Describe the schema of each table using markdown table syntax (do not put any sql code)
- `host_info`
- `host_usage`

# Test
How did you test your bash scripts DDL? What was the result?

# Deployment
How did you deploy your app? (e.g. Github, crontab, docker)

# Improvements
Write at least three things you want to improve 
e.g. 
- handle hardware updates 
- blah
- blah
