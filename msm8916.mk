#
# Copyright (C) 2017 The LineageOS Project
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

# Inherit from common
$(call inherit-product, device/samsung/qcom-common/qcom-common.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Import msm8916_32 audio configs
#include hardware/qcom/audio-caf/msm8916/configs/msm8916_32/msm8916_32.mk
include $(LOCAL_PATH)/audio_msm8916_32.mk

# Include proprietary blobs
$(call inherit-product, vendor/samsung/msm8916-common/msm8916-common-vendor.mk)

LOCAL_PATH := device/samsung/msm8916-common

# System properties
-include $(LOCAL_PATH)/system_prop.mk

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Data configuration files
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/data/dsi_config.xml:system/etc/data/dsi_config.xml \
	$(LOCAL_PATH)/configs/data/netmgr_config.xml:system/etc/data/netmgr_config.xml \
	$(LOCAL_PATH)/configs/data/qmi_config.xml:system/etc/data/qmi_config.xml

# GPS
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/gps/flp.conf:system/etc/flp.conf \
	$(LOCAL_PATH)/configs/gps/gps.conf:system/etc/gps.conf \
	$(LOCAL_PATH)/configs/gps/izat.conf:system/etc/izat.conf \
	$(LOCAL_PATH)/configs/gps/sap.conf:system/etc/sap.conf

# Keylayout
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/keylayout/sec_touchkey.kl:system/usr/keylayout/sec_touchkey.kl \
	$(LOCAL_PATH)/keylayout/sec_touchscreen.kl:system/usr/keylayout/sec_touchscreen.kl \
	$(LOCAL_PATH)/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl

# Media configurations
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/media/media_codecs.xml:system/etc/media/media_codecs.xml \
	$(LOCAL_PATH)/configs/media/media_codecs_performance.xml:system/etc/media/media_codecs_performance.xml \
	$(LOCAL_PATH)/configs/media/media_codecs_sec_primary.xml:system/etc/media/media_codecs_sec_primary.xml \
	$(LOCAL_PATH)/configs/media/media_codecs_sec_secondary.xml:system/etc/media/media_codecs_sec_secondary.xml \
	$(LOCAL_PATH)/configs/media/media_profiles.xml:system/etc/media/media_profiles.xml \
	frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
	frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
	frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
	frameworks/av/media/libstagefright/data/media_codecs_google_video_le.xml:system/etc/media_codecs_google_video_le.xml

# OTA scripts
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/releasetools/run_scripts.sh:install/bin/run_scripts.sh \
	$(LOCAL_PATH)/releasetools/functions.sh:install/bin/functions.sh \
	$(LOCAL_PATH)/releasetools/installbegin/check_sdk_version.sh:install/bin/installbegin/check_sdk_version.sh \
	$(LOCAL_PATH)/releasetools/postvalidate/resize_system.sh:install/bin/postvalidate/resize_system.sh

# Permissions
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

# Power configuration
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf

# Security configuration file
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/sec_config:system/etc/sec_config

# Wifi configuration files
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/wifi/cred.conf:system/etc/wifi/cred.conf \
	$(LOCAL_PATH)/configs/wifi/hostapd.accept:system/etc/hostapd/hostapd.accept \
	$(LOCAL_PATH)/configs/wifi/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
	$(LOCAL_PATH)/configs/wifi/hostapd.deny:system/etc/hostapd/hostapd.deny \
	$(LOCAL_PATH)/configs/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
	$(LOCAL_PATH)/configs/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
	$(LOCAL_PATH)/configs/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
	$(LOCAL_PATH)/configs/wifi/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
	$(LOCAL_PATH)/configs/wifi/WCNSS_qcom_cfg.ini:system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini \
	$(LOCAL_PATH)/configs/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin

# ANT+
PRODUCT_PACKAGES += \
	AntHalService \
	antradio_app \
	com.dsi.ant.antradio_library \
	libantradio

# Audio
PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.primary.msm8916 \
	audio.primary.default \
	audio_policy.msm8916 \
	audio.r_submix.default \
	audio.tms.default \
	audio.usb.default \
	audiod \
	libaudio-resampler \
	libaudioroute \
	libaudioutils \
	libaudiopolicymanager \
	libqcompostprocbundle \
	libqcomvisualizer \
	libqcomvoiceprocessing \
	libqcmediaplayer \
	libtinyalsa \
	libtinycompress \
	tinymix \
	tinyplay \
	tinycap \
	tinypcminfo

# Bootloader-recovery
PRODUCT_PACKAGES += \
	libbootloader_message

# Bluetooth
PRODUCT_PACKAGES += \
	libbt-vendor

#IMS/VoLTE calling support
PRODUCT_PACKAGES += \
	com.android.ims \
	com.android.ims.internal \
	ims-common \
	voip-common

# Boot jars
PRODUCT_BOOT_JARS += \
	commonimsinterface \
	ims-common \
	imsmanager \
	qcom.fmradio \
	voip-common

# Camera
PRODUCT_PACKAGES += \
	libmm-qcamera \
	camera.msm8916

# Touch issue workaround
PRODUCT_PACKAGES += \
	InputDisabler

# BoringSSL Hacks
PRODUCT_PACKAGES += \
	libboringssl-compat

# Libtime
PRODUCT_PACKAGES += \
	libtime_genoff

# Connectivity Engine support
PRODUCT_PACKAGES += \
	libcnefeatureconfig

# Location, WiDi
PRODUCT_PACKAGES += \
	com.android.location.provider \
	com.android.location.provider.xml \
	com.android.media.remotedisplay \
	com.android.media.remotedisplay.xml

# Display
PRODUCT_PACKAGES += \
	copybit.msm8916 \
	gralloc.msm8916 \
	hwcomposer.msm8916 \
	libtinyxml \
	libtinyxml2 \
	memtrack.msm8916

# Ebtables
PRODUCT_PACKAGES += \
	ebtables \
	ethertypes \
	libebtc
# FM
PRODUCT_PACKAGES += \
	FM2_Custom \
	FMRecord \
	libfmjni \
	libqcomfm_jni \
	qcom.fmradio

# libxml2
PRODUCT_PACKAGES += \
	libxml2

# Keystore
PRODUCT_PACKAGES += \
	keystore.msm8916

# healthd
PRODUCT_PACKAGES += \
	libhealthd.cm

# Power HAL
PRODUCT_PACKAGES += \
	power.qcom

# Lights
PRODUCT_PACKAGES += \
	lights.msm8916

# Media
PRODUCT_PACKAGES += \
	libextmedia_jni \
	libdashplayer \
	libdivxdrmdecrypt \
	libdrmclearkeyplugin \
	libstagefrighthw

# Sensors
PRODUCT_PACKAGES += \
	sensors.default

# Macloader
PRODUCT_PACKAGES += \
	macloader

# Ramdisk
PRODUCT_PACKAGES += \
	fstab.qcom \
	init.carrier.rc \
	init.class_main.sh \
	init.mdm.sh \
	init.link_ril_db.sh \
	init.qcom.audio.sh \
	init.qcom.bt.sh \
	init.qcom.uicc.sh \
	init.qcom.wifi.sh \
	init.qcom.post_boot.sh \
	init.qcom.class_core.sh \
	init.qcom.early_boot.sh \
	init.qcom.syspart_fixup.sh \
	init.qcom.usb.rc \
	init.qcom.usb.sh \
	init.qcom.rc \
	init.qcom.fm.sh \
	init.qcom.sh \
	ueventd.qcom.rc

# FS
PRODUCT_PACKAGES += \
	fsck.f2fs \
	mkfs.f2fs

# Substratum
PRODUCT_PACKAGES += \
	Substratum

# Misc
PRODUCT_PACKAGES += \
	curl \
	libbson \
	libcurl \
	ltrace \
	javax.btobex \
	tcmiface \
	tcpdump \
	libkeyutils \
	libjpega \
	libexifa \
	libstlport \
	sockev \
	rmnetcli \
	librmnetctl

# OMX
PRODUCT_PACKAGES += \
	libmm-omxcore \
	libOmxAacEnc \
	libOmxAmrEnc \
	libOmxCore \
	libOmxEvrcEnc \
	libOmxQcelp13Enc \
	libOmxSwVencMpeg4 \
	libOmxVdec \
	libOmxVdecHevc \
	libOmxVenc \
	libOmxVidEnc \
	libOmxVdpp

# Wifi
PRODUCT_PACKAGES += \
	hostapd \
	iwconfig \
	hostapd_cli \
	libQWiFiSoftApCfg \
	libqsap_sdk \
	libwpa_client \
	libwcnss_qmi \
	wcnss_service \
	wpa_supplicant
