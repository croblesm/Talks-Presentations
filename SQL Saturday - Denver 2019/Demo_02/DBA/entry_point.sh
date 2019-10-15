# Start SQL Server, then start the SQL script to restore DB and create objects
# The wait time depends on the environment
/db_scripts/DBA/sql_deployment.sh 20 & /opt/mssql/bin/sqlservr