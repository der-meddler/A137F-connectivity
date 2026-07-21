# MediaTek Connectivity Top-Level Makefile

TOP := $(srctree)/drivers/misc/mediatek/connectivity
ifeq ($(TARGET_BUILD_VARIANT),)
TARGET_BUILD_VARIANT := user
endif

WMT_SRC_FOLDER := $(TOP)/common

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

# Platform ID calculations
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
# WLAN gen4m Environment Exports (Fixes "Unsupported HIF=!!")
# =========================================================================
export CONFIG_MTK_COMBO_WIFI_HIF=axi
export WLAN_CHIP_ID=$(MTK_PLATFORM_ID)
export MTK_ANDROID_WMT=y
export MTK_ANDROID_EMI=y
export ADAPTOR_OPTS=$(MTK_COMBO_CHIP)

WLAN_IP_SET_1_SERIES := 6765 6761 6885 6893
WLAN_IP_SET_2_SERIES := 3967 6785
WLAN_IP_SET_3_SERIES := 6779 6873 6853

ifneq ($(filter $(WLAN_IP_SET_3_SERIES), $(WLAN_CHIP_ID)),)
export WIFI_IP_SET=3
else ifneq ($(filter $(WLAN_IP_SET_2_SERIES), $(WLAN_CHIP_ID)),)
export WIFI_IP_SET=2
else
export WIFI_IP_SET=1
endif

# =========================================================================
# Build Targets
# =========================================================================
obj-$(CONFIG_MTK_COMBO) += common/
obj-$(CONFIG_MTK_COMBO_BT) += bt/mt66xx/wmt/
obj-$(CONFIG_MTK_COMBO_WIFI) += wlan/adaptor/
obj-$(CONFIG_MTK_COMBO_WIFI) += wlan/core/gen4m/
obj-$(CONFIG_MTK_COMBO_GPS) += gps/
obj-$(CONFIG_MTK_COMBO_FM) += fmradio/
