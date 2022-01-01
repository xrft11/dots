#!/usr/bin/env bash

###################################
#  _______
# < setup >
#  -------
#    \
#     \
#         .--.
#        |o_o |
#        |:_/ |
#       //   \ \
#      (|     | )
#     /'\_   _/`\
#     \___)=(___/
#
###################################

st="$dir/st"

dir="$HOME/.config/"

dwm="$dir/dwm/"

dmenu="$dir/dmenu/"

slstatus="$dir/slstatus/"

doas pacman -S --needed --noconfirm artix-archlinux-support > /dev/null 2>&1

doas pacman-key --populate archlinux > /dev/null 2>&1

doas cp /etc/pacman.conf /etc/pacman.conf.bak

doas printf '[options]
HoldPkg = pacman glibc
Architecture = auto
Color
CheckSpace
ParallelDownloads = 5
ILoveCandy

SigLevel = Required DatabaseOptional
LocalFileSigLevel = Optional

[system]
Include = /etc/pacman.d/mirrorlist

[world]
Include = /etc/pacman.d/mirrorlist

[galaxy]
Include = /etc/pacman.d/mirrorlist

[universe]
Server = https://universe.artixlinux.org/$arch
Server = https://mirror1.artixlinux.org/universe/$arch
Server = https://mirror.pascalpuffke.de/artix-universe/$arch
Server = https://artixlinux.qontinuum.space:4443/universe/os/$arch
Server = https://mirror.alphvino.com/artix-universe/$arch

[lib32]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist-arch

[community]
Include = /etc/pacman.d/mirrorlist-arch' > /etc/pacman.conf

doas rm /etc/pacman.d/mirrorlist-arch

doas printf 'Server = http://archlinux-br.com.br/archlinux/$repo/os/$arch
Server = https://archlinux-br.com.br/archlinux/$repo/os/$arch
Server = http://br.mirror.archlinux-br.org/$repo/os/$arch
Server = http://archlinux.c3sl.ufpr.br/$repo/os/$arch
Server = http://www.caco.ic.unicamp.br/archlinux/$repo/os/$arch
Server = https://www.caco.ic.unicamp.br/archlinux/$repo/os/$arch
Server = http://linorg.usp.br/archlinux/$repo/os/$arch
Server = http://archlinux.pop-es.rnp.br/$repo/os/$arch
Server = http://mirror.ufam.edu.br/archlinux/$repo/os/$arch
Server = http://mirror.ufscar.br/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist-arch

doas pacman -Syu --noconfirm > /dev/null 2>&1

doas pacman -S --noconfirm --needed autoconf automake binutils bison esysusers etmpfiles fakeroot file findutils flex gawk gcc gettext grep groff gzip libtool m4 make patch pkgconf sed texinfo which xorg-server xorg-xinit libxft xf86-video-intel ttf-roboto-mono ttf-font-awesome cantarell-fonts noto-fonts gtk-engines gtk-engine-murrine arc-solid-gtk-theme arc-icon-theme man redshift capitaine-cursors > /dev/null 2>&1

doas printf 'Section "Device"
    Identifier "Intel Graphics"
    Driver "intel"
    Option "DRI" "2"
    Option "VSync" "0"
    Option "TripleBuffer" "0"
    Option "SwapbuffersWait" "0"
EndSection

Section "ServerFlags"
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "BlankTime" "0"
    Option "OffTime" "0"
EndSection

Section "InputClass"
    Identifier "My Mouse"
    Option "AccelSpeed" "-1"
    Option "AccelerationProfile" "-1"
    Option "AccelerationScheme" "none"
Endsection

Section "InputClass"
    Identifier "system-keyboard"
    Option "XkbLayout" "br"
EndSection

Section "Extensions"
    Option "DPMS" "0"
Endsection' > /etc/X11/xorg.conf

doas printf '<device screen="0" driver="dri2">
    <application name="Default">
        <option name="vblank_mode" value="0"/>
    </application>
</device>

<device driver="i915">
    <application name="Default">
        <option name="stub_occlusion_query" value="true" />
        <option name="fragment_shader" value="true" />
    </application>
</device>' > /etc/dricrc

doas printf 'gtk-theme-name="Arc-Dark-solid"
gtk-theme-name="Arc-Dark-solid"
gtk-icon-theme-name="Arc"
gtk-font-name="Cantarell 11"
gtk-cursor-theme-name="capitaine-cursors-light"
gtk-cursor-theme-size=0
gtk-toolbar-style=GTK_TOOLBAR_BOTH
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=0
gtk-enable-input-feedback-sounds=0
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle="hintfull"
gtk-xft-rgba="rgb"' > $HOME/.gtkrc-2.0

printf '#!/bin/sh

slstatus &
~/.fehbg &
redshift -P -O 4500K &
xrdb -merge ~/.Xresources
/usr/bin/pipewire &
/usr/bin/pipewire-alsa &
/usr/bin/pipewire-pulse &
/usr/bin/pipewire-media-session &

exec dbus-launch --exit-with-session dwm' > ~/.xinitrc

doas printf'
LIBGL_DRI3_DISABLE=1' > /etc/environment

printf '
startx > /dev/null 2>&1' > $HOME/.bash_profile

doas printf 'set enable-keypad on' > /etc/inputrc

git clone --depth=1 https://github.com/xrft11/config.git $dir > /dev/null 2>&1

git clone --depth=1 https://github.com/pacokwon/onedarkhc.vim.git ~/dir/ > /dev/null 2>&1

rm -rf ~/dir/.git

rm -rf ~/dir/.gitignore

rm -rf ~/dir/LICENSE

rm -rf ~/dir/README.md

rm -rf ~/dir/screenshots

cd $dwm

make -j$(nproc) clean install > /dev/null 2>&1

cd $dmenu

make -j$(nproc) clean install > /dev/null 2>&1
cd $st

make -j$(nproc) clean install > /dev/null 2>&1

cd $slstatus

make -j$(nproc) clean install > /dev/null 2>&1

cd $HOME

startx > /dev/null 2>&1
