
# Skycoin C client library

[![Build Status](https://travis-ci.org/dollarydoos/dollarydoos.svg)](https://travis-ci.org/dollarydoos/dollarydoos)
[![GoDoc](https://godoc.org/github.com/dollarydooslab/dollarydoos?status.svg)](https://godoc.org/github.com/dollarydooslab/dollarydoos)
[![Go Report Card](https://goreportcard.com/badge/github.com/dollarydooslab/dollarydoos)](https://goreportcard.com/report/github.com/dollarydooslab/dollarydoos)

Skycoin C client library (a.k.a libdollarydoos) provides access to Skycoin Core
internal and API functions for implementing third-party applications.

## API Interface

The API interface is defined in the [libdollarydoos header file](/include/libdollarydoos.h).

## Building

```sh
$ make build-libc
```

## Testing

In order to test the C client libraries follow these steps

- Install [Criterion](https://github.com/Snaipe/Criterion)
  * locally by executing `make instal-deps-libc` command
  * or by [installing Criterion system-wide](https://github.com/Snaipe/Criterion#packages)
- Run `make test-libc` command

## Binary distribution

The following files will be generated

- `include/libdollarydoos.h` - Platform-specific header file for including libdollarydoos symbols in your app code
- `build/libdollarydoos.a` - Static library.
- `build/libdollarydoos.so` - Shared library object.

In Mac OS X the linker will need extra `-framework CoreFoundation -framework Security`
options.

In GNU/Linux distributions it will be necessary to load symbols in `pthread`
library e.g. by supplying extra `-lpthread` to the linker toolchain.

