#
# Copyright (C) 2021 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/xiaomi/merlin

TARGET_BOOTLOADER_BOARD_NAME := merlin

# Inherit from mt6768-common
-include device/xiaomi/mt6768-common/BoardConfigCommon.mk

# Kernel
TARGET_KERNEL_CONFIG := merlin_defconfig

# Assert
TARGET_OTA_ASSERT_DEVICE := merlin,merlin_eea,merlinnfc

# HIDL
ODM_MANIFEST_SKUS += \
    merlinnfc

ODM_MANIFEST_MERLINNFC_FILES := $(DEVICE_PATH)/manifest_merlinnfc.xml
