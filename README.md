# LEXE
Lua source bundler and compiler.

# Installation

## Requirements
* __*nix__ system
* __Lua__ at least 5.2.4

# Usage
    Usage: lexe [options] command

    Available commands:

        build     Compile source into binary.
        clean     Delete build directory.
        help      Show this message.

    Optional arguments:

        --build, -b    Change build directory path.
                    type: string default: ./build

        --entry, -e    Change path for entry file.
                    type: string default: ./src/init.lua

        --output, -o   Set name for compiled executable.
                    type: string default: stanley

## Example usage:
```bash
$ lexe -b ./build -o exe_file -e ./src/main.lua build
$ cp ./build/exe_file /usr/local/bin/
$ lexe -b ./build clean
```
> Also take a look at [Makefile](./Makefile)

# Building from source

## Additional requirements
* __GNU Make__
* [Stanley](https://stanley-lua.github.io/)

```bash
$ git clone https://github.com/Stanley-lua/lexe.git
$ make
```

# TODO
* Fix bugs if any
* ~~Problematic file names handling~~
* ~~Resolve recurrencies~~
