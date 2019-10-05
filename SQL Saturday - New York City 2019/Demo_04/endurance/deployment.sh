#!/bin/bash

# Wait for the SQL Server to start
sleep 20s

# Run SQL script using SQLCMD
echo ""
echo "Creating TARS database ..."
sqlcmd -S localhost -U SA -P 'SqLr0ck$!' -d master -i /db_scripts/TARS.sql
echo ""
echo "Creating sp_WhoIsActive ..."
sqlcmd -S localhost -U SA -P 'SqLr0ck$!' -d master -i /git/sp_whoisactive/who_is_active.sql
echo ""
echo "Deployment finished ..."