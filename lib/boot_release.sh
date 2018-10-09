#!/usr/bin/env bash

MIX_APP_NAME=$(cat /app/MIX_APP_NAME)

/app/_build/$MIX_ENV/rel/$MIX_APP_NAME/bin/$MIX_APP_NAME $@
