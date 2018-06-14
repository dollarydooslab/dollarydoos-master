#!/bin/sh
COMMAND="dollarydoos --data-dir $DATA_DIR --wallet-dir $WALLET_DIR $@"

adduser -D -u 10000 dollarydoos

if [[ \! -d $DATA_DIR ]]; then
    mkdir -p $DATA_DIR
fi
if [[ \! -d $WALLET_DIR ]]; then
    mkdir -p $WALLET_DIR
fi

chown -R dollarydoos:dollarydoos $( realpath $DATA_DIR )
chown -R dollarydoos:dollarydoos $( realpath $WALLET_DIR )

su dollarydoos -c "$COMMAND"
