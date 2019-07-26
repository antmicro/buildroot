# Sylabs Singularity package

SINGULARITY_VERSION = 3.3.0
SINGULARITY_SITE = $(call github,sylabs,singularity,$(SINGULARITY_VERSION))
SINGULARITY_LICENSE = BSD-3-Clause
SINGULARITY_LICENSE_FILES = LICENSE.md

$(eval $(golang-package))
