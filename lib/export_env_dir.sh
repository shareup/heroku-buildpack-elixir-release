#!/usr/bin/env bash

export_env_dir() {
  local env_dir="$1"

  if [ -d "$env_dir" ]; then
    for e in $(ls $env_dir); do
      echo "$e"
      echo "$e" | grep -qv '^PATH$\|^GIT_DIR$\|^CPATH$\|^CPPATH$\|^LD_PRELOAD$\|^LIBRARY_PATH$' && export $e=$(cat $env_dir/$e)
    done
  fi
}
