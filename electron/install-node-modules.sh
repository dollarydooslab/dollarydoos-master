#!/usr/bin/env bash
set -e -o pipefail

# installs the node modules for the dollarydoos electron app
# NOT for the electron build process

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd "$SCRIPTDIR" >/dev/null

cd src/
yarn

popd >/dev/null
