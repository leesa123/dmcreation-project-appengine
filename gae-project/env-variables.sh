#!/bin/sh

# 0. Set the DM-project name and App-engine-project name.
#    source project : The dm project was installed Deployment manager
#    result project : New project will be deployed gae-apps
_SOURCE_PROJECT_ID=dm-creation-project-0001
_RESULT_PROJECT_ID=utapp-9547

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
