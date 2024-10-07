################################################################################
#
# bash-static
#
################################################################################

BASH_STATIC_VERSION = 635413791c400ae883c280fcb17629f03c80231b
BASH_STATIC_LICENSE = GPL-3.0+
BASH_STATIC_SITE = $(call github,robxu9,bash-static,$(BASH_STATIC_VERSION))
BASH_STATIC_LICENSE_FILES = COPYING

define BASH_STATIC_BUILD_CMDS
	cp -r package/bash-static/patches/ $(@D)/custom
	cp package/bash-static/make.sh $(@D)/make.sh
	cd $(@D) && ./make.sh $(BR2_ARCH)
endef

define BASH_STATIC_INSTALL_TARGET_CMDS
	cd $(@D) && cp releases/bash $(TARGET_DIR)/opt/bash-static
endef

$(eval $(generic-package))
