#!/usr/bin/env bash

function check_stack() {
  local cache_dir="$1"
  local stack="$2"

  if [ "$stack" = "cedar" ]; then
    echo "ERROR: cedar stack is not supported, upgrade to cedar-14"
    exit 1
  fi

  if [ ! -f "$cache_dir/stack" ] || [ $(cat "$cache_dir/stack") != "$stack" ]; then
    echo "Stack changed, will rebuild"
    rm -rf "$cache_dir/*"
  fi

  echo "$stack" > "$cache_dir/stack"
}
