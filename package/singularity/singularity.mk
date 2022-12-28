# Sylabs Singularity package

SINGULARITY_VERSION = v3.6.4
SINGULARITY_SITE = $(call github,sylabs,singularity,$(SINGULARITY_VERSION))
SINGULARITY_LICENSE = BSD-3-Clause
SINGULARITY_LICENSE_FILES = LICENSE.md
SINGULARITY_WORKSPACE = gopath
SINGULARITY_DEPENDENCIES = openssl util-linux

ifeq ($(BR2_arm),y)
	SINGULARITY_GOARCH = arm
	ifeq ($(BR2_ARM_CPU_ARMV5),y)
	SINGULARITY_GOARM = 5
else ifeq ($(BR2_ARM_CPU_ARMV6),y)
	SINGULARITY_GOARM = 6
else ifeq ($(BR2_ARM_CPU_ARMV7A),y)
	SINGULARITY_GOARM = 7
endif
else ifeq ($(BR2_aarch64),y)
	SINGULARITY_GOARCH = arm64
else ifeq ($(BR2_i386),y)
	SINGULARITY_GOARCH = 386
else ifeq ($(BR2_x86_64),y)
	SINGULARITY_GOARCH = amd64
else ifeq ($(BR2_powerpc64),y)
	SINGULARITY_GOARCH = ppc64
else ifeq ($(BR2_powerpc64le),y)
	SINGULARITY_GOARCH = ppc64le
else ifeq ($(BR2_mips64),y)
	SINGULARITY_GOARCH = mips64
else ifeq ($(BR2_mips64el),y)
	SINGULARITY_GOARCH = mips64le
endif

define SINGULARITY_WORKSPACE_FIXUP
	chmod +w -R $(BUILD_DIR)/singularity-$(SINGULARITY_VERSION)/$(SINGULARITY_WORKSPACE) 
endef

define SINGULARITY_SETUID_FIXUP
	chmod +s $(TARGET_DIR)/usr/libexec/singularity/bin/starter-suid
endef

SINGULARITY_POST_BUILD_HOOKS += SINGULARITY_WORKSPACE_FIXUP
SINGULARITY_POST_INSTALL_TARGET_HOOKS += SINGULARITY_SETUID_FIXUP

define SINGULARITY_CONFIGURE_CMDS
    cd $(@D) && \
    ./mconfig --prefix=/usr \
    	-C $(TARGET_CC) \
	-X $(TARGET_CC) \
	-P release-stripped \
	-G $(HOST_DIR)/bin/go \
	--target-goarch $(SINGULARITY_GOARCH) \
	--without-seccomp \
	-S -s -v
endef

define SINGULARITY_BUILD_CMDS
    cd $(@D) && \
    $(TARGET_MAKE_ENV) \
    GOPATH=$(BUILD_DIR)/singularity-$(SINGULARITY_VERSION)/$(SINGULARITY_WORKSPACE) \
    make -C ./builddir
endef

define SINGULARITY_INSTALL_TARGET_CMDS
    cd $(@D) && \
    make -C ./builddir DESTDIR="$(TARGET_DIR)" install
endef

$(eval $(golang-package))
