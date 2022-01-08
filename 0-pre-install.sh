#!/usr/bin/env bash

echo "-------------------------------------------------"
echo "Setting up mirrors for optimal download - US Only"
echo "-------------------------------------------------"
timedatectl set-ntp true
pacman -Sy
pacman -S --noconfirm reflector
reflector --verbose --latest 5 --sort rate -c "United States" --save /etc/pacman.d/mirrorlist

echo -e "\nInstalling prereqs...\n$HR"
pacman -S --noconfirm gptfdisk btrfs-progs

echo "-------------------------------------------------"
echo "-------select your disk to format----------------"
echo "-------------------------------------------------"
lsblk -f
echo "Please enter disk: (example /dev/sda)"
read DISK
echo "--------------------------------------"
echo -e "\nFormatting disk...\n$HR"
echo "--------------------------------------"

# disk prep
sgdisk -Z ${DISK} # zap all on disk
sgdisk -d 3 ${DISK} # format partition
sgdisk -d 2 ${DISK} # format partition
sgdisk -d 1 ${DISK} # format partition
sgdisk -a 2048 -o ${DISK} # new gpt disk 2048 alignment

# create partitions
sgdisk -n 1:0:+1024M ${DISK} # partition 1 (UEFI SYS), default start block, 1024MB
sgdisk -n 2:0:+32000M ${DISK} # partition 2 (Root), default start, 32GB
sgdisk -n 3:0:0 ${DISK} # partition 3 (Home), default start, remaining

# set partition types
sgdisk -t 1:ef00 ${DISK}
sgdisk -t 2:8300 ${DISK}
sgdisk -t 3:8300 ${DISK}

# label partitions
sgdisk -c 1:"UEFISYS" ${DISK}
sgdisk -c 2:"ARCH-ROOT" ${DISK}
sgdisk -c 3:"ARCH-HOME" ${DISK}

# make filesystems
echo -e "\nCreating Filesystems...\n$HR"

mkfs.vfat -F32 -n "UEFISYS" "${DISK}p1"
mkfs.ext4 -L "ARCH-ROOT" "${DISK}p2"
mkfs.ext4 -L "ARCH-HOME" "${DISK}p3"

# mount target
mkdir /mnt
mount -t ext4 "${DISK}p2" /mnt
mkdir -p /mnt/home
mount -t ext4 "${DISK}p3" /mnt/home/
mkdir -p /mnt/boot/efi
mount -t vfat "${DISK}p1" /mnt/boot/efi
mkdir -p /mnt/home/tmpScripts

lsblk -f
cp 1-after-arch-chroot.sh /mnt/home/tmpScripts

echo "--------------------------------------"
echo "-- Arch Install on Main Drive       --"
echo "--------------------------------------"
pacstrap /mnt base base-devel linux linux-firmware git vim sudo intel-ucode wget --noconfirm --needed
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
