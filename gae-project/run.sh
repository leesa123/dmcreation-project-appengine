#!/bin/bash

# Create project for google-app-engine Application.
# parameter)  
#  ex ) ./run.sh dm-creation-project-0001 utapp-9549 588563882980 016F9C-C22464-EDEA07 app1 asia-northeast1 a python27 
#   $1 ) DM Project
#   $2 ) App-engine Project
#   $3 ) OrganizationId
#   $4 ) BillingAccountId
#   $5 ) AppName
#   $6 ) Region
#   $7 ) Local
#   $8 ) Runtime
#   $9 ) Version

# 1. Import files
# env-variables.sh : Import environment-variables for using in func.sh 
# func.sh : Import function was consist of create, try-catch ...etc 
. ./env-variables.sh 
. ./func.sh

# 2. Check parameter number
if [ $# -ne 9 ];
then
	echo -e '\e[31mYou must set nine arguments\e[0m'
	exit 1
fi

# 3. Check parameter rgex
chk_parm_exp
if [ $? -ne 0 ];
then
	echo -e '\e[31mReconfirm Parameters to continue\e[0m'
	exit 1
fi	

# 4. Backup files
backup_conf

# 5. Set the project_id in config.yaml before creating.
#    After setting, perfome creating-project as using the tool was named "deployment-manager".
#    reset to the original state.
create_project
if [ $? -ne 0 ];
then
	restore_conf
	delete_tmpfiles
	exit 1
fi	

# 6. Make application in the project. ($_RESULT_PROJECT_ID)
create_app
if [ $? -ne 0 ];
then
	restore_conf
	delete_tmpfiles
	exit 1
fi	

# 7. After change the project, Deploy gae-application.
deploy_app
if [ $? -ne 0 ];
then
	restore_conf
	delete_tmpfiles
	exit 1
fi	

# 8. Exiting normally with return code 0
restore_conf
delete_tmpfiles
exit 0
