#!/usr/bin/env bash

MIX_APP_NAME=$(cat /app/MIX_APP_NAME)
RELEASE_NAME="${RELEASE_NAME:-"${MIX_APP_NAME}"}"

/app/_build/$MIX_ENV/rel/$RELEASE_NAME/bin/$RELEASE_NAME $@
