#!/bin/bash

# 0. Set the DM-project name and App-engine-project name.
#    source project : The dm project was installed Deployment manager
#    result project : New project will be deployed gae-apps
_SOURCE_PROJECT_ID=$1
_RESULT_PROJECT_ID=$2

# 1. Set the variable with about project.
_DEPLOYMENT_NAME_DM=$3
_ORGANIZATION_ID="\"$4\""
_BILLING_ACCOUNT_NAME=$5

# 2. Set the variable with about app-engine.
_DEPLOYMENT_NAME_GAE=$6
_ZONE=$7
_REGION=`echo $_ZONE | tr '/' '\t' | awk '{print $1}'`
_LOCAL=`echo $_ZONE | tr '/' '\t' | awk '{print $2}'`
_RUNTIME=$8
_VERSION=$9
_PATH=${10//\//\\\/}
_DEPLOYMENTTYPE=${11}
