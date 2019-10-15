#!/bin/bash
log=/db_scripts/sql_deployment.log
DBAPwD=`cat /db_scripts/DBA/.x`

# Wait for the SQL Server to start
echo -e "Waiting $1 for SQL Server to start\n\n" | tee -a $log
sleep $1

# Starting deployment
echo -e "Starting deployment" | tee -a $log

# Run SQL script using SQLCMD
sqlcmd -S localhost -U SA -P $DBAPwD -d master -i /db_scripts/DBA/1_1_CreateDBADatabase.sql -r1 2>> $log

# Restore database from latest backup
echo -e "\nRestoring HR database ..." | tee -a $log
sqlcmd -S localhost -U SA -P $DBAPwD -d master -i /db_scripts/DBA/2_1_RestoreDatabase.sql -r1 2>> $log

# Create logins and mask sensitive data
echo -e "\nCreating logins and masking data ..." | tee -a $log
sqlcmd -S localhost -U SA -P $DBAPwD -d master -i /db_scripts/DBA/3_1_CreateLoginsMaskData.sql -r1 2>> $log

# Deploy sp_WhoIsActive stored procedure
echo -e "\nDeploying sp_WhoIsActive stored procedure ..." | tee -a $log
sqlcmd -S localhost -U SA -P $DBAPwD -d DBA -i /git_repos/sp_whoisactive/who_is_active.sql -r1 2>> $log

# Checking for errors
# Getting the number of errors
rt=`grep -ci "Error" $log`

if [ $rt -gt 0 ]
then
    # End of script with errors
    printf "\nPlease check the log, there are $rt errors found \U1F643\n" | tee -a $log
    exit 1
else
    # End of script with success
    printf '\nNo errors found \U1F603\n' | tee -a $log
    printf '\nThe script was successfully completed! \U1F603\n' | tee -a $log
    exit 0
fi
