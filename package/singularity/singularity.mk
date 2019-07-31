# Sylabs Singularity package

SINGULARITY_VERSION = v3.3.0
SINGULARITY_SITE = $(call github,sylabs,singularity,$(SINGULARITY_VERSION))
SINGULARITY_LICENSE = BSD-3-Clause
SINGULARITY_LICENSE_FILES = LICENSE.md
SINGULARITY_WORKSPACE = gopath

define SINGULARITY_CONFIGURE_CMDS
    cd $(@D) && \
    ./mconfig --prefix=/usr
endef

define SINGULARITY_BUILD_CMDS
    cd $(@D) && \
    make -C ./builddir
endef

define SINGULARITY_INSTALL_TARGET_CMDS
    cd $(@D) && \
    make -C ./builddir DESTDIR="$(TARGET_DIR)" install
endef

$(eval $(golang-package))
