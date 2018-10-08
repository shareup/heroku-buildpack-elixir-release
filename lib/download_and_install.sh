#!/usr/bin/env bash

download_and_install_erlang() {
  local otp_version="$1"
  local install_dir="$2"
  local cache_dir="$3"

  local region="${S3_REGION:-us-west-1}"
  local bucket="${S3_BUCKET:-heroku-buildpack-elixir-release-default}"

  mkdir -p "$install_dir"
  mkdir -p "$cache_dir"

  local filename="OTP-$otp_version.tar.gz"
  local url="https://s3-$region.amazonaws.com/$bucket/$filename"
  local tarpath="$cache_dir/$filename"

  if [ ! -f "$tarpath" ]; then
    rm -rf "$cache_dir/*"
    rm -rf "$install_dir/*"

    echo "Downloading OTP $otp_version"
    curl -# -f "$url" -o "$tarpath"
  else
    echo "Using cached OTP $otp_version"
  fi

  tar xf "$tarpath" -C "$install_dir"

  # unpack the release
  chmod +x "$install_dir/Install"
  $install_dir/Install -minimal "$install_dir"

  export PATH="$install_dir/bin:$PATH"
}

download_and_install_elixir() {
  local elixir_version="$1"
  local otp_version="$2"
  local install_dir="$3"
  local cache_dir="$4"

  local region="${S3_REGION:-us-west-1}"
  local bucket="${S3_BUCKET:-heroku-buildpack-elixir-release-default}"

  mkdir -p "$install_dir"
  mkdir -p "$cache_dir"

  local filename="elixir-$elixir_version-OTP-$otp_version.tar.gz"
  local url="https://s3-$region.amazonaws.com/$bucket/$filename"
  local tarpath="$cache_dir/$filename"

  if [ ! -f "$tarpath" ]; then
    rm -rf "$cache_dir/*"
    rm -rf "$install_dir/*"

    echo "Downloading elixir $elixir_version"
    curl -# -f "$url" -o "$tarpath"
  else
    echo "Using cached elixir $elixir_version"
  fi

  tar xf "$tarpath" -C "$install_dir"

  chmod +x $install_dir/bin/*

  export PATH="$install_dir/bin:$PATH"
}

download_and_install_node() {
  local node_version="$1"
  local npm_version="$2"
  local install_dir="$3"
  local cache_dir="$4"

  mkdir -p "$install_dir"
  mkdir -p "$cache_dir"

  local os="$(uname | tr A-Z a-z)"
  local filename="node-v$node_version-linux-x64.tar.gz"
  local url="https://nodejs.org/dist/v$node_version/$filename"
  local tarpath="$cache_dir/$filename"

  if [ ! -f "$tarpath" ]; then
    echo "Downloading node"
    curl -# -L -f "$url" -o "$tarpath"
  else
    echo "Using cached node $node_version"
  fi

  tar xf "$tarpath" -C "$install_dir" --strip-components=1

  chmod +x $install_dir/bin/*

  export PATH="$install_dir/bin:$PATH"

  if [[ `npm --version` != "$npm_version" ]]; then
    echo "Updating npm to $npm_version"
    npm install --unsafe-perm --quiet -g npm@$npm_version
  fi
}
