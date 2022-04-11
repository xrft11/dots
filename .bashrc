###################################
#  ________
# < bashrc >
#  --------
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

export PS1='[$(tput bold)\]\[$(tput setaf 7)\[\[\[$(tput setaf 1)\]\u\[$(tput setaf 7)\]@\[$(tput setaf 1)\]\h \[$(tput setaf 1)\]\W\[$(tput setaf 7)\]]\[$(tput setaf 1)\]\$ \[$(tput sgr0)\] '
export LANG='en_US.UTF-8'
export LC_COLLATE='C'
export QT_QPA_PLATFORMTHEME='qt5ct'

alias   p='doas pacman -Syu' \
        v='nvim' \
        h='htop' \
        n='neofetch' \
        g='git clone --depth=1' \
        c='curl -fLO' \
        i='doas pacman -S --needed' \
        u='doas pacman -Rns --noconfirm' \
        s='doas pacman -Ss' \
        q='doas pacman -Q | grep' \
        d='doas' \
        r='rm -rf' \
        l='ls -la' \
        po='loginctl poweroff' \
        re='loginctl reboot' \
        co='doas make -j$(nproc) clean install' \
        un='doas make -j$(nproc) clean uninstall' \
        dv='doas nvim' \
        dr='doas rm -rf' \
        dm='doas mkdir -p' \
        up='doas pacman -Syu' \
        mk='mkdir -p' \
        sudo='doas' \
        wget='curl -fLO' \
        startx='startx > /dev/null 2>&1' \
