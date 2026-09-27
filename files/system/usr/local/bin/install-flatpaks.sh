#!/bin/bash

# Waits for flathub to be reachable over HTTPS (the protocol we actually need).
# ICMP ping was used here before, but QEMU/libvirt usermode networking (e.g. GNOME Boxes'
# default NAT) frequently doesn't forward ICMP even when HTTPS works fine, which left this
# loop spinning forever and the whole first-boot flatpak install never running.
until curl --silent --fail --max-time 5 --output /dev/null https://flathub.org; do
  sleep 5
done

flatpak update --appstream -y

# install apps. 
# on exit code 0(sucessfull activation) the script ends sucesfully.
if flatpak install -y --system flathub com.vscodium.codium org.gnome.Calculator org.gnome.TextEditor org.gnome.baobab org.gnome.Evince com.mattjakeman.ExtensionManager io.github.kolunmi.Bazaar; then
  systemctl disable first-boot-flatpaks.service
fi