### 1. Grub Setup

`/etc/default/grub`

```shell
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=0 console=tty2 udev.log_level=0 intel_idle.max_cstate=1 cryptomgr.notests initcall_debug intel_iommu=igfx_off no_timer_check noreplace-smp page_alloc.shuffle=1 rcupdate.rcu_expedited=1 tsc=reliable nowatchdog i915.fastboot=1 i915.enable_fbc=1 i915.error_capture=0 i915.enable_dp_mst=0 i915.enable_dc=0 i915.disable_power_well=1 i915.enable_dpcd_backlight=0 i915.enable_guc=0 i915.enable_psr=0 i915.enable_psr2_sel_fetch=0 i915.guc_log_level=0 i915.panel_use_ssc=0 module_blacklist=iTCO_wdt,iTCO_vendor_support,btusb,btrtl,btbcm,btintel,bluetooth"
```

### 2. Blacklist

`/etc/modpribe.d/blacklist.conf`

```shell
install btusb /bin/true
install btrtl /bin/true
install btbcm /bin/true
install btintel /bin/true
install iTCO_wdt /bin/true
install bluetooth /bin/true
install iTCO_vendor_support /bin/true
```

### 3. i915 Parameters

`/etc/modprobe.d/i915.conf`

```shell
options i915 fastboot=1 enable_fbc=1 error_capture=0 enable_dp_mst=0 enable_dc=0 disable_power_well=1 enable_dpcd_backlight=0 enable_guc=0 enable_psr=0 enable_psr2_sel_fetch=0 guc_log_level=0 panel_use_ssc=0
```

### 4. Early KMS

`/etc/mkinitcpio.conf`

```shell
MODULES=(i915)
```

### 5. Enabling Esync

`/etc/security/limits.conf`

```shell
username hard nofile 524288
```

### 6. Wine Setup
```shell
doas pacman -S --needed --noconfirm lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader vulkan-mesa-layers lib32-vulkan-mesa-layers lib32-gnutls lib32-libxcomposite wireplumber pipewire pipewire-alsa pipewire-jack pipewire-pulse lib32-pipewire lib32-libpulse vkd3d lib32-vkd3d gamemode lib32-gamemode
lib32-alsa-plugins winetricks lutris
```

### 7. osu! Setup
```shell
WINEPREFIX=~/Games/osu WINEARCH=win32 WINE=~/.local/share/lutris/runners/wine/lutris-fshack-5.6-5-x86_64/bin/wine winetricks dotnet45 gdiplus sound=alsa fontfix fontsmooth=rgb
```

### 8. Virt-Manager Setup
`br10.xml`
```shell
<network>
  <name>br10</name>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='br10' stp='on' delay='0'/>
  <ip address='192.168.30.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.30.50' end='192.168.30.200'/>
    </dhcp>
  </ip>
</network>
```

```shell
doas pacman -S --needed virt-manager qemu libvirt-runit edk2-ovmf iptables-nft dnsmasq bridge-utils openbsd-netcat
```

```shell
doas ln -s /etc/runit/sv/libvirtd /run/runit/service/; doas ln -s /etc/runit/sv/virtlogd /run/runit/service/; doas usermod -aG libvirt $USER; doas virsh net-define ~/.br10.xml; doas virsh net-start br10; doas virsh net-autostart br10
```
