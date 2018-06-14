#!/bin/bash
# Runs "stable"-mode tests against a dollarydoos node configured with a pinned database
# "stable" mode tests assume the blockchain data is static, in order to check API responses more precisely
# $TEST defines which test to run i.e, cli or gui; If empty both are run

#Set Script Name variable
SCRIPT=`basename ${BASH_SOURCE[0]}`
PORT="46420"
RPC_PORT="46430"
HOST="http://127.0.0.1:$PORT"
RPC_ADDR="127.0.0.1:$RPC_PORT"
MODE="stable"
BINARY="dollarydoos-integration"
TEST=""
UPDATE=""
# run go test with -v flag
VERBOSE=""
# run go test with -run flag
RUN_TESTS=""

COMMIT=$(git rev-parse HEAD)
BRANCH=$(git rev-parse --abbrev-ref HEAD)
GOLDFLAGS="-X main.Commit=${COMMIT} -X main.Branch=${BRANCH}"

usage () {
  echo "Usage: $SCRIPT"
  echo "Optional command line arguments"
  echo "-t <string>  -- Test to run, gui or cli; empty runs both tests"
  echo "-r <string>  -- Run test with -run flag"
  echo "-u <boolean> -- Update stable testdata"
  echo "-v <boolean> -- Run test with -v flag"
  exit 1
}

while getopts "h?t:r:uvw" args; do
  case $args in
    h|\?)
        usage;
        exit;;
    t ) TEST=${OPTARG};;
    r ) RUN_TESTS="-run ${OPTARG}";;
    u ) UPDATE="--update";;
    v ) VERBOSE="-v";;
  esac
done

set -euxo pipefail

DATA_DIR=$(mktemp -d -t dollarydoos-data-dir.XXXXXX)
WALLET_DIR="${DATA_DIR}/wallets"

if [[ ! "$DATA_DIR" ]]; then
  echo "Could not create temp dir"
  exit 1
fi

# Compile the dollarydoos node
# We can't use "go run" because this creates two processes which doesn't allow us to kill it at the end
echo "compiling dollarydoos"
go build -o "$BINARY" -ldflags "${GOLDFLAGS}" cmd/dollarydoos/dollarydoos.go

# Run dollarydoos node with pinned blockchain database
echo "starting dollarydoos node in background with http listener on $HOST"

./dollarydoos-integration -disable-networking=true \
                      -web-interface-port=$PORT \
                      -download-peerlist=false \
                      -db-path=./src/gui/integration/test-fixtures/blockchain-180.db \
                      -db-read-only=true \
                      -rpc-interface=true \
                      -rpc-interface-port=$RPC_PORT \
                      -launch-browser=false \
                      -data-dir="$DATA_DIR" \
                      -enable-wallet-api=true \
                      -wallet-dir="$WALLET_DIR" \
                      -enable-seed-api=true &
dollarydoos_PID=$!

echo "dollarydoos node pid=$dollarydoos_PID"

echo "sleeping for startup"
sleep 3
echo "done sleeping"

set +e

if [[ -z $TEST || $TEST = "gui" ]]; then

dollarydoos_INTEGRATION_TESTS=1 dollarydoos_INTEGRATION_TEST_MODE=$MODE dollarydoos_NODE_HOST=$HOST \
    go test ./src/gui/integration/... $UPDATE -timeout=3m $VERBOSE $RUN_TESTS

GUI_FAIL=$?

fi

if [[ -z $TEST  || $TEST = "cli" ]]; then

dollarydoos_INTEGRATION_TESTS=1 dollarydoos_INTEGRATION_TEST_MODE=$MODE RPC_ADDR=$RPC_ADDR \
    go test ./src/api/cli/integration/... $UPDATE -timeout=3m $VERBOSE $RUN_TESTS

CLI_FAIL=$?

fi


echo "shutting down dollarydoos node"

# Shutdown dollarydoos node
kill -s SIGINT $dollarydoos_PID
wait $dollarydoos_PID

rm "$BINARY"


if [[ (-z $TEST || $TEST = "gui") && $GUI_FAIL -ne 0 ]]; then
  exit $GUI_FAIL
elif [[ (-z $TEST || $TEST = "cli") && $CLI_FAIL -ne 0 ]]; then
  exit $CLI_FAIL
else
  exit 0
fi
# exit $FAIL