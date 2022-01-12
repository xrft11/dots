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

st='$dir/st'

dir='/home/*/.config/'

dwm='$dir/dwm/'

home='/home/*/'

dmenu='$dir/dmenu/'

slstatus='$dir/slstatus/'

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
</device>' > /etc/drirc

printf '#!/usr/bin/env bash

~/.fehbg &
slstatus &
pipewire &
wireplumber &
pipewire-alsa &
pipewire-pulse &
xrdb ~/.Xdefaults
redshift -P -O 4000K &

exec dbus-launch --exit-with-session dwm' > $home/.xinitrc

printf '
LIBGL_DRI3_DISABLE=1' > /etc/environment

printf '
startx > /dev/null 2>&1' > $home/.bash_profile

pacman -S --needed --noconfirm artix-archlinux-support > /dev/null 2>&1

pacman-key --populate archlinux > /dev/null 2>&1

mv /etc/pacman.conf /etc/pacman.conf.bak

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
Server = https://artixlinux.qontinuum.space:4443/universe/os/$arch
Server = https://mirror.alphvino.com/artix-universe/$arch

[lib32]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist-arch

[community]
Include = /etc/pacman.d/mirrorlist-arch' > /etc/pacman.conf

mv /etc/pacman.d/mirrorlist-arch /etc/pacman.d/mirrorlist-arch.bak

printf 'Server = http://archlinux-br.com.br/archlinux/$repo/os/$arch
Server = https://archlinux-br.com.br/archlinux/$repo/os/$arch
Server = http://br.mirror.archlinux-br.org/$repo/os/$arch
Server = http://archlinux.c3sl.ufpr.br/$repo/os/$arch
Server = http://www.caco.ic.unicamp.br/archlinux/$repo/os/$arch
Server = https://www.caco.ic.unicamp.br/archlinux/$repo/os/$arch
Server = http://linorg.usp.br/archlinux/$repo/os/$arch
Server = http://archlinux.pop-es.rnp.br/$repo/os/$arch
Server = http://mirror.ufam.edu.br/archlinux/$repo/os/$arch
Server = http://mirror.ufscar.br/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist-arch

pacman -Syu --noconfirm > /dev/null 2>&1

pacman -S --noconfirm --needed autoconf automake binutils bison esysusers etmpfiles fakeroot file findutils flex gawk gcc gettext grep groff gzip libtool m4 make patch pkgconf sed texinfo which xorg-server xorg-xinit libxft xf86-video-intel ttf-roboto-mono ttf-font-awesome cantarell-fonts noto-fonts gtk-engines gtk-engine-murrine man redshift capitaine-cursors arc-solid-gtk-theme arc-icon-theme gnome-themes-standard elementary-icon-theme > /dev/null 2>&1

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

git clone --depth=1 https://github.com/xrft11/config.git $dir > /dev/null 2>&1

git clone --depth=1 https://github.com/pacokwon/onedarkhc.vim.git $home/dir/ > /dev/null 2>&1

mv $home/dir/colors/ $dir/nvim/

mv $home/dir/autoload/ $dir/nvim/

rm -rf $home/dir/

cd $dwm

make -j$(nproc) clean install > /dev/null 2>&1

cd $dmenu

make -j$(nproc) clean install > /dev/null 2>&1

cd $st

make -j$(nproc) clean install > /dev/null 2>&1

cd $slstatus

make -j$(nproc) clean install > /dev/null 2>&1

cd $home

startx > /dev/null 2>&1
