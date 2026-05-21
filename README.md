# XhaxhWrt-Compile

> XhaxhWrt 源码编译固件，基于 [kiddin9/Kwrt](https://github.com/kiddin9/Kwrt)，x86_64 平台定制。

## 这是什么

从 OpenWrt 源码完整编译的自定义固件，适配 iKOOLCORE R2 Max 等 x86 软路由设备。

与 [XhaxhWrt](https://github.com/linooy/XhaxhWrt)（ImageBuilder 快速构建）的区别：

| | XhaxhWrt-Compile | XhaxhWrt |
|---|---|---|
| 方式 | 源码编译 (make) | ImageBuilder 拼包 |
| 时间 | 2-3 小时 | 几分钟 |
| 灵活度 | 可改内核/驱动/patches | 只能选预编译包 |
| 基于 | Kwrt (kiddin9) | ImmortalWrt |
| 适合 | 深度定制、新驱动 | 快速出包、日常升级 |

## 包含的软件

**代理 / VPN**
- passwall2 + xray-core + sing-box
- Shadowsocks / ShadowsocksR 全家桶
- WireGuard VPN

**容器**
- Docker + Docker Compose + Dockerman

**证书 / DNS**
- ACME (Let's Encrypt)
- DDNS (Cloudflare / DNSPod)

**监控**
- collectd 全套 + Statistics
- NUT (UPS 管理)
- nlbwmon (带宽监控)

**系统工具**
- appfilter (应用过滤)
- diskman / turboacc / webadmin
- smartmontools / lm-sensors / tcpdump / iperf3

**存储**
- btrfs / exfat / ntfs3 / f2fs / automount

## 品牌

- 发行版名：**Xhaxhwrt**
- 制造商：**power by xlin**

## 使用方法

### 构建固件

1. Fork 本仓库
2. 进入 Actions → `Build XhaxhWrt` → Run workflow
3. 等待编译完成（约 2-3 小时）
4. 在 Artifacts 下载固件

### 升级路由器

```bash
# 上传固件到路由器
scp XhaxhWrt-*-x86-64-generic-squashfs-combined.img.gz root@10.0.0.1:/tmp/

# SSH 到路由器
ssh root@10.0.0.1

# 解压
gunzip /tmp/XhaxhWrt-*.img.gz

# 保留配置升级（推荐）
sysupgrade -k /tmp/XhaxhWrt-*.img
```

### 首次刷入（全新安装）

```bash
# 写入 TF 卡 / USB
dd if=XhaxhWrt-*.img of=/dev/sdX bs=1M oflag=direct
```

## 配置说明

- `devices/common/.config` — 基础包配置（dnsmasq-full、Docker 内核支持等）
- `devices/x86_64/.config` — x86_64 定制包（passwall2、docker、acme 等）
- `devices/common/diy.sh` — 公共编译脚本（feeds、patches）
- `devices/x86_64/diy.sh` — x86 硬件驱动 + 品牌定制

个人 UCI 配置（网络、防火墙、passwall2 节点等）不编译进固件，通过 `sysupgrade -k` 保留。

## 基于

- [kiddin9/Kwrt](https://github.com/kiddin9/Kwrt) — OpenWrt 软路由固件
- [openwrt/openwrt](https://github.com/openwrt/openwrt) — OpenWrt 25.12
- GitHub Actions — 免费 CI/CD 编译

## 许可

继承上游 [Kwrt](https://github.com/kiddin9/Kwrt) 的许可协议。
