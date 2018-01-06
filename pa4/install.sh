#!/bin/bash

if [ -z "${PREFIX}" ]; then
	echo 'Please set $PREFIX to the installation directory'
	exit
fi

mkdir -p ${PREFIX}
cd ./riscv-fesvr
mkdir build
cd build
../configure --prefix=${PREFIX}
make install
cd ../../
./configure --with-riscv=${PREFIX}
make install
