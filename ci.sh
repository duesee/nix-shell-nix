#!/usr/bin/env bash

set -euxo pipefail

nix fmt
statix check
deadnix
