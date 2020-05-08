#!/bin/bash

#==============================================================================
# Script name   : sql_deployment.sh
# Description   : Script to deploy DBA scripts
# Author        : Carlos Robles
# Email         : crobles@dbamastery.com
# Twitter       : @dbamastery
# Date          : 20191106
# 
# Version       : 1.1
# Usage         : bash sql_deployment.sh
#
# Notes         : 
# crobles - 201911 - First version of this script
# crobles - 202002 - Fixed problem with deployment changing order of functions
#==============================================================================

# Mapping env variables with local variables
wait_sql=$1
environment=$2

log=/db_scripts/sql_deployment.log

# Defining functions
dba_init () {

    # Starting DBA init
    echo -e "\nDBA init" | tee -a $log

   # Run SQL script using SQLCMD
    sqlcmd -U SA -d master -i /db_scripts/DBA/1_1_CreateDBADatabase.sql -r1 2>> $log

    # Restore database from latest backup
    echo -e "\nRestoring HR database ..." | tee -a $log
    sqlcmd -U SA -d master -i /db_scripts/DBA/2_1_RestoreDatabase.sql -r1 2>> $log

    # Waiting 5 seconds for recovery to complete
    sleep 5
}

sp_whoisactive_init () {
    
    # Starting sp_WhoIsActive init
    echo -e "\nsp_WhoIsActive init" | tee -a $log

    # Deploy sp_WhoIsActive stored procedure
    echo -e "\nDeploying sp_WhoIsActive stored procedure ..." | tee -a $log
    sqlcmd -U SA -d DBA -i /git_repos/sp_whoisactive/who_is_active.sql -r1 2>> $log
}

first_responder_kit_init () {
       # Starting First Responder Kit init
    echo -e "\nFirst Responder Kit init" | tee -a $log

    echo -e "\nDeploying First Responder Kit stored procedures ..." | tee -a $log
    sqlcmd -U SA -d DBA -i /git_repos/First_Responder_Kit/sp_Blitz.sql -r1 2>> $log
    sqlcmd -U SA -d DBA -i /git_repos/First_Responder_Kit/sp_BlitzCache.sql -r1 2>> $log
    sqlcmd -U SA -d DBA -i /git_repos/First_Responder_Kit/sp_BlitzFirst.sql -r1 2>> $log
    sqlcmd -U SA -d DBA -i /git_repos/First_Responder_Kit/sp_BlitzLock.sql -r1 2>> $log
    sqlcmd -U SA -d DBA -i /git_repos/First_Responder_Kit/sp_BlitzIndex.sql -r1 2>> $log
}

dba_grants () {

    # Starting DBA grants
    echo -e "\nDBA grants" | tee -a $log

    # Create logins and mask sensitive data
    echo -e "\nCreating logins and masking data ..." | tee -a $log
    sqlcmd -U SA -i /db_scripts/DBA/3_1_CreateLoginsMaskData.sql -r1 2>> $log
}

# Check if container was already created (Initialized)
if [ ! -f /db_scripts/DBA/db-initialized ]
then
    # Wait for the SQL Server to start
    echo -e "\n\nWaiting $wait_sql for SQL Server to start" | tee -a $log
    echo -e "===============================================\n\n" | tee -a $log
    sleep $wait_sql

    # Starting deployment
    echo -e "\n\nStarting deployment for $2 enviroment" | tee -a $log
    echo -e "===============================================\n" | tee -a $log

    case ${environment} in
        'DEV')
            dba_init
            sp_whoisactive_init
            dba_grants
            ;;
        'STG')
            dba_init
            sp_whoisactive_init
            first_responder_kit_init
            dba_grants
            ;;
            *)
            echo $"Usage: $0 {DEV|STG}"
            exit
    esac

    # Starting deployment
    echo -e "\nDeployment completed, inspecting log ... \n" | tee -a $log

    # Checking for errors
    # Getting the number of errors
    rt=`grep -ci "Error" $log`

        # Verifying errors
        if [ $rt -gt 0 ]
        then
            # End of script with errors
            echo -e "\nPlease check the log, there are $rt errors found :( \n" | tee -a $log
            exit 1
        else
            # End of script with success
            echo -e "\nNo errors found" | tee -a $log
            echo -e "\nThe script was successfully completed! :)" | tee -a $log
            echo -e "===============================================\n" | tee -a $log
            touch /db_scripts/DBA/db-initialized
            exit 0
        fi
else
        # Wait for the SQL Server to start
    echo -e "Waiting $wait_sql for SQL Server to start\n\n" | tee -a $log
    sleep $wait_sql
fi