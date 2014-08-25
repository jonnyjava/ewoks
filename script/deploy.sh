#!/bin/bash

# Declare variables
HASH_LAST_COMMIT=`git rev-parse --short HEAD`
LAST_TAG=`git describe --tags --always`

# Define app versión
export APP_VERSION=$LAST_TAG

# Check
if [[ $LAST_TAG == *$HASH_LAST_COMMIT* ]]
then
  export ENV_NAME='test'
else
  export ENV_NAME='production'
fi

# Install dependencies
sudo apt-get install python-pip python-dev build-essential zip -y
sudo pip install awscli

# Clean project to deploy and compress in zip
git clean -fXd
zip -x *.git* -r "${APP_NAME}-${APP_VERSION}.zip" .

# Upload to AWS
aws elasticbeanstalk delete-application-version --application-name "${APP_NAME}" --version-label "${APP_VERSION}"  --delete-source-bundle
aws s3 cp ${APP_NAME}-${APP_VERSION}.zip s3://${S3_BUCKET}/${APP_NAME}-${APP_VERSION}.zip
aws elasticbeanstalk create-application-version --application-name "${APP_NAME}" --version-label "${APP_VERSION}" --source-bundle S3Bucket="${S3_BUCKET}",S3Key="${APP_NAME}-${APP_VERSION}.zip"
aws elasticbeanstalk update-environment --environment-name "${ENV_NAME}" --version-label "${APP_VERSION}"
