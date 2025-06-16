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
  # Serve the site.
  export HYPER_CONFIG=site.yaml
  hyperctl server -i dev
}

set -euo pipefail
main "$@"
