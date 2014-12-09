# Copyright (C) 2013 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file is the build configuration for an aosp Android
# build for flounder hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps). Except for a few implementation
# details, it only fundamentally contains two inherit-product
# lines, aosp and flounder, hence its name.
#

#PRODUCT_PACKAGES += \
#        rild

# Inherit from those products. Most specific first.
$(call inherit-product, device/htc/flounder/product.mk)
#$(call inherit-product, device/htc/flounder/device-lte.mk)
#$(call inherit-product-if-exists, vendor/htc/flounder_lte/device-vendor.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

$(call inherit-product-if-exists, vendor/htc/flounder/flounder-vendor.mk)
$(call inherit-product, jcrom/htc/flounder/device-flounder.mk)
$(call inherit-product, jcrom/common/common.mk)

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=volantis TARGET_DEVICE=flounder BUILD_FINGERPRINT=google/volantis/flounder:5.0.1/LRX22C/1602158:user/release-keys PRIVATE_BUILD_DESC="volantis-user 5.0.1 LRX22C 1602158 release-keys"

PRODUCT_NAME := jcrom_flounder
PRODUCT_DEVICE := flounder
PRODUCT_BRAND := google
PRODUCT_MODEL := Nexus 9
PRODUCT_MANUFACTURER := htc
PRODUCT_RESTRICT_VENDOR_FILES := owner path
TARGET_DUMMY_VENDORIMAGE := true
