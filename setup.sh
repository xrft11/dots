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

st='/home/*/.config/st/'

dwm='/home/*/.config/dwm/'

dmenu='/home/*/.config/dmenu/'

slstatus='/home/*/.config/slstatus/'

xinitrc='/home/*/.xinitrc'

nvim='/home/*/.config/nvim/'

home='/home/*'

printf '<device screen="0" driver="dri2">
    <application name="Default">
        <option name="vblank_mode" value="0"/>
    </application>
</device>

<device driver="i915">
    <application name="Default">
        <option name="stub_occlusion_query" value="true" />
        <option name="fragment_shader" value="true" />
    </application>
</device>' >> /etc/drirc

printf '#!/usr/bin/env bash

redshift -P -O 4000K &
~/.fehbg &
dunst &
pipewire &
slstatus &
wireplumber &
pipewire-alsa &
pipewire-jack &
pipewire-pulse &
xrdb ~/.Xdefaults

exec dbus-launch --exit-with-session dwm' >> $xinitrc

printf '
LIBGL_DRI3_DISABLE=1' >> /etc/environment

printf '
startx > /dev/null 2>&1' >> $home/.bash_profile

pacman -S --needed --noconfirm artix-archlinux-support

pacman-key --populate archlinux

printf '[options]
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
Server = https://artixlinux.qontinuum.space:4443/artixlinux/universe/os/$arch
Server = https://mirror1.cl.netactuate.com/artix/universe/$arch

#[lib32]
#Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist-arch

[community]
Include = /etc/pacman.d/mirrorlist-arch' > /etc/pacman.conf

pacman -Syu --noconfirm

pacman -S --noconfirm --needed autoconf automake binutils bison esysusers etmpfiles fakeroot file findutils flex gawk gcc gettext grep groff gzip libtool m4 make patch pkgconf sed texinfo which xorg-server xorg-xinit libxft xf86-video-intel ttf-roboto-mono ttf-font-awesome cantarell-fonts noto-fonts gtk-engines gtk-engine-murrine mandoc redshift capitaine-cursors arc-solid-gtk-theme arc-icon-theme lxappearance dunst libnotify

printf 'Section "Device"
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

git clone https://github.com/xrft11/config $home/.config

git clone https://github.com/pacokwon/onedarkhc.vim $home/

mv $home/onedarkhc.vim/colors/ $nvim

mv $home/onedarkhc/autoload/ $nvim

rm -rf $home/onedarkhc.vim

cd $dwm

make -j$(nproc) clean install

cd $dmenu

make -j$(nproc) clean install

cd $st

make -j$(nproc) clean install

cd $slstatus

make -j$(nproc) clean install

cd $home

startx
