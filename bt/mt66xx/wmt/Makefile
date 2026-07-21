# Bluetooth character device driver (In-Tree)

ifndef TOP
    TOP := $(srctree)/..
endif

# Force build fail on modpost warning
KBUILD_MODPOST_FAIL_ON_WARNINGS := y

# Platform definitions
ccflags-y += -D CONNAC1X_CHIPID=$(BT_PLATFORM)

ifeq ($(BT_ENABLE_LOW_POWER_DEBUG),y)
    ccflags-y += -D ENABLE_LOW_POWER_DEBUG=1
else
    ccflags-y += -D ENABLE_LOW_POWER_DEBUG=0
endif

ccflags-y += -D MTK_WCN_WMT_STP_EXP_SYMBOL_ABSTRACT
ccflags-y += -I$(srctree)/drivers/misc/mediatek/include
ccflags-y += -I$(srctree)/drivers/misc/mediatek/include/mt-plat

ifeq ($(CONFIG_MTK_CONN_LTE_IDC_SUPPORT),y)
    ccflags-y += -D WMT_IDC_SUPPORT=1
else
    ccflags-y += -D WMT_IDC_SUPPORT=0
endif

# ==========================================================
# HEADER RESOLUTION (The Fix)
# ==========================================================
# 1. Use the WMT_SRC_FOLDER exported from the top-level makefile
ccflags-y += -I$(WMT_SRC_FOLDER)/common_main/include
ccflags-y += -I$(WMT_SRC_FOLDER)/common_main/linux/include
ccflags-y += -I$(WMT_SRC_FOLDER)/common_main/core/include
ccflags-y += -I$(WMT_SRC_FOLDER)/common_main/osal/include

# 2. Local BT paths (Fixes missing btmtk_dbg_tp_evt_if.h)
ccflags-y += -I$(src)
ccflags-y += -I$(src)/inc
ccflags-y += -I$(src)/..
ccflags-y += -I$(src)/../inc
ccflags-y += -I$(src)/../include/btif

# ==========================================================
# KERNEL MODULE COMPILATION
# ==========================================================
ifneq ($(BT_PLATFORM),)
MODULE_NAME := bt_drv_$(BT_PLATFORM)
else
MODULE_NAME := bt_drv
endif

# MUST be obj-y or obj-$(CONFIG_MTK_COMBO_BT) to build into kernel image
obj-y += $(MODULE_NAME).o

ccflags-y += -D CREATE_NODE_DYNAMIC=1
ccflags-y += -DCFG_DISABLE_BT_LOG=1

$(MODULE_NAME)-objs += stp_chrdev_bt.o
$(MODULE_NAME)-objs += btmtk_dbg.o btmtk_dbg_tp_evt_if.o

ifneq ($(CONFIG_MTK_CONNSYS_DEDICATED_LOG_PATH),)
    $(MODULE_NAME)-objs += fw_log_bt.o
endif
