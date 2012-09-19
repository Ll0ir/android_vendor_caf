PRODUCT_BRAND ?= caf

ifneq ($(TARGET_BOOTANIMATION_NAME),)
    PRODUCT_COPY_FILES += \
        vendor/caf/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
endif

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/caf/CHANGELOG.mkdn:system/etc/CHANGELOG-caf.txt

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/caf/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/caf/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/caf/prebuilt/common/bin/50-caf.sh:system/addon.d/50-caf.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/caf/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/caf/prebuilt/common/bin/sysinit:system/bin/sysinit

# userinit support
PRODUCT_COPY_FILES += \
    vendor/caf/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# Compcache/Zram support
PRODUCT_COPY_FILES += \
    vendor/caf/prebuilt/common/etc/init.local.rc:system/etc/init.local.rc \
    vendor/caf/prebuilt/common/bin/compcache:system/bin/compcache \
    vendor/caf/prebuilt/common/bin/handle_compcache:system/bin/handle_compcache

PRODUCT_COPY_FILES +=  \
    vendor/caf/proprietary/Term.apk:system/app/Term.apk \
    vendor/caf/proprietary/lib/armeabi/libjackpal-androidterm4.so:system/lib/libjackpal-androidterm4.so \
	vendor/caf/prebuilt/common/apps/Superuser.apk:system/app/Superuser.apk

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/caf/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/caf/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# This is caf!
PRODUCT_COPY_FILES += \
    vendor/caf/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/caf/prebuilt/common/etc/mkshrc:system/etc/mkshrc


# Required caf packages
PRODUCT_PACKAGES += \
    Camera \
    Development \
    LatinIME \
    SpareParts \
    su

# Optional caf packages
PRODUCT_PACKAGES += \
    VideoEditor \
    VoiceDialer \
    SoundRecorder \
    Basic \
    HoloSpiralWallpaper \
    MagicSmokeWallpapers \
    NoiseField \
    Galaxy4 \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers \
    PhaseBeam

# Custom caf packages
PRODUCT_PACKAGES += \
    Trebuchet \
    DSPManager \
    audio_effects.conf \

# Extra tools in caf
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs

PRODUCT_PACKAGE_OVERLAYS += vendor/caf/overlay/dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/caf/overlay/common

PRODUCT_VERSION_MAJOR = 9
PRODUCT_VERSION_MINOR = 1
PRODUCT_VERSION_MAINTENANCE = 0

# Set caf_BUILDTYPE
ifdef caf_NIGHTLY
    caf_BUILDTYPE := NIGHTLY
endif
ifdef caf_EXPERIMENTAL
    caf_BUILDTYPE := EXPERIMENTAL
endif
ifdef caf_RELEASE
    caf_BUILDTYPE := RELEASE
endif

ifdef caf_BUILDTYPE
    ifdef caf_EXTRAVERSION
        # Force build type to EXPERIMENTAL
        caf_BUILDTYPE := EXPERIMENTAL
        # Add leading dash to caf_EXTRAVERSION
        caf_EXTRAVERSION := -$(caf_EXTRAVERSION)
    endif
else
    # If caf_BUILDTYPE is not defined, set to UNOFFICIAL
    caf_BUILDTYPE := UNOFFICIAL
    caf_EXTRAVERSION :=
endif

ifdef caf_RELEASE
    caf_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(caf_BUILD)
else
    caf_VERSION := $(PRODUCT_VERSION_MAJOR)-$(shell date -u +%Y%m%d)-$(caf_BUILDTYPE)-$(caf_BUILD)$(caf_EXTRAVERSION)
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.caf.version=$(caf_VERSION) \
  ro.modversion=$(caf_VERSION)
