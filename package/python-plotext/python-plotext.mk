################################################################################
#
# python-plotext
#
################################################################################

PYTHON_PLOTEXT_VERSION = 5.2.8
PYTHON_PLOTEXT_SOURCE = plotext-$(PYTHON_PLOTEXT_VERSION).tar.gz
PYTHON_PLOTEXT_SITE = https://files.pythonhosted.org/packages/27/d7/58f5ec766e41f8338f04ec47dbd3465db04fbe2a6107bca5f0670ced253a
PYTHON_PLOTEXT_SETUP_TYPE = setuptools
PYTHON_PLOTEXT_LICENSE = MIT
PYTHON_PLOTEXT_LICENSE_FILES = LICENSE

$(eval $(python-package))
