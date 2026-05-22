#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

#bash $SHELL_FOLDER/../common/kernel_6.6.sh

sed -i 's/Os/O2/g' include/target.mk

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/x86/files target/linux/x86/patches-6.12

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/x86/base-files/etc/board.d/02_network -P target/linux/x86/base-files/etc/board.d/

sed -i 's/kmod-r8169/kmod-r8168/' target/linux/x86/image/64.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-fs-f2fs kmod-mmc kmod-sdhci kmod-usb-hid usbutils pciutils lm-sensors-detect kmod-atlantic kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-r8101 kmod-r8125 kmod-r8126 kmod-8139cp kmod-8139too kmod-i40e kmod-drm-amdgpu kmod-mlx4-core kmod-mlx5-core fdisk lsblk kmod-phy-broadcom kmod-ixgbevf/' target/linux/x86/Makefile

sed -i 's/256/1024/g' target/linux/x86/image/Makefile

# Fix missing NOTICE file for kiddin9 luci-base
touch feeds/NOTICE feeds/LICENSE 2>/dev/null || true

# Fix Docker build: openwrt-25.12 missing TARGET env var (master already fixed)
sed -i '/\.\/scripts\/build\/binary/i\t\tTARGET=$(PKG_BUILD_DIR)/build \\' feeds/packages/utils/docker/Makefile 2>/dev/null || true
# === XhaxhWrt 品牌定制（覆盖上游 Kiddin'/Kwrt/openwrt.ai） ===
# 这些在 common/diy.sh 的 "Kiddin'" 替换之后执行，覆盖回去
sed -i "s/Kiddin'/power by xlin/g" package/base-files/files/etc/os-release
sed -i "s/Kwrt/Xhaxhwrt/g" package/base-files/files/etc/os-release
sed -i "s|https://openwrt.ai/||g" package/base-files/files/etc/os-release
sed -i "s/Kiddin'/power by xlin/g" package/base-files/files/bin/config_generate
sed -i "s/Kwrt/Xhaxhwrt/g" package/base-files/files/bin/config_generate
sed -i "s/Kiddin'/power by xlin/g" package/base-files/image-config.in
sed -i "s/Kwrt/Xhaxhwrt/g" package/base-files/image-config.in
sed -i "s/Kiddin'/power by xlin/g" config/Config-images.in
sed -i "s/Kwrt/Xhaxhwrt/g" config/Config-images.in
sed -i "s/Kiddin'/power by xlin/g" include/version.mk
sed -i "s/Kwrt/Xhaxhwrt/g" include/version.mk
