## /usr/bin/bash
# A script for installing my preffered apps
echo "This Script needs to be run as a non-admin user with sudo installed, if this is, press enter" && read -s -n 1
read -N 1 -p "Install Apps, Kernels, and Desktop Environments? (y,N)" answer
echo
if [ "${answer,,}" == "y" ]
then
## Install Vim then edits /etc/pacman.conf
echo "Enable community-testing, multilib, and multilib-testing"
sudo pacman -Syyu vim && sudo vim /etc/pacman.conf

## Install Apps in Pacman
sudo pacman -Syyu linux-zen linuz-zen-headers linux-lts linux-lts-headers vim git reflector ranger htop alacritty ark dolphin konqueror plasma plasma-wayland-session wayland i3 xfce4 qemu virt-manager iptables-nft ebtables zsh archlinux-keyring virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libguestfs wget curl glibd winetricks wine wine-mono wine-gecko base-devel

## Enable QEMU and Virt-Manager
sudo systemctl enable libvirtd.service && sudo systemctl start libvirtd.service
echo "Find 'unix_sock_group = (libvirt)' and Find 'unix_sock_rw_perms = 0770' and uncomment them. When You Are Done, use :wq! to Save and Exit" && read -s -n 1
sudo vim /etc/libvirt/libvirtd.conf
sudo usermod -aG libvirt $(whoami)
newgrp libvirt

## Install SpaceVim and Oh My ZSH
curl -sLf https://spacevim.org/install.sh | bash && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Install Yay AUR Helper
mkdir ~/git && cd ~/git
git clone https://aur.archlinux.org/yay.git
sudo makepkg -si && makepkg -si

## Install Trizen AUR Helper and Other AUR apps
yay -Syyu trizen ani-cli-git badlion-client gopsuinfo hid-nintendo-dkms joycon-git libwm-git nwg-drawer python-dasbus snapd snapd-glib tbsm tulizu winegui wmutils-git

echo "Done! No Need to Re-run to Update Apps, Just Run 'sudo pacman -Syyu && yay -Syyu'"
fi 
