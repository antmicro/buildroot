# Sylabs Singularity package

SINGULARITY_VERSION = v3.3.0
SINGULARITY_SITE = $(call github,sylabs,singularity,$(SINGULARITY_VERSION))
SINGULARITY_LICENSE = BSD-3-Clause
SINGULARITY_LICENSE_FILES = LICENSE.md
SINGULARITY_WORKSPACE = gopath

define SINGULARITY_CONFIGURE_CMDS
    # do nothing
endef

define SINGULARITY_BUILD_CMDS
    cd $(@D) && \
    ./mconfig --prefix=../ && \
    make -C ./builddir && \
    make -C ./builddir install
endef

define SINGULARITY_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/bin/singularity $(TARGET_DIR)/usr/bin/singularity
    $(INSTALL) -D -m 0755 $(@D)/etc/bash_completion.d/singularity $(TARGET_DIR)/etc/bash_completion.d/singularity
    $(INSTALL) -D -m 0755 $(@D)/etc/singularity/singularity.conf $(TARGET_DIR)/etc/singularity/singularity.conf
    $(INSTALL) -D -m 0755 $(@D)/etc/singularity/nvliblist.conf $(TARGET_DIR)/etc/singularity/nvliblist.conf
    $(INSTALL) -D -m 0755 $(@D)/etc/singularity/remote.yaml $(TARGET_DIR)/etc/singularity/remote.yaml
    $(INSTALL) -D -m 0755 $(@D)/etc/singularity/ecl.toml $(TARGET_DIR)/etc/singularity/ecl.toml
    mkdir -p $(TARGET_DIR)/var/singularity/mnt/session
    mkdir -p $(TARGET_DIR)/etc/singularity/actions
    mkdir -p $(TARGET_DIR)/etc/singularity/cgroups
    mkdir -p $(TARGET_DIR)/etc/singularity/network
    mkdir -p $(TARGET_DIR)/etc/singularity/seccomp-profiles
    mkdir -p $(TARGET_DIR)/libexec/singularity/cni
    mkdir -p $(TARGET_DIR)/libexec/singularity/bin
    $(INSTALL) -D -m 0755 $(@D)/libexec/singularity/bin/* $(TARGET_DIR)/libexec/singularity/bin/
    $(INSTALL) -D -m 0755 $(@D)/libexec/singularity/cni/* $(TARGET_DIR)/libexec/singularity/cni/
    $(INSTALL) -D -m 0755 $(@D)/etc/singularity/actions/* $(TARGET_DIR)/etc/singularity/actions/
    $(INSTALL) -D -m 0755 $(@D)/etc/singularity/cgroups/* $(TARGET_DIR)/etc/singularity/cgroups/
    $(INSTALL) -D -m 0755 $(@D)/etc/singularity/network/* $(TARGET_DIR)/etc/singularity/network/
    $(INSTALL) -D -m 0755 $(@D)/etc/singularity/seccomp-profiles/* $(TARGET_DIR)/etc/singularity/seccomp-profiles/
endef

$(eval $(golang-package))
