#!/usr/bin/env bash

echo -e "\nInstalling clean suckless DWM System\n"

PKGS=(
    # --- Nvidia  
        'nvidia'                # Nvidia drivers 
        'nvidia-settings'       # Nvidia settings 
        'nvidia-utils'          # Nvidia utils 

    # --- XORG Display Rendering
        'xterm'                 # Terminal for TTY
        'xorg-server'           # XOrg server
        'xorg-xinit'            # XOrg init
        'xorg-xsetroot'         # XOrg title bar setter

    # --- Setup Desktop
        'picom'                 # Translucent Windows
        'nitrogen'              # Wallpaper Manager
        'lxappearance'          # Set System Themes
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo -e "\nInstalling custom seast11 dwm\n"

cd ~ 
mkdir Repos
cd Repos
git clone https://github.com/seast-11/dwm.git
cd dwm
sudo make clean install

echo -e "\nInstalling custom seast11 dwmblocks\n"

cd ~
cd Repos
git clone https://github.com/seast-11/dwm-blocks.git
cd dwm-blocks
sudo make clean install

echo -e "\nInstalling St\n"

cd ~
cd Repos
wget https://dl.suckless.org/st/st-0.8.4.tar.gz
tar -xzvf st-0.8.4.tar.gz
cd st-0.8.4
sudo make clean install

echo -e "\nInstalling Dmenu\n"

cd ~
cd Repos
wget https://dl.suckless.org/tools/dmenu-5.0.tar.gz
tar -xzvf dmenu-5.0.tar.gz
cd dmenu-5.0
sudo make clean install

echo -e "\nConfiguring .xinitrc\n"

cd ~
cat /etc/X11/xinit/xinitrc | head -n -5 > .xinitrc
echo "" >> .xinitrc
#echo "xrandr --output Virtual-1 --mode 1920x1440 &" >> .xinitrc
echo "nitrogen --restore &" >> .xinitrc
echo "picom &" >> .xinitrc
echo "exec dwm" >> .xinitrc

echo -e "\nDone!\n"
