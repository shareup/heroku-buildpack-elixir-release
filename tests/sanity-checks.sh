#!/usr/bin/env bash

set -e

BUILD_DIR="${1:-}"

echo "Running sanity checks..."

fail_test() {
  echo "F"
  echo "$1"
  exit 1
}

pass_test() {
  echo -n "+"
  echo ""
}

echo "Checking for elixir_release symlink"

if [[ ! -f "$BUILD_DIR/bin/boot_release" ]]; then
  fail_test "Could not find release symlink"
else
  pass_test
fi
