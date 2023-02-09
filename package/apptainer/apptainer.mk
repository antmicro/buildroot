# Apptainer package

APPTAINER_VERSION = v1.1.5
APPTAINER_SITE = $(call github,apptainer,apptainer,$(APPTAINER_VERSION))
APPTAINER_LICENSE = BSD-3-Clause
APPTAINER_LICENSE_FILES = LICENSE.md
APPTAINER_WORKSPACE = gopath
APPTAINER_DEPENDENCIES = openssl util-linux

ifeq ($(BR2_arm),y)
	APPTAINER_GOARCH = arm
	ifeq ($(BR2_ARM_CPU_ARMV5),y)
	APPTAINER_GOARM = 5
else ifeq ($(BR2_ARM_CPU_ARMV6),y)
	APPTAINER_GOARM = 6
else ifeq ($(BR2_ARM_CPU_ARMV7A),y)
	APPTAINER_GOARM = 7
endif
else ifeq ($(BR2_aarch64),y)
	APPTAINER_GOARCH = arm64
else ifeq ($(BR2_i386),y)
	APPTAINER_GOARCH = 386
else ifeq ($(BR2_x86_64),y)
	APPTAINER_GOARCH = amd64
else ifeq ($(BR2_powerpc64),y)
	APPTAINER_GOARCH = ppc64
else ifeq ($(BR2_powerpc64le),y)
	APPTAINER_GOARCH = ppc64le
else ifeq ($(BR2_mips64),y)
	APPTAINER_GOARCH = mips64
else ifeq ($(BR2_mips64el),y)
	APPTAINER_GOARCH = mips64le
endif

define APPTAINER_WORKSPACE_FIXUP
	chmod +w -R $(BUILD_DIR)/apptainer-$(APPTAINER_VERSION)/$(APPTAINER_WORKSPACE) 
endef

APPTAINER_POST_BUILD_HOOKS += APPTAINER_WORKSPACE_FIXUP

define APPTAINER_CONFIGURE_CMDS
    cd $(@D) && \
    ./mconfig --prefix=/usr \
    	-C $(TARGET_CC) \
	-X $(TARGET_CC) \
	-P release-stripped \
	-G $(HOST_DIR)/bin/go \
	--target-goarch $(APPTAINER_GOARCH) \
	--without-seccomp \
	-S -s -v
    $(INSTALL) -D package/apptainer/apptainer.conf $(@D)/builddir
endef

define APPTAINER_BUILD_CMDS
    cd $(@D) && \
    $(TARGET_MAKE_ENV) \
    GOPATH=$(BUILD_DIR)/apptainer-$(APPTAINER_VERSION)/$(APPTAINER_WORKSPACE) \
    make -C ./builddir
endef

define APPTAINER_INSTALL_TARGET_CMDS
    cd $(@D) && \
    make -C ./builddir DESTDIR="$(TARGET_DIR)" install
endef

$(eval $(golang-package))
