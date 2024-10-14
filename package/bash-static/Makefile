MUSL_TARGET := $(ARCH)-linux-musl
MUSL_INSTALL_DIR := $(shell pwd)/musl-install
MUSL_GCC := $(MUSL_INSTALL_DIR)/bin/$(MUSL_TARGET)-gcc

all: releases/bash

musl-cross-make:
	git clone https://github.com/richfelker/musl-cross-make.git

musl-cross-make/config.mak: musl-cross-make
	echo "TARGET = $(MUSL_TARGET)" > $@
	echo "OUTPUT = $(MUSL_INSTALL_DIR)" >> $@

$(MUSL_GCC): musl-cross-make musl-cross-make/config.mak
	$(MAKE) -C musl-cross-make install

releases/bash: $(MUSL_GCC)
	sed '/configure_args=()/d' -i build.sh 
	CC="$(MUSL_GCC)" CFLAGS="-static" configure_args="--host=$(MUSL_TARGET)" ./build.sh ignore ignore