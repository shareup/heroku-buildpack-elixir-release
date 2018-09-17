#!/usr/bin/env bash

download_and_install_erlang() {
  local otp_version="$1"
  local install_dir="$2"
  local cache_dir="$3"

  local filename="OTP-$otp_version.tar.gz"
  local url="https://s3.amazonaws.com/heroku-buildpack-elixir/erlang/cedar-14/$filename"
  local tarpath="$cache_dir/$filename"
  local build_dir="$cache_dir/build/"

  if [ ! -f "$tarpath" ]; then
    rm -rf "$cache_dir/*"
    rm -rf "$install_dir/*"

    echo "Downloading OTP $otp_version"
    curl -s "$url" -o "$tarpath" || (echo "Unable to download erlang" && exit 1)

    tar xzf "$tarpath" -C "$buildpath" --strip-components=1
    $build_path/Install -minimal "$install_dir"

    chmod +x "$install_dir/bin/*"
    export PATH="$install_dir/bin:$PATH"
  else
    echo "Using cached OTP $otp_version"
  fi
}

download_and_install_elixir() {
  local elixir_version="$1"
  local otp_version="$2"
  local install_dir="$3"
  local cache_dir="$4"

  # Prefix with a 'v' if not present
  if [[ "$elixir_version" =~ ^[0-9]+\.[0-9]+ ]]; then
    elixir_version="v$elixir_version"
  fi

  local filename="$elixir_version-otp-$otp_version.zip"
  local url="https://repo.hex.pm/builds/elixir/v$filename"
  local tarpath="$cache_dir/$filename"
  local build_dir="$cache_dir/build/"

  if [ ! -f "$tarpath" ]; then
    rm -rf "$cache_dir/*"
    rm -rf "$install_dir/*"

    echo "Downloading elixir $elixir_version"
    curl -s "$url" -o "$tarpath"

    if [ "$?" -ne "0" ]; then
      echo "Unable to download an elixir for OTP $otp_version, falling back to generic elixir version"
      local fallback_url="https://repo.hex.pm/builds/elixir/$elixir_version.zip"
      curl -s "$fallback_url" -o "$tarpath" || (echo "Unable to download elixir" && exit 1)
    fi

    unzip -q "$tarpath" -d "$install_dir/"

    chmod +x "$install_dir/bin/*"
    export PATH="$install_dir/bin:$PATH"
  else
    echo "Using cached elixir $elixir_version"
  fi
}
