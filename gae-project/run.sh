#!/bin/sh

# Create project for google-app-engine Application.

# 1. import file
# env-variables.sh : Import environment-variables for using in func.sh 
# func.sh : Import function was consist of create, try-catch ...etc 
. ./env-variables.sh
. ./func.sh

# 2. Set the project_id in config.yaml before creating.
#    After setting, perfome creating-project as using the tool was named "deployment-manager".
#    reset to the original state.
create_project

# 3. Make application in the project. ($_RESULT_PROJECT_ID)
create_app

# 4. After change the project, Deploy gae-application.
deploy_app
