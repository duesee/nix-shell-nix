#!/usr/bin/env bash

set -euxo pipefail

shopt -s globstar
nixfmt **/*.nix

statix check

deadnix
