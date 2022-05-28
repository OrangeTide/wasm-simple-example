# Simple WASM Example

## Introduction

This demonstrats how to use clang to generate WASM binaries without using
Emscripten. There are distinct disadvantages to doing this, but for
demonstration and understand it is a useful exercise.

## Development Workflow and Tips

### Prerequisites

(TODO: install llvm, clang, wabt, etc)

### Building

```sh
make
```

### Running in Development

Hosting your WASM and HTML files through a small webserver is ideal. As out-of-the-box most browsers have security protections when it comes to accessing directly from the file-system.

A simple static webserver is all that you need to begin development with WASM. One choice is the single-file althttpd from the SQLite project.

#### Althttpd

Download `althttpd.c` from https://sqlite.org/althttpd/doc/trunk/althttpd.md and build it. For example:

```sh
gcc -Os -o althttpd -fPIC -DENABLE_TLS ~/Source/althttpd.c -lssl -lcrypto
```

Install it somewhere in your PATH, $HOME/.local/bin/ is useful. Now you can run it:

```sh
althttpd -root ./ -port 8080
```

Now navigate to http://localhost:8080/opc.html and open browser debugger (firefox: CTRL+SHIFT+I)

### Inspecting the Compiled Binary

Inspect our WASM file (or any of the .o files):
```sh
wasm-objdump -x opc.wasm
```

Look at the binary in a structured text format:
```sh
wasm2wat opc.wasm
```

### Contributing

Bug reports, suggetions, and feature requests can be reported as issues using Github.

Code changes are preferrable to issues. To submit your changes to this project:

Fork this repo. Create a branch that describes your change. Push your branch. Create a Pull Request on Github. Contact me once a week/month until I respond.

You must agree to copyright and license identical to the terms described in the file `LICENSE`.
