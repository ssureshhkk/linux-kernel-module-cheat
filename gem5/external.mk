################################################################################
#
# GEM5
#
################################################################################

GEM5_VERSION = 1.0
GEM5_SITE = $(BR2_EXTERNAL_GEM5_PATH)
GEM5_SITE_METHOD = local

ifeq ($(ARCH),x86_64)
ARCH_MAKE = x86
else
ARCH_MAKE = $(ARCH)
endif

define GEM5_BUILD_CMDS
	cd '$(@D)' && ./build -a '$(ARCH)' -j '$(BR2_JLEVEL)'
	cd '$(@D)/gem5/util/m5' && $(MAKE) -f 'Makefile.$(ARCH_MAKE)' CC='$(TARGET_CC)' LD='$(TARGET_LD)'
endef

define GEM5_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 '$(@D)/gem5/util/m5/m5' '$(TARGET_DIR)/usr/bin'
endef

$(eval $(generic-package))
