#!/bin/sh

# Create project for google-app-engine Application.

# 0. Set the DM-project name and App-engine-project name. 
#    source project : The dm project was installed Deployment manager
#    result project : New project will be deployed gae-apps   
_SOURCE_PROJECT_ID=dm-creation-project-0001 
_RESULT_PROJECT_ID=utapp-9545

# 1. Set the variable with about project.
_DEPLOYMENT_NAME_DM=$_RESULT_PROJECT_ID
_ORGANIZATION_ID='\"588563882980\"'
_BILLING_ACCOUNT_NAME=016F9C-C22464-EDEA07

# 2. Set the variable with about app-engine.
_APP_NAME=app1
_DEPLOYMENT_NAME_GAE=$_DEPLOYMENT_NAME_DM'-'$_APP_NAME
_REGION=asia-northeast1
_LOCAL=a
_ZONE=$_REGION'-'$_LOCAL
_RUNTIME=python27

# 3. Set the project_id in config.yaml before creating.
#    After setting, perfome creating-project as using the tool was named "deployment-manager".
#    reset to the original state.
sed -i -- "s/\[PROJECT_ID\]/$_RESULT_PROJECT_ID/g" ./project_creation/config.yaml
sed -i -- "s/\[ORGANIZATION_ID\]/$_ORGANIZATION_ID/g" ./project_creation/config.yaml
sed -i -- "s/\[BILLING_ACCOUNT_NAME\]/$_BILLING_ACCOUNT_NAME/g" ./project_creation/config.yaml

gcloud config set project $_SOURCE_PROJECT_ID
gcloud deployment-manager deployments create $_DEPLOYMENT_NAME_DM --config ./project_creation/config.yaml

sed -i -- "s/$_RESULT_PROJECT_ID/\[PROJECT_ID\]/g" ./project_creation/config.yaml
sed -i -- "s/$_ORGANIZATION_ID/\[ORGANIZATION_ID\]/g" ./project_creation/config.yaml
sed -i -- "s/$_BILLING_ACCOUNT_NAME/\[BILLING_ACCOUNT_NAME\]/g" ./project_creation/config.yaml

# 4. Make application in the project. ($_RESULT_PROJECT_ID)
gcloud config set project $_RESULT_PROJECT_ID
gcloud app create --region=$_REGION

# 5. After change the project, Deploy gae-application.
sed -i -- "s/\[PROJECT\]/$_RESULT_PROJECT_ID/g" ./appengine-v1/gae-template.yaml
sed -i -- "s/\[ZONE\]/$_ZONE/g" ./appengine-v1/gae-template.yaml
sed -i -- "s/\[RUNTIME\]/$_RUNTIME/g" ./appengine-v1/gae-template.yaml

gcloud deployment-manager deployments create $_DEPLOYMENT_NAME_GAE --config ./appengine-v1/gae-template.yaml

sed -i -- "s/$_RESULT_PROJECT_ID/\[PROJECT\]/g" ./appengine-v1/gae-template.yaml
sed -i -- "s/$_ZONE/\[ZONE\]/g" ./appengine-v1/gae-template.yaml
sed -i -- "s/$_RUNTIME/\[RUNTIME\]/g" ./appengine-v1/gae-template.yaml
