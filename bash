#!/bin/bash

set -e

echo "Criando estrutura e arquivos de blobs..."

# Caminho base
BASE_DIR="vendor/hp/phobos"

# Garante que estamos no diretório correto
if [ ! -d "$BASE_DIR/proprietary" ]; then
    echo "ERRO: Execute esse script a partir da raiz do seu tree de device (onde está o diretório vendor/hp/phobos)."
    exit 1
fi

# 1. Criação do phobos-vendor-blobs.mk
cat << 'EOF' > $BASE_DIR/phobos-vendor-blobs.mk
PRODUCT_COPY_FILES += \
    vendor/hp/phobos/proprietary/lib/libgov_tbc.so:system/lib/libgov_tbc.so \
    vendor/hp/phobos/proprietary/lib/libussrd.so:system/lib/libussrd.so \
    vendor/hp/phobos/proprietary/vendor/bin/usdwatchdog:system/bin/usdwatchdog \
    vendor/hp/phobos/proprietary/vendor/bin/ussrd:system/bin/ussrd \
    vendor/hp/phobos/proprietary/etc/nvram_4334.txt:system/etc/nvram_4334.txt \
    vendor/hp/phobos/proprietary/vendor/firmware/bcm4334/fw_bcmdhd.bin:system/vendor/firmware/bcm4334/fw_bcmdhd.bin \
    vendor/hp/phobos/proprietary/vendor/firmware/bcm4334/fw_bcmdhd_apsta.bin:system/vendor/firmware/bcm4334/fw_bcmdhd_apsta.bin
EOF

echo "✔ Criado: phobos-vendor-blobs.mk"

# 2. Criação do Android.mk
cat << 'EOF' > $BASE_DIR/Android.mk
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
include $(LOCAL_PATH)/phobos-vendor-blobs.mk
EOF

echo "✔ Criado: Android.mk"

# 3. Verifica se o device.mk já tem o include
DEVICE_MK="device/hp/phobos/device.mk"

if grep -q "phobos-vendor-blobs.mk" "$DEVICE_MK"; then
    echo "✔ device.mk já contém o include dos blobs."
else
    echo -e "\n# Proprietary blobs\n\$(call inherit-product, vendor/hp/phobos/phobos-vendor-blobs.mk)" >> "$DEVICE_MK"
    echo "✔ Include adicionado ao device.mk"
fi

echo -e "\n✅ Todos os arquivos foram criados e configurados!"

