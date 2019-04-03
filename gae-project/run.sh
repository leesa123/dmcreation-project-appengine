#!/bin/bash

# Create project for google-app-engine Application.
# parameter)  
#  ex ) ./run.sh dm-creation-project-0001 utapp-9549 588563882980 016F9C-C22464-EDEA07 app1 asia-northeast1 a python27 
#   $1 ) DM project
#   $2 ) App-engine project
#   $3 ) $1 deploy name
#   $4 ) Organization id
#   $5 ) Billingaccount id
#   $6 ) Serviceid
#   $7 ) $2 deploy name
#   $8 ) zone (zone = region + local) ex) asia-northeast1-a = 'asia-northeast1' + 'a'
#   $9 ) Runtime
#   ${10} ) Version
#   ${11} ) It is a Container image in flexible environment or GCS bucket path in standard environment 

# 1. Import files
# env-variables.sh : Import environment-variables for using in func.sh 
# func.sh : Import function was consist of create, try-catch ...etc 
. ./env-variables.sh 
. ./func.sh

# 2. Check parameter number
if [ $# -ne 11 ];
then
	echo -e '\e[31mYou must set eleven arguments\e[0m'
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
