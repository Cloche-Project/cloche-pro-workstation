#!/bin/bash

# Tries to listen do flathub to continue
until ping -c 1 -W 1 flathub.org >/dev/null 2>&1; do
  sleep 5
done

flatpak update --appstream -y

# install apps. 
# on exit code 0(sucessfull activation) the script ends sucesfully.
if flatpak install -y --system flathub com.vscodium.codium org.gnome.Calculator org.gnome.TextEditor org.gnome.baobab org.gnome.Evince com.mattjakeman.ExtensionManager io.github.kolunmi.Bazaar; then
  systemctl disable first-boot-flatpaks.service
fi