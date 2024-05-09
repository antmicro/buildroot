################################################################################
#
# RiscV Coremark
#
################################################################################

RISCV_COREMARK_SITE_METHOD = git
RISCV_COREMARK_GIT_SUBMODULES = YES
RISCV_COREMARK_VERSION = 6e1d72b864e45f67031ffaedb0b01b5d030d6d3c
RISCV_COREMARK_SITE = https://github.com/riscv-boom/riscv-coremark.git
RISCV_COREMARK_LICENSE = BSD-3
RISCV_COREMARK_LICENSE_FILE = LICENSE

define RISCV_COREMARK_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" -C $(@D)/coremark PORT_DIR=$(@D)/riscv64 compile
endef

define RISCV_COREMARK_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/coremark/coremark.riscv $(TARGET_DIR)/usr/bin/coremark.riscv
endef

$(eval $(generic-package))
