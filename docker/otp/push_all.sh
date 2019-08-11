#!/usr/bin/env bash

set -e
set -x

cd $(dirname ${0:-})

export BUCKET="${BUCKET:-heroku-buildpack-elixir-release-default}"
export ACL="${ACL:-public-read}"

build_and_upload() {
  local patch_version="$1"
  local minor_version="$2"
  local major_version="$3"
  local filename="OTP-$patch_version.tar.gz"
  local s3_filename="s3://$BUCKET/$filename"

  ./build_version.sh "$patch_version"

  aws s3 cp "builds/$filename" "$s3_filename" --acl "$ACL"

  if [[ "$minor_version" != "" ]]; then
    aws s3 cp "$s3_filename" "s3://$BUCKET/OTP-$minor_version.tar.gz" --acl "$ACL"
  fi

  if [[ "$major_version" != "" ]]; then
    aws s3 cp "$s3_filename" "s3://$BUCKET/OTP-$major_version.tar.gz" --acl "$ACL"
  fi
}

while IFS=, read -r patch_version minor_version major_version; do
  build_and_upload "$patch_version" "$minor_version" "$major_version"
  break # only do the first one for now
done < versions.csv
