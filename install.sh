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
clear && apt install -y  xserver-xorg-core xfonts-base mesa-utils x11-xserver-utils
clear && apt install -y  acpid ntpdate rcconf

# Packages installation [i3]
clear && apt install -y i3-wm picom unclutter connman
clear && apt-get install -y sddm --no-install-recommends

# Packages installation [Dev]
clear && apt install -y build-essential module-assistant fakeroot libncurses5-dev
clear && apt install -y libgtk-3-0 libblkid1 liblzma5 libbluetooth-dev glibc-source

# Packages installation [intel]
clear && apt install -y xserver-xorg-video-intel

# Alacritty installation
clear && apt install -y alacritty
sed -i 's/i3-sensible-terminal/alacritty/' ~/.config/i3/config

# Unclutter configuration
sed -i -e '$a\\n# Unclutter configuration'
sed -i -e '$a unclutter -idle 0 &'

clear && systemctl enable sddm
clear && systemctl enable connman

# Reboot computer
systemctl reboot
