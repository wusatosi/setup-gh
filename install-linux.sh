#!/bin/bash

# This script installs Github CLI according to the official guide:
# See: https://github.com/cli/cli/blob/trunk/docs/install_linux.md

if type -p gh > /dev/null
then
  echo "Github Cli has already been installed"
else
  echo "::group::Install Github CLI"

  type -p curl >/dev/null || (apt-get update && apt-get install curl -y)

  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
  chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null &&
  apt-get update  && apt-get install gh -y

  echo "::endgroup::"
fi

