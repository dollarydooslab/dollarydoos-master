# dollarydoos build
# reference https://github.com/dollarydooslab/dollarydoos
FROM golang:1.10 AS build

ARG dollarydoos_VERSION

COPY . $GOPATH/src/github.com/dollarydooslab/dollarydoos

# This code checks if dollarydoos_VERSION is set and checkouts to that version if
# so. The git stash line prevents the build to fail if there are any uncommited
# changes in the working copy. It won't affect the host working copy.
RUN sh -c \
    'if test ${dollarydoos_VERSION};then \
        echo "Revision is set to: "${dollarydoos_VERSION}; \
        cd $GOPATH/src/github.com/dollarydooslab/dollarydoos; \
        git stash; \
        git checkout ${dollarydoos_VERSION}; \
     fi'

RUN cd $GOPATH/src/github.com/dollarydooslab/dollarydoos && \
  CGO_ENABLED=0 GOOS=linux go install -a -installsuffix cgo ./...

# dollarydoos image
FROM alpine:3.7

ENV COIN="dollarydoos"
ENV RPC_ADDR="0.0.0.0:8650" \
    DATA_DIR="/data/.$COIN" \
    WALLET_DIR="/wallet" \
    WALLET_NAME="$COIN_cli.wlt"

# copy all the binaries
COPY --from=build /go/bin/* /usr/bin/

# copy assets
COPY --from=build /go/src/github.com/dollarydooslab/dollarydoos/src/gui/static /usr/local/dollarydoos/src/gui/static

# copy launcher
COPY docker_launcher.sh /usr/local/bin

# volumes
VOLUME $WALLET_DIR
VOLUME $DATA_DIR

EXPOSE 8858 8640 8650

ENTRYPOINT ["docker_launcher.sh", "--web-interface-addr=0.0.0.0", "--rpc-interface-addr=0.0.0.0", "--gui-dir=/usr/local/dollarydoos/src/gui/static"]
