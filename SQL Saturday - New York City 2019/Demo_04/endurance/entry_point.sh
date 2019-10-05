#!/bin/bash

# Start SQL Server, then start the SQL script to restore DB and create objects
/db_scripts/deployment.sh & /opt/mssql/bin/sqlservr