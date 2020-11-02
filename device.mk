#
# Copyright (C) 2019 The Potato Open Sauce Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true
BOARD_BUILD_PRODUCT_IMAGE := true

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    tinymix

# Camera2
PRODUCT_PACKAGES += \
    Camera2

# Display
PRODUCT_PACKAGES += \
    libvulkan

# DT2W
PRODUCT_PACKAGES += \
    DT2W-Service-Merlin

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0_system \
    android.hidl.manager@1.0_system

# NFC
PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    NfcNci \
    Tag

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-hotword.xml

# Radio Jar
PRODUCT_BOOT_JARS += \
    mediatek-common \
    mediatek-framework \
    mediatek-ims-base \
    mediatek-ims-common \
    mediatek-telecom-common \
    mediatek-telephony-base \
    mediatek-telephony-common

PRODUCT_PACKAGES += \
    RcsService

# RCS
PRODUCT_PACKAGES += \
    RcsService

# TinyXML
PRODUCT_PACKAGES += \
    libtinyxml

# VNDK
PRODUCT_EXTRA_VNDK_VERSIONS := 29

# Inherit vendor
$(call inherit-product, vendor/xiaomi/merlin/merlin-vendor.mk)
