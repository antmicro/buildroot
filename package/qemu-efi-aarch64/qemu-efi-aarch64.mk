################################################################################
#
# qemu-efi-aarch64
#
################################################################################

QEMU_EFI_AARCH64_VERSION = edk2-stable202005
QEMU_EFI_AARCH64_SITE_METHOD = git
QEMU_EFI_AARCH64_SITE = https://github.com/tianocore/edk2
QEMU_EFI_AARCH64_LICENSE = BSD-2-CLAUSE
QEMU_EFI_AARCH64_LICENSE_FILES = License.txt
QEMU_EFI_AARCH64_GIT_SUBMODULES = YES

QEMU_EFI_AARCH64_DEPENDENCIES = host-python3 host-acpica

EDK2_ARCH = AARCH64
EDK2_BUILD_TYPE = RELEASE

EDK2_PACKAGE_NAME = ArmVirtPkg
EDK2_PLATFORM_NAME = ArmVirtQemu
EDK2_BUILD_DIR = $(EDK2_PLATFORM_NAME)-$(EDK2_ARCH)

EDK2_BUILD_ENV += \
		  WORKSPACE=$(@D) \
		  PYTHON_COMMAND=$(HOST_DIR)/bin/python3 \
		  IASL_PREFIX=$(HOST_DIR)/bin/ \
		  GCC5_$(EDK2_ARCH)_PREFIX=$(TARGET_CROSS)

EDK2_BUILD_OPTS += -a $(EDK2_ARCH) -t GCC5 -b $(EDK2_BUILD_TYPE) -p $(EDK2_PACKAGE_NAME)/$(EDK2_PLATFORM_NAME).dsc

define QEMU_EFI_AARCH64_BUILD_CMDS
	export $(EDK2_BUILD_ENV) && \
	source $(@D)/edksetup.sh && \
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/BaseTools && \
	build $(EDK2_BUILD_OPTS) $(EDK2_BUILD_TARGETS)
endef

define QEMU_EFI_AARCH64_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/edk2 && \
	cp -f $(@D)/Build/$(EDK2_BUILD_DIR)/$(EDK2_BUILD_TYPE)_GCC5/FV/*.fd $(TARGET_DIR)/usr/share/edk2/
endef


$(eval $(generic-package))
