#!/bin/bash

# 0. Set the DM-project name and App-engine-project name.
#    source project : The dm project was installed Deployment manager
#    result project : New project will be deployed gae-apps
_SOURCE_PROJECT_ID=$1
_RESULT_PROJECT_ID=$2

# 1. Set the variable with about project.
_DEPLOYMENT_NAME_DM=$_RESULT_PROJECT_ID
_ORGANIZATION_ID="\"$3\""
_BILLING_ACCOUNT_NAME=$4

# 2. Set the variable with about app-engine.
_APP_NAME=$5
_DEPLOYMENT_NAME_GAE=$_DEPLOYMENT_NAME_DM'-'$_APP_NAME
_REGION=$6
_LOCAL=$7
_ZONE=$_REGION'-'$_LOCAL
_RUNTIME=$8
_VERSION=$9
