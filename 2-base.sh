#!/usr/bin/env bash

echo -e "\nInstalling Base System\n"

PKGS=(

    # --- Setup Desktop
        'rofi'                      # Menu System
        'xclip'                     # System Clipboard
        'trayer'                    # System Tray
        'flameshot'                 # Screenshot Utility
        'alacritty'                 # Terminal Emulator
        'dunst'                     # Notifcation daemon
        'numlockx'                  # Numlocks ON tool

    # --- Xmonad WM 
        'xmonad'                    # Xmonad 
        'xmonad-contrib'            # Xmonad scripts
        'xdotool'                   # Xmonad clickable tabs

    # --- Login Display Manager
        'lightdm'                   # Base Login Manager
        'lightdm-webkit2-greeter'   # Framework for Awesome Login Themes

    # --- Networking Setup
        'wpa_supplicant'            # Key negotiation for WPA wireless networks
        'dialog'                    # Enables shell scripts to trigger dialog boxes
        'network-manager-applet'    # System tray icon/utility for network connectivity
    
    # --- Audio
        'alsa-utils'                # Advanced Linux Sound Architecture (ALSA) Components https://alsa.opensrc.org/
        'alsa-plugins'              # ALSA plugins
        'pulseaudio'                # Pulse Audio sound components
        'pulseaudio-alsa'           # ALSA configuration for pulse audio
        'pavucontrol'               # Pulse Audio volume control

    # --- Fonts
        'ttf-jetbrains-mono'        # Jetbrains fonts 
        'ttf-joypixels'             # Joypixel fonts 
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo -e "\nDone!\n"
