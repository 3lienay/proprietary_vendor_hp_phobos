LOCAL_PATH := $(call my-dir)

# Registra os blobs de vendor
include $(CLEAR_VARS)
LOCAL_MODULE := phobos-vendor-blobs
LOCAL_SRC_FILES := phobos-vendor-blobs.mk
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_SUFFIX := .mk
LOCAL_MODULE_PATH := $(TARGET_COPY_OUT_VENDOR)/$(TARGET_VENDOR)/$(TARGET_DEVICE)
include $(BUILD_PREBUILT)

# Registra a biblioteca pré-compilada libnvos
include $(CLEAR_VARS)
LOCAL_MODULE := libnvos
LOCAL_SRC_FILES := proprietary/lib/libnvos.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT)/lib
LOCAL_MODULE_TAGS := optional
LOCAL_MULTILIB := 32
include $(BUILD_PREBUILT)
