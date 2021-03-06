#!/usr/bin/env bash

set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "dollarydoos binary dir:" "$DIR"
pushd "$DIR" >/dev/null

COMMIT=$(git rev-parse HEAD)
BRANCH=$(git rev-parse --abbrev-ref HEAD)
GOLDFLAGS="-X main.Commit=${COMMIT} -X main.Branch=${BRANCH}"

go run -ldflags "${GOLDFLAGS}" cmd/dollarydoos/dollarydoos.go \
    -gui-dir="${DIR}/src/gui/static/" \
    -launch-browser=true \
    -enable-wallet-api=true \
    -rpc-interface=false \
    -log-level=debug \
    $@

popd >/dev/null
