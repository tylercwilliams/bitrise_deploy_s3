#!/bin/bash

#
# --- Export Environment Variables for other Steps:
# You can export Environment Variables for other Steps with
#  envman, which is automatically installed by `bitrise setup`.
# A very simple example:
#  envman add --key EXAMPLE_STEP_OUTPUT --value 'the value you want to share'
# Envman can handle piped inputs, which is useful if the text you want to
# share is complex and you don't want to deal with proper bash escaping:
#  cat file_with_complex_input | envman add --KEY EXAMPLE_STEP_OUTPUT
# You can find more usage examples on envman's GitHub page
#  at: https://github.com/bitrise-io/envman

#
# --- Exit codes:
# The exit code of your Step is very important. If you return
#  with a 0 exit code `bitrise` will register your Step as "successful".
# Any non zero exit code will be registered as "failed" by `bitrise`.


export AWS_ACCESS_KEY="${aws_access_key}"
export AWS_SECRET_ACCESS_KEY="${aws_secret_key}"

echo "$ aws s3 cp ${local_folder} ${s3_bucket} --recursive --exclude '*' --include '*.apk'"
aws s3 cp ${local_folder} ${s3_bucket}/${s3_folder_tag} --recursive --exclude "*" --include "*.apk"

envman add --key S3_DOWNLOAD_FOLDER --value '${s3_bucket}/${s3_folder_tag}'

exit 0
