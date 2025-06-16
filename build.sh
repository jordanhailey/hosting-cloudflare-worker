#!/usr/bin/env bash

#------------------------------------------------------------------------------
# @file
# Builds a HyperTemplates site hosted on a Cloudflare Worker.
#
# The Cloudflare Worker build image already includes Go,
# and Node js. Set the desired HyperTemplates CLI version below.
#
# The Cloudflare Worker automatically installs Node.js dependencies.
#------------------------------------------------------------------------------

main() {

  HYPERTEMPLATES_VERSION=0.14.2
  arch=$(uname -m)
  if [[ "$arch" == "x86_64" ]]; then
      export export LINUX_ARCHITECTURE="amd64"
  elif [[ "$arch" == "arm64" || "$arch" == "aarch64" ]]; then
      export export LINUX_ARCHITECTURE="arm64"
  else
      echo "Unsupported architecture: $arch"
      exit 1
  fi

  export TZ=America/Los_Angeles

  # Install HyperTemplates

  echo "Installing HyperTemplates v${HYPERTEMPLATES_VERSION}..."

  # https://hypertemplates.net/downloads/hyperctl_0.14.2_linux_arm64.tar.gz
  curl -LO https://hypertemplates.net/downloads/hyperctl_${HYPERTEMPLATES_VERSION}_linux_${LINUX_ARCHITECTURE}.tar.gz
  tar -xzf hyperctl_${HYPERTEMPLATES_VERSION}_linux_${LINUX_ARCHITECTURE}.tar.gz
  chmod +x hyperctl
  cp hyperctl /opt/buildhome
  rm hyperctl hyperctl_${HYPERTEMPLATES_VERSION}_linux_${LINUX_ARCHITECTURE}.tar.gz
  export HYPER_CONFIG=site.yaml

  # Set PATH
  echo "Setting the PATH environment variable..."
  export PATH=/opt/buildhome:$PATH

  # Verify installed versions
  echo "Verifying installations..."
  echo Go: "$(go version)"
  echo HyperTemplates: "$(hyperctl)"
  echo Node.js: "$(node --version)"

  # Build the site.
  hyperctl build -i site

}

set -euo pipefail
main "$@"
