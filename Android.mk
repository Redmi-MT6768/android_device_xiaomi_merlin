LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),begonia)

include $(call all-subdir-makefiles,$(LOCAL_PATH))

include $(CLEAR_VARS)

endif
