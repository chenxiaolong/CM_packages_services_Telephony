LOCAL_PATH:= $(call my-dir)

# Build the Phone app which includes the emergency dialer. See Contacts
# for the 'other' dialer.
include $(CLEAR_VARS)

LOCAL_JAVA_LIBRARIES := telephony-common voip-common
LOCAL_STATIC_JAVA_LIBRARIES := com.android.phone.shared \
        com.android.services.telephony.common \
        guava \
        gservices

LOCAL_SRC_FILES := $(call all-java-files-under, src)
LOCAL_SRC_FILES += \
        src/com/android/phone/EventLogTags.logtags \
        src/com/android/phone/INetworkQueryService.aidl \
        src/com/android/phone/INetworkQueryServiceCallback.aidl

# Include Google Play Services
gservices_res := ../../../external/google/google_play_services/libproject/google-play-services_lib/res
LOCAL_RESOURCE_DIR := $(addprefix $(LOCAL_PATH)/, $(gservices_res) res)

LOCAL_AAPT_FLAGS := \
    --auto-add-overlay \
    --extra-packages com.google.android.gms

LOCAL_PACKAGE_NAME := TeleService

LOCAL_CERTIFICATE := platform
LOCAL_PRIVILEGED_MODULE := true

LOCAL_PROGUARD_FLAG_FILES := proguard.flags

include $(BUILD_PACKAGE)

include $(CLEAR_VARS)
LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := \
    gservices:../../../external/google/google_play_services/libproject/google-play-services_lib/libs/google-play-services.jar
include $(BUILD_MULTI_PREBUILT)

# Build the test package
include $(call all-makefiles-under,$(LOCAL_PATH))
