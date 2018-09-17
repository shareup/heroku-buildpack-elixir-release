#!/usr/bin/env bash

warnings=$(mktemp -t heroku-buildpack-elixir-XXXX)

warning() {
  local tip="${1:-}"
  local url=${2:-https://github.com/shareup-app/heroku-buildpack-elixir}
  echo "- $tip" >> $warnings
  echo "  $url" >> $warnings
  echo "" >> $warnings
}

failure_message() {
  local warn="$(cat $warnings)"
  echo ""
  echo "Sorry..."
  echo ""
}
