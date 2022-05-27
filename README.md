# Orange PC

## Introduction

## Development

### Prerequisites

TBD: (llvm, clang, wabt, etc)

### Building

```sh
make
```

### Running in development

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

TBD: (sending a merge request, etc)


