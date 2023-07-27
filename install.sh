#!/bin/bash

# Main program
# ------------

# Services reconfiguration
clear && dpkg-reconfigure locales
clear && dpkg-reconfigure debconf

# Backup sources.list
cp /etc/apt/sources.list /etc/apt/sources.list.orig
# Update sources.list
sed -i "/main/s/\$/ contrib non-free&/" /etc/apt/sources.list

# APT update
clear && apt update && apt upgrade

# Packages installation [Base]
clear && apt install -y  bzip2 zip unzip rar unrar
clear && apt install -y  xserver-xorg-core xfonts-base mesa-utils
clear && apt install -y  acpid ntpdate rcconf

# Packages installation [i3]
clear && apt install -y i3-wm lxdm picom unclutter connman

# Packages installation [Dev]
clear && apt install -y build-essential module-assistant fakeroot kernel-package libncurses5-dev

# Packages installation [intel]
clear && apt install -y xserver-xorg-video-intel

# Firefox installation
# clear && wget $FIREFOXURL/$FIREFOX && tar xjf $FIREFOX -C /opt && rm $FIREFOX

# Enable/Restart NetworkManager [managed -> true]
# nano /etc/NetworkManager/NetworkManager.conf && /etc/init.d/network-manager restart

# clear && systemctl enable sddm
clear && systemctl enable connman

# Reboot computer
systemctl reboot
