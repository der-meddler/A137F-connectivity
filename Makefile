# MediaTek Connectivity Top-Level Makefile

TOP := $(srctree)/drivers/misc/mediatek/connectivity
ifeq ($(TARGET_BUILD_VARIANT),)
$(warning TARGET_BUILD_VARIANT is empty! Using default option.)
TARGET_BUILD_VARIANT := user
endif
WMT_SRC_FOLDER := $(TOP)/common

export TOP WMT_SRC_FOLDER TARGET_BUILD_VARIANT

# Standard Root Include
subdir-ccflags-y += -I$(srctree)/

# =========================================================================
# Common Main (WMT / OSAL / Core) Include Directories
# =========================================================================
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/connectivity/common/common_main/include
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/connectivity/common/common_main/linux/include
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/connectivity/common/common_main/core/include
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/connectivity/common/common_main/osal/include

# =========================================================================
# Platform & Subsystem Include Directories
# =========================================================================
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/base/power/include
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/clkbuf/src
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/base/power/include/clkbuf_v1/$(MTK_PLATFORM)
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/include/mt-plat/$(MTK_PLATFORM)/include
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/include/mt-plat

ifeq ($(CONFIG_MTK_PMIC_CHIP_MT6359),y)
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/pmic/include/mt6359
endif

ifeq ($(CONFIG_MTK_PMIC_NEW_ARCH),y)
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/pmic/include
endif

subdir-ccflags-y += -I$(srctree)/drivers/mmc/core
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/eccci/$(MTK_PLATFORM)
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/eccci/
subdir-ccflags-y += -I$(srctree)/drivers/clk/mediatek/
subdir-ccflags-y += -I$(srctree)/drivers/pinctrl/mediatek/
subdir-ccflags-y += -I$(srctree)/drivers/misc/mediatek/power_throttling/

# =========================================================================
# Subdirectories
# =========================================================================
obj-$(CONFIG_MTK_COMBO) += common/
obj-$(CONFIG_MTK_COMBO_BT) += bt/
obj-$(CONFIG_MTK_COMBO_WIFI) += wlan/
obj-$(CONFIG_MTK_COMBO_GPS) += gps/
obj-$(CONFIG_MTK_COMBO_FM) += fmradio/
