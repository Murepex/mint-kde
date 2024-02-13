#!/bin/bash
set -e
echo "[KDE Install for Linux Mint 21.*]"
echo "Run this script as root!"
echo "WARNING!"
echo "This will uninstall your current Desktop and delete all the config files!"
echo ""
echo "Do not run this script in a desktop environment! Go in terminal mode with Strg + Alt + F5 or some other F-Key depending on your distro"
echo ""
printf "Continue? [y/n] "

read continue

pulsaudio_start_file="/usr/bin/start-pulseaudio-x11"
pulsaudio_bluetooth_insert="    /usr/bin/pactl load-module module-bluetooth-discover"

if [[ "$continue" == "y" ]]; then
    echo "Removing packets and configurations..."
    apt purge $(dpkg -l | awk '/^ii/ && ($2 ~ /^cinnamon/ || $2 ~ /^nemo/ || $2 ~ /^xplayer/ || $2 ~ /^xed/ || $2 ~ /^pix/ || $2 ~ /^xviewer/ || $2 ~ /^gnome/ || $2 ~ /^libreoffice/  || $2 ~ /^mate/ || $2 ~ /^onboard/ || $2 ~ /^hypnotix/ || $2 ~ /^redshift/ || $2 ~ /^sticky-thingy/ || $2 ~ /^webapp-manager/ || $2 ~ /^rhythmbox/ || $2 ~ /^gimp/ || $2 ~ /^inkscape/ || $2 ~ /^thunderbird/ || $2 ~ /^brasero/ || $2 ~ /^shotwell/ || $2 ~ /^pidgin/ || $2 ~ /^transmission/ || $2 ~ /^cheese/ || $2 ~ /^simple-scan/ || $2 ~ /^totem/ || $2 ~ /^remmina/ || $2 ~ /^bluez/ || $2 ~ /^timeshift/ || $2 ~ /^xreader/ || $2 ~ /^gufw/ || $2 ~ /^synaptic/ || $2 ~ /^baobab/ || $2 ~ /^hexchat/ || $2 ~ /^lightdm-settings/ || $2 ~ /^mintinstall/ || $2 ~ /^mintbackup/ || $2 ~ /^mintlocale/ || $2 ~ /^sticky/ || $2 ~ /^bulky/ || $2 ~ /^gucharmap/ || $2 ~ /^drawing/ || $2 ~ /^celluloid/ || $2 ~ /^warpinator/ || $2 ~ /^xf/ || $2 ~ /^xfwm/ || $2 ~ /^driver-manager/ || $2 ~ /^xfce/ || $2 ~ /^mintreport/ || $2 ~ /^thunar/ || $2 ~ /^compizconfig-settings-manager/ || $2 ~ /^mugshot/ || $2 ~ /^mintwelcome/ ) { print $2 }') -y
    echo "Adding Kubuntu Backports-extra repository for newer Version of KDE..."
    add-apt-repository ppa:kubuntu-ppa/backports-extra -y
    apt update
    echo "Installing KDE Plasma and usefull programms..."
    apt install kde-plasma-desktop sddm-theme-breeze plasma-nm gwenview okular libreoffice libreoffice-style-breeze libreoffice-kde5 libreoffice-plasma vlc thunderbird thunderbird-locale-de ark kde-spectacle kcalc pulseaudio-module-bluetooth -y
    apt remove sddm-theme-debian-maui kwalletmanager pavucontrol kdeconnect -y
    echo "Editing Config Files..."
    awk -v text="$pulsaudio_bluetooth_insert" '/if \[ x"\$DISPLAY" != x \] ; then/ {print $0 RS text; next} 1' "$pulsaudio_start_file" > temp && mv temp "$pulsaudio_start_file"
    echo "Everything was installed successfully!"
    echo "Please reboot the system!"
fi
