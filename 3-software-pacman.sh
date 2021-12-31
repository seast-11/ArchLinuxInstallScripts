#!/usr/bin/env bash

echo -e "\nINSTALLING SOFTWARE\n"

PKGS=(

    # SYSTEM --------------------------------------------------------------

    #'linux-lts'             # Long term support kernel

    # TERMINAL UTILITIES --------------------------------------------------

    'htop'                  # Process viewer
    'neofetch'              # Shows system info when you launch terminal
    'p7zip'                 # 7z compression program
    'unrar'                 # RAR compression program
    'unzip'                 # Zip compression program
    'zip'                   # Zip compression program
    'sysstat'               # Contains mpstat for CPU utilization
    'stow'                  # .dotfile management
    'tree'                  # terminal tree viewer

    # ZSH Terminal Emulator ----------------------------------------------

    'zsh'                   # ZSH shell
    'zsh-completions'       # Tab completion for ZSH
    'zsh-syntax-highlighting'
    'zsh-autosuggestions'

    # DISK UTILITIES ------------------------------------------------------

    'btrfs-progs'           # BTRFS Support
    'dosfstools'            # DOS Support
    'exfat-utils'           # Mount exFat drives
    'ntfs-3g'               # Open source implementation of NTFS file system
    'smbclient'             # SMB Connection 
    'xfsprogs'              # XFS Support
    'gvfs-smb'              # Seems to be required for pcmanfm SMB integration
    'pcmanfm'               # File explorer
    'file-roller'           # Archive Utility

    # DEVELOPMENT ---------------------------------------------------------

    'clang'                 # C Lang compiler
    'cmake'                 # Cross-platform open-source make system
    'gcc'                   # C/C++ compiler
    'glibc'                 # C libraries
    'python'                # Scripting language
    'dotnet-runtim'         # C# runtime
    'dotnet-host'           # .NET host
    'dotnet-sdk'            # .NET SDK

    # MEDIA ---------------------------------------------------------------

    'celluloid'             # Video player
    
    # GRAPHICS AND DESIGN -------------------------------------------------

    'gcolor2'               # Colorpicker
    'gimp'                  # GNU Image Manipulation Program
    'ristretto'             # Multi image viewer

    # PRODUCTIVITY --------------------------------------------------------

    'xpdf'                  # PDF viewer
    'libreoffice-still'     # Libre Office stable release
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo -e "\nDone!\n"
