################################################################################
#
# bash-static
#
################################################################################

BASH_STATIC_VERSION = 87e8f814d988486ec1d164d2dafa3ea925fc0146
BASH_STATIC_LICENSE = GPL-3.0+
BASH_STATIC_SITE = $(call github,robxu9,bash-static,$(BASH_STATIC_VERSION))
BASH_STATIC_LICENSE_FILES = COPYING

define BASH_STATIC_BUILD_CMDS
	cp -r package/bash-static/patches/ $(@D)/custom
	cd $(@D) && ./build.sh linux $(BR2_ARCH)
endef

define BASH_STATIC_INSTALL_TARGET_CMDS
	cd $(@D) && cp releases/bash $(TARGET_DIR)/opt/bash-static
endef

$(eval $(generic-package))
