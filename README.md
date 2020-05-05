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

## Example usage scenarios
```bash
$ ./stanley init
$ ./stanley require user/example_repo
# require repo with the same name from another hosting source
$ ./stanley require user/example_repo --source https://another_hosting.io/
$ ./stanley update
$ ./stanley dump
```

```bash
$ cp /some/example/package.yaml ./package.yaml
$ ./stanley install # alias for: ./stanley update && ./stanley dump
```

# Building from source

## Additional requirements
* __GNU Make__
* [Stanley](https://wolf2789.github.io/Stanley/)

```bash
$ git clone https://github.com/Stanley-lua/lexe.git
$ make
```

# TODO
* Fix bugs if any
* Resolve recurrent package dependencies.
* Add functionality for currently unused fields.

