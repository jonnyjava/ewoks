# Install dependencies
# sudo apt-get install python-pip python-dev build-essential zip -y
# sudo pip install awscli

# export APP_VERSION=`git rev-parse --short HEAD`
# export APP_VERSION=`git describe --tags`
HASH_LAST_COMMIT=`git rev-parse --short HEAD`
LAST_TAG=`git describe --tags --always`
echo $HASH_LAST_COMMIT
echo $LAST_TAG
# git clean -fd
# zip -x *.git* -r "${APP_NAME}-${APP_VERSION}.zip" .
# aws elasticbeanstalk delete-application-version --application-name "${APP_NAME}" --version-label "${APP_VERSION}"  --delete-source-bundle
# aws s3 cp ${APP_NAME}-${APP_VERSION}.zip s3://${S3_BUCKET}/${APP_NAME}-${APP_VERSION}.zip
# aws elasticbeanstalk create-application-version --application-name "${APP_NAME}" --version-label "${APP_VERSION}" --source-bundle S3Bucket="${S3_BUCKET}",S3Key="${APP_NAME}-${APP_VERSION}.zip"
# aws elasticbeanstalk update-environment --environment-name "${ENV_NAME}" --version-label "${APP_VERSION}"
