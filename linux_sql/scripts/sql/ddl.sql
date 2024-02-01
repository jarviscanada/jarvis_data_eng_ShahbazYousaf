-- Drop the database if it exists
DROP DATABASE IF EXISTS host_agent;

-- Create the host_agent database
CREATE DATABASE host_agent;

-- Connect to the host_agent database
postgres=# \c host_agent;

-- Create a host_info table if it does not already exist
CREATE TABLE IF NOT EXISTS PUBLIC.host_info 
  ( 
     id               SERIAL NOT NULL, 
     hostname         VARCHAR NOT NULL, 
     cpu_number       INT2 NOT NULL, 
     cpu_architecture VARCHAR NOT NULL, 
     cpu_model        VARCHAR NOT NULL, 
     cpu_mhz          FLOAT8 NOT NULL, 
     l2_cache         INT4 NOT NULL, 
     "timestamp"      TIMESTAMP NULL, 
     total_mem        INT4 NULL, 
     CONSTRAINT host_info_pk PRIMARY KEY (id), 
     CONSTRAINT host_info_un UNIQUE (hostname) 
  );

-- Create a host_usage table if it does not already exist
CREATE TABLE IF NOT EXISTS PUBLIC.host_usage 
  ( 
     "timestamp"    TIMESTAMP NOT NULL, 
     host_id        SERIAL NOT NULL, 
     memory_free    INT4 NOT NULL, 
     cpu_idle       INT2 NOT NULL, 
     cpu_kernel     INT2 NOT NULL, 
     disk_io        INT4 NOT NULL, 
     disk_available INT4 NOT NULL, 
     CONSTRAINT host_usage_host_info_fk FOREIGN KEY (host_id) REFERENCES 
     host_info(id) 
  );


-- Execute ddl.sql script on the host_agent database againse the psql instance
-- psql -h localhost -U postgres -d host_agent -f sql/ddl.sql




