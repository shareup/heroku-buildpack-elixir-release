# Buildpack for building elixir application releases

Includes build scripts for building all OTP releases `>= 20.0` and all elixir releases `>= 1.9.0`.

## Usage

Set your buildpack in your `app.json`:

```json
{
  "buildpacks": [
    {
      "url": "https://github.com/shareup/heroku-buildpack-elixir-release.git"
    }
  ]
}
```

And set your elixir and OTP versions as ENV variables. Go ahead and use your `app.json`:

```json
{
  "env": {
    "OTP_VERSION": "22.0.7",
    // can provide "22_0" or "22" to auto-upgrade to newer patch or minor releases
    //   /we are using "22_0" becuase "22.0" is a real version number (no patch was included)/
    // default is "22"

    "ELIXIR_VERSION": "1.9.1",
    // can provide "1.9" to auto-upgrade to newer patch releases
    // default is "1.9"

    "NODE_VERSION": "10.16.0",
    // node versions must be exact - prebuilt binaries are fetched from the official project site
    // default is "12.6.0"

    "NPM_VERSION": "6.10.1",
    // npm versions must be exact - prebuilt binaries are fetched from the official project site
    // default is "6.10.1"

    "SKIP_NODE": "false",
    // setting SKIP_NODE=true will prevent nodejs from being installed
    // default is "false"

    "ALWAYS_REBUILD": "false"
    // setting ALWAYS_REBUILD=true will skip the build cache and re-compile everything including elixir
    // default is "false"
  }
}
```

## Why create this yourself?

1. I want to use elixir releases for my app on heroku
2. Using other people's binaries for production isn't something I want to do


