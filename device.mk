#
# Copyright (C) 2017-2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from msm8953-common
$(call inherit-product, device/lenovo/msm8953-common/msm8953.mk)

# Get tablet dalvik parameters
$(call inherit-product,frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

# Inherit gapps
$(call inherit-product-if-exists, vendor/gapps/arm64/arm64-vendor.mk)

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1200

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Camera
PRODUCT_PACKAGES += \
    camera.msm8953 

# Camera shim
PRODUCT_PACKAGES += \
    libshims_camera

# Inherit the proprietary files
$(call inherit-product, vendor/lenovo/TB8703N/TB8703N-vendor.mk)
