#!/usr/bin/env bash

MIX_APP_NAME=$(cat /app/MIX_APP_NAME)
MIX_APP_VERSION=$(cat /app/MIX_APP_VERSION)

/app/_build/$MIX_ENV/rel/$MIX_APP_NAME/releases/$MIX_APP_VERSION/$MIX_APP_NAME.sh foreground
