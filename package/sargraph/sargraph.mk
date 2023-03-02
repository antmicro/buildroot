SARGRAPH_VERSION = 0b9eee589a72e1461f8d2cfe2924e14b412c4f97 
SARGRAPH_SITE = $(call github,antmicro,sargraph,$(SARGRAPH_VERSION))
SARGRAPH_LICENSE = Apache-2.0
SARGRAPH_LICENSE_FILES = LICENSE
SARGRAPH_CUSTOM_INSTALL_DIR = /opt/sargraph
SARGRAPH_ENTRYPOINT = $(SARGRAPH_CUSTOM_INSTALL_DIR)/sargraph.py

define SARGRAPH_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/$(SARGRAPH_CUSTOM_INSTALL_DIR)

	$(foreach f,$(notdir $(wildcard $(@D)/*.py)),
		$(INSTALL) -D -m 0644 $(@D)/$(f) \
			$(TARGET_DIR)/$(SARGRAPH_CUSTOM_INSTALL_DIR)/$(f))

	chmod +x $(TARGET_DIR)/$(SARGRAPH_ENTRYPOINT)
	ln -sf $(SARGRAPH_ENTRYPOINT) $(TARGET_DIR)/usr/bin/sargraph
endef

$(eval $(generic-package))
