# Shims
TARGET_LD_SHIM_LIBS := \
    /system/lib/libcrypto.so|libboringssl-compat.so \
    /system/lib/libmmjpeg_interface.so|libboringssl-compat.so \
    /system/lib/libsec-ril.so|libshim_secril.so \
    /system/lib/libsec-ril-dsds.so|libshim_secril.so \
    /system/lib/libizat_core.so|libshim_gps.so \
    /system/vendor/lib/hw/camera.vendor.msm8916.so|libcamera_shim.so