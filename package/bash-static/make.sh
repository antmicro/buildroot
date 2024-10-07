#!/bin/bash

arch=$1
musl_install_dir="$(pwd)/musl-install"

rm -rf musl-cross-make
git clone https://github.com/richfelker/musl-cross-make.git

pushd musl-cross-make || exit
target="$arch-linux-musl"
echo "TARGET = $target" > config.mak
echo "OUTPUT = $musl_install_dir" >> config.mak

make install
popd || exit

sed -i ./build.sh -e '/configure_args=\(\)/d'
CC="$musl_install_dir/bin/$target-gcc" CFLAGS="-static" configure_args="--host=$target" ./build.sh ignore ignore

