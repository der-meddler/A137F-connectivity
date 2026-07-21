# MediaTek Connectivity Top-Level Makefile

TOP := $(srctree)/drivers/misc/mediatek/connectivity
ifeq ($(TARGET_BUILD_VARIANT),)
TARGET_BUILD_VARIANT := user
endif

# THIS IS THE MAGIC LINE: It points to the in-tree common folder
WMT_SRC_FOLDER := $(TOP)/common

# Export these globally so bt/ wlan/ and gps/ Makefiles can use them
export TOP WMT_SRC_FOLDER TARGET_BUILD_VARIANT

subdir-ccflags-y += -I$(srctree)/
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

# Platform ID calculations (Required for BT_PLATFORM)
MTK_PLATFORM_ID := $(patsubst CONSYS_%,%,$(subst ",,$(CONFIG_MTK_COMBO_CHIP)))

ifneq (,$(filter $(CONFIG_MTK_COMBO_CHIP), "CONSYS_6885" "CONSYS_6893"))
export MTK_COMBO_CHIP=CONNAC2X2_SOC3_0
else ifneq (,$(filter $(CONFIG_MTK_COMBO_CHIP), "CONSYS_6779" "CONSYS_6873" "CONSYS_6853"))
export MTK_COMBO_CHIP=CONNAC2X2
else
export MTK_COMBO_CHIP=CONNAC
export BT_PLATFORM=connac1x
endif

# =========================================================================
# Build Targets (Pointing directly to subfolders containing Makefiles)
# =========================================================================
obj-$(CONFIG_MTK_COMBO) += common/
obj-$(CONFIG_MTK_COMBO_BT) += bt/mt66xx/wmt/

# Wi-Fi splits between adaptor and gen4m core
obj-$(CONFIG_MTK_COMBO_WIFI) += wlan/adaptor/
obj-$(CONFIG_MTK_COMBO_WIFI) += wlan/core/gen4m/

obj-$(CONFIG_MTK_COMBO_GPS) += gps/
obj-$(CONFIG_MTK_COMBO_FM) += fmradio/
