#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=merlin
VENDOR=xiaomi

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
    vendor/lib/libaedv.so)
        ;&
    vendor/lib/libladder.so)
        ;&
    vendor/lib/libudf.so)
        ;&
    vendor/lib64/libaedv.so)
        ;&
    vendor/lib64/libladder.so)
        ;&
    vendor/lib64/libudf.so) # Use vndk-v29 dependencies
        patchelf --replace-needed libunwindstack.so libunwindstack-v29.so ${2}
        ;;
    vendor/lib/hw/audio.primary.mt6768.so)
        ;&
    vendor/lib64/hw/audio.primary.mt6768.so) # Use vndk-v29 dependencies
        patchelf --replace-needed libmedia_helper.so libmedia_helper-v29.so ${2}
        ;;
    vendor/lib64/libkeymaster4.so) # Use vndk-v29 dependencies
        patchelf --replace-needed libkeymaster_portable.so libkeymaster_portable-v29.so ${2}
        patchelf --replace-needed libkeymaster_messages.so libkeymaster_messages-v29.so ${2}
        patchelf --replace-needed libpuresoftkeymasterdevice.so libpuresoftkeymasterdevice-v29.so ${2}
        ;;
    vendor/bin/hw/android.hardware.wifi@1.0-service-lazy-mediatek)
        ;&
    vendor/bin/hw/hostapd)
        ;&
    vendor/bin/hw/wpa_supplicant) # Add libcompiler_rt.so dependency to fix missing __subtf3 symbol
        patchelf --add-needed libcompiler_rt.so ${2}
        ;;
    vendor/lib64/libmtk-ril.so) # Change non-existent ctl. property to a benign vendor. one to prevent log spam
        sed -i -e 's/ctl\.vendor\.service_nv_protect/vendor.ctl.service_nv_protect/g' ${2}
        ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
