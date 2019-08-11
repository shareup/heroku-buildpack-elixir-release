#!/usr/bin/env bash

set -e
set -x

cd $(dirname ${0:-})

while IFS=, read -r otp_patch_version _otp_minor_version _otp_major_version; do
  while IFS=, read -r patch_version _minor_version; do
    ./build_version.sh "$otp_patch_version" "$patch_version"
    break # only do the first one right now
  done < versions.csv
  break # only do the first one right now
done < ../otp/versions.csv
