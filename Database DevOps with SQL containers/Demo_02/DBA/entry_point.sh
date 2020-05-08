# Start SQL Server, then start the SQL script to restore DB and create objects
# The wait time depends on the environment
/db_scripts/DBA/sql_deployment.sh $1 $2 & /opt/mssql/bin/sqlservr