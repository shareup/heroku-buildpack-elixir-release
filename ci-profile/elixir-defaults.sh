#!/usr/bin/env bash

export PATH="$HOME/.heroku/elixir/bin:$HOME/.heroku/erlang/bin:$HOME/.heroku/node/bin:$HOME/bin:$PATH"
export NODE_HOME="$HOME/.heroku/node"
export MIX_HOME="/app/.mix"
export HEX_HOME="/app/.hex"
export LANG="${LANG:-en_US.utf8}"
export LC_CTYPE="${LC_TYPE:-en_US.utf8}"
export MIX_ENV=${MIX_ENV:-test}
