LIBGLVND_VERSION = 1.3.2
LIBGLVND_SOURCE = libglvnd-v$(LIBGLVND_VERSION).tar.gz
LIBGLVND_SITE = https://gitlab.freedesktop.org/glvnd/libglvnd/-/archive/v$(LIBGLVND_VERSION)

LIBGLVND_LICENSE = \
				   libglvnd license, \
				   Apache-2.0 (Khronos headers), \
				   MIT (Xorg; mesa; cJSON), \
				   BSD-1=Clause (uthash)

LIBGLVND_LICENSE_FILES = \
						 README.md \
						 src/util/uthash/LICENSE \
						 src/util/cJSON/LICENSE

LIBGLVND_INSTALL_STAGING = YES

LIBGLVND_PROVIDES = libgl libgles libegl

LIBGLVND_DEPENDENCIES = xlib_libX11 xlib_libXext xorgproto

LIBGLVND_CONF_OPTS += -Dx11=enabled -Dglx=enabled -Degl=true -Dgles1=true -Dgles2=true -Dheaders=true

$(eval $(meson-package))
