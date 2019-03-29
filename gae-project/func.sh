#!/bin/sh

# function 1
create_project() {
sed -i -- "s/\[PROJECT_ID\]/$_RESULT_PROJECT_ID/g" ./project_creation/config.yaml
sed -i -- "s/\[ORGANIZATION_ID\]/$_ORGANIZATION_ID/g" ./project_creation/config.yaml
sed -i -- "s/\[BILLING_ACCOUNT_NAME\]/$_BILLING_ACCOUNT_NAME/g" ./project_creation/config.yaml

gcloud config set project $_SOURCE_PROJECT_ID
gcloud deployment-manager deployments create $_DEPLOYMENT_NAME_DM --config ./project_creation/config.yaml

sed -i -- "s/$_RESULT_PROJECT_ID/\[PROJECT_ID\]/g" ./project_creation/config.yaml
sed -i -- "s/$_ORGANIZATION_ID/\[ORGANIZATION_ID\]/g" ./project_creation/config.yaml
sed -i -- "s/$_BILLING_ACCOUNT_NAME/\[BILLING_ACCOUNT_NAME\]/g" ./project_creation/config.yaml
}

# function 2
create_app() {
gcloud config set project $_RESULT_PROJECT_ID
gcloud app create --region=$_REGION
}

# function 3
deploy_app() {
sed -i -- "s/\[PROJECT\]/$_RESULT_PROJECT_ID/g" ./appengine-v1/gae-template.yaml
sed -i -- "s/\[ZONE\]/$_ZONE/g" ./appengine-v1/gae-template.yaml
sed -i -- "s/\[RUNTIME\]/$_RUNTIME/g" ./appengine-v1/gae-template.yaml

gcloud deployment-manager deployments create $_DEPLOYMENT_NAME_GAE --config ./appengine-v1/gae-template.yaml

sed -i -- "s/$_RESULT_PROJECT_ID/\[PROJECT\]/g" ./appengine-v1/gae-template.yaml
sed -i -- "s/$_ZONE/\[ZONE\]/g" ./appengine-v1/gae-template.yaml
sed -i -- "s/$_RUNTIME/\[RUNTIME\]/g" ./appengine-v1/gae-template.yaml
}
