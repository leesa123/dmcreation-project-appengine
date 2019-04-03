#!/bin/bash

# function 1
# Create the project
create_project() {
sed -i -- "s/\[PROJECT_ID\]/$_RESULT_PROJECT_ID/g" ./project_creation/config.yaml
sed -i -- "s/\[ORGANIZATION_ID\]/$_ORGANIZATION_ID/g" ./project_creation/config.yaml
sed -i -- "s/\[BILLING_ACCOUNT_NAME\]/$_BILLING_ACCOUNT_NAME/g" ./project_creation/config.yaml

gcloud config set project $_SOURCE_PROJECT_ID
gcloud deployment-manager deployments create $_DEPLOYMENT_NAME_DM --config ./project_creation/config.yaml
}

# function 2
# Created Application
create_app() {
gcloud config set project $_RESULT_PROJECT_ID
gcloud app create --region=$_REGION
}

# function 3
# Deploy App-engine
# If '$_DEPLOYMENTTYPE' is 'CT', you must have to excute fuction was named push_img().
deploy_app() {

if [ $_DEPLOYMENTTYPE = 'CT' ] ;
then
	push_img
fi

sed -i -- "s/\[PROJECT\]/$_RESULT_PROJECT_ID/g" ./appengine-v1/gae-template.yaml
sed -i -- "s/\[ZONE\]/$_REGION-$_LOCAL/g" ./appengine-v1/gae-template.yaml
sed -i -- "s/\[RUNTIME\]/$_RUNTIME/g" ./appengine-v1/gae-template.yaml
sed -i -- "s/\[VERSION\]/$_VERSION/g" ./appengine-v1/gae-template.yaml
sed -i -- "s/\[PATH\]/$_PATH/g" ./appengine-v1/gae-template.yaml
sed -i -- "s/\[DEPLOYMENTTYPE\]/$_DEPLOYMENTTYPE/g" ./appengine-v1/gae-template.yaml

gcloud deployment-manager deployments create $_DEPLOYMENT_NAME_GAE --config ./appengine-v1/gae-template.yaml
}

# function 4
# Only Flexible env
# After pulling docker images on another projects, push images $_RESULT_PROJECT_ID
# 1. Pulling image from DM project
# 2. Pushing image into Container registry on App-engine project
push_img() {
_CLEANSING_PATH=${_PATH//\\/}
_CLEANSING_PATH_PROJECT_CHANGE=${_CLEANSING_PATH/$_SOURCE_PROJECT_ID/$_RESULT_PROJECT_ID}
_CLEANSING_PATH_PROJECT_CHANGE_ADD_BACKSLASH=${_CLEANSING_PATH_PROJECT_CHANGE//\//\\\/}
docker pull $_CLEANSING_PATH
docker tag $_CLEANSING_PATH $_CLEANSING_PATH_PROJECT_CHANGE
gcloud docker -- push $_CLEANSING_PATH_PROJECT_CHANGE
_PATH=$_CLEANSING_PATH_PROJECT_CHANGE_ADD_BACKSLASH
}

# function 5
# Check regular expression to get parameter before preprocessing.
chk_parm_exp() {
	# Check ProjectId-Regular-Expression
	if [[ $_SOURCE_PROJECT_ID =~ ^[a-zA-Z0-9-]{4,30}$ ]] ;
	then
		if [[ $_RESULT_PROJECT_ID =~ ^[a-zA-Z0-9-]{4,30}$ ]] ;
		then
			# Check OrganizationId-Regular-Expression
			if [[ `echo $_ORGANIZATION_ID | tr -d \"`  =~ ^[0-9]{8,25}$ ]] ;
			then
				# Check BillingAcountId
				if [[ $_BILLING_ACCOUNT_NAME =~ ^[0-9A-Z]{6}-[0-9A-Z]{6}-[0-9A-Z]{6}$ ]] ;
				then
					return 0
				fi
			fi
		fi
	fi	

	# Exiting Abnormally
	return 1
}

# function 6
# Backup configuration files before modifying.
backup_conf() {
	cp -p ./project_creation/config.yaml /tmp/$_RESULT_PROJECT_ID'-'config'-'`date +'%Y%m%d%H%M%S'`
	cp -p ./appengine-v1/gae-template.yaml /tmp/$_RESULT_PROJECT_ID'-'gae-template'-'`date +'%Y%m%d%H%M%S'`
}

#function 7
# Return to initial state 
restore_conf() {
	cp -p /tmp/$_RESULT_PROJECT_ID'-'config* ./project_creation/config.yaml
	cp -p /tmp/$_RESULT_PROJECT_ID'-'gae-template* ./appengine-v1/gae-template.yaml
}

#function 8
# Delete temporary files
delete_tmpfiles() {
	rm -f /tmp/$_RESULT_PROJECT_ID'-'config*
	rm -f /tmp/$_RESULT_PROJECT_ID'-'gae-template*
}

