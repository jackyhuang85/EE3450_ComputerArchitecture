## Build Sodor Emulators

```
git clone XXX pa4
cd pa4/riscv-fesvr
mkdir build && cd build
../configure --prefix=/usr/riscv
make
cd ../../
./configure --with-riscv=/usr/riscv
make
```

Test whether the emulators are built successfully,

```
make run-emulator
```

## Run a Benchmark

Run a benchmark program on the 1-stage emulator,

```
./emulator/rv32_1stage/emulator +max-cycles=10000000 +verbose +loadmem=/path/to/benchmark.riscv 3>&1 1>&2 2>&3 | /usr/riscv/bin/spike-dasm
```

Run a benchmark program on the 5-stage emulator,

```
./emulator/rv32_5stage/emulator +max-cycles=10000000 +verbose +loadmem=/path/to/benchmark.riscv 3>&1 1>&2 2>&3 | /usr/riscv/bin/spike-dasm
```

