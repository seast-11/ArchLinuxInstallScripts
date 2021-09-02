#!/usr/bin/env bash

echo -e "\nINSTALLING AUR SOFTWARE\n"

cd "${HOME}"

echo "CLOING: YAY"
git clone "https://aur.archlinux.org/yay.git"

PKGS=(
    # UTILITIES -----------------------------------------------------------

    'libxft-bgra'                   # FIX dwm emojis in status bar
    'i3lock-fancy'                  # Screen locker
    'font-manager'		            # Font Manager    
    'pnmixer'                       # Volume icon for trayer

    # THEMES and FONTS--------------------------------------------------------------

    'lightdm-webkit-theme-aether'   # Lightdm Login Theme - https://github.com/NoiSek/Aether#installation
    'materia-gtk-theme'             # Desktop Theme
    'papirus-icon-theme'            # Desktop Icons
    'capitaine-cursors'             # Cursor Themes
    'ttf-font-awesome-4'            # Awesome fonts
)

cd ${HOME}/yay
makepkg -si

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

echo -e "\nDone!\n"
