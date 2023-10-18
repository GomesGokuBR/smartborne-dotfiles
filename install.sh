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
clear && apt-get install -y sddm --no-install-recommends
clear && apt install -y i3-wm
clear && apt install -y picom unclutter connman


# Packages installation [Dev]
clear && apt install -y build-essential module-assistant fakeroot libncurses5-dev
clear && apt install -y libgtk-3-0 libblkid1 liblzma5 libbluetooth-dev glibc-source

# Packages installation [intel]
clear && apt install -y xserver-xorg-video-intel

# Alacritty installation
clear && apt install -y alacritty

clear && systemctl enable sddm
clear && systemctl enable connman

# Download apps sources
clear && mkdir -p /home/pygma/apps
cd /home/pygma/apps

wget https://apps-sources.s3.fr-par.scw.cloud/sm.zip
unzip sm.zip
rm sm.zip
sleep 1

cp ./libBxlPosAPI.so.1.1.7 /usr/lib/
cp ./libBxlPosAPI_v1.1.7.a /usr/lib/
ln -sf /usr/lib/libBxlPosAPI.so.1.1.7 /usr/lib/libBxlPosAPI.so
sleep 1

cp ./libBxlPosAPI.so.1.1.7 /usr/lib64/
cp ./libBxlPosAPI_v1.1.7.a /usr/lib64/
ln -sf /usr/lib64/libBxlPosAPI.so.1.1.7 /usr/lib64/libBxlPosAPI.so
sleep 1

rm libBxlPosAPI.so.1.1.7
rm libBxlPosAPI_v1.1.7.a
sleep 1

# Create services
chmod +x back-end/sb-scan/sb_scan
systemctl link back-end/sb-scan/sb_scan.service
systemctl enable sb_scan.service
sleep 1

chmod +x back-end/sb-controller/sb_controller
systemctl link back-end/sb-controller/sb_controller.service
systemctl enable sb_controller.service
sleep 1

chmod +x back-end/sb-core/sb_core
systemctl link back-end/sb-core/sb_core.service
systemctl enable sb_core.service
sleep 1

chmod +x front-end/smartborne_desktop_app
systemctl link front-end/sb_ui.service
systemctl enable sb_ui.service
sleep 1

# Reboot computer
systemctl reboot
