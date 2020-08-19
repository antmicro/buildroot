################################################################################
#
# virglrenderer
#
################################################################################

VIRGLRENDERER_VERSION = 0.8.2
VIRGLRENDERER_SOURCE = virglrenderer-virglrenderer-$(VIRGLRENDERER_VERSION).tar.gz
VIRGLRENDERER_SITE = https://gitlab.freedesktop.org/virgl/virglrenderer/-/archive/virglrenderer-$(VIRGLRENDERER_VERSION)
VIRGLRENDERER_LICENSE = MIT
VIRGLRENDERER_LICENSE_FILES = COPYING
VIRGLRENDERER_INSTALL_STAGING = YES

VIRGLRENDERER_DEPENDENCIES = host-pkgconf mesa3d libepoxy

$(eval $(meson-package))
