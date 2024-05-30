#!/bin/bash
#
# Copyright (C) 2018-2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        vendor/lib/libmmcamera2_cpp_module.so)
            ;&
        vendor/lib/libmmcamera2_dcrf.so)
            ;&
        vendor/lib/libmmcamera2_iface_modules.so)
            ;&
        vendor/lib/libmmcamera2_imglib_modules.so)
            ;&
        vendor/lib/libmmcamera2_mct.so)
            ;&
        vendor/lib/libmmcamera2_pproc_modules.so)
            ;&
        vendor/lib/libmmcamera2_stats_algorithm.so)
            ;&
        vendor/lib/libmmcamera_imglib.so)
            ;&
        vendor/lib/libmmcamera_pdaf.so)
            ;&
        vendor/lib/libmmcamera_pdafcamif.so)
            ;&
        vendor/lib/libmmcamera_tintless_algo.so)
            ;&
        vendor/lib/libmmcamera_tintless_bg_pca_algo.so)
            sed -i 's|/data/misc/camera/|/data/vendor/qcam/|g' "${2}"
            ;;
        vendor/lib/libmmcamera2_sensor_modules.so)
            sed -i 's|/system/etc/camera|/vendor/etc/camera|g' "${2}"
            sed -i 's|/data/misc/camera/|/data/vendor/qcam/|g' "${2}"
            ;;
        vendor/lib/libmmcamera_dbg.so)
            sed -i 's|persist.camera.debug.logfile|persist.vendor.camera.dbglog|g' "${2}"
            sed -i 's|/data/misc/camera/|/data/vendor/qcam/|g' "${2}"
            ;;
        vendor/lib/libmmcamera2_stats_modules.so)
            sed -i 's|/data/misc/camera/|/data/vendor/qcam/|g' "${2}"
            "${PATCHELF}" --replace-needed "libandroid.so" "libcamshim.so" "${2}"
            "${PATCHELF}" --remove-needed "libgui.so" "${2}"
            ;;
        vendor/bin/mm-qcamera-daemon)
            "${PATCHELF}" --add-needed "libshims_camera" "${2}"
            sed -i 's|/data/misc/camera/cam_socket|/data/vendor/qcam/cam_socket|g' "${2}
            ;;
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

# Required!
export DEVICE=TB8703N
export DEVICE_COMMON=msm8953-common
export VENDOR=lenovo

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
