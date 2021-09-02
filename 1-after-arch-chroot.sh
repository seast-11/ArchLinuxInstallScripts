echo "-------------------------------------------------"
echo "       Setup Language to US and set locale       "
echo "-------------------------------------------------"

read -p "Enter hostname:" hostname

ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo $hostname >> /etc/hostname
echo '127.0.0.1    localhost' >> /etc/hosts
echo '::1    localhost' >> /etc/hosts
echo "127.0.0.1    $hostname.localdomain    $hostname" >> /etc/hosts

echo "--------------------------------------"
echo "--          Swap Setup              --"
echo "--------------------------------------"
dd if=/dev/zero of=/swapfile bs=1M count=1024 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
sed -i -e '$a# swapfile' /etc/fstab
sed -i -e '$a/swapfile    none    swap    defaults    0 0' /etc/fstab

nc=$(grep -c ^processor /proc/cpuinfo)
echo "You have " $nc" cores."
echo "-------------------------------------------------"
echo "Changing the makeflags for "$nc" cores."
sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nc\"/g" /etc/makepkg.conf
echo "Changing the compression settings for "$nc" cores."
sed -i "s/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g" /etc/makepkg.conf

pacman -S --noconfirm reflector 
reflector --verbose --latest 5 --sort rate -c "United States" --save /etc/pacman.d/mirrorlist

echo "--------------------------------------"
echo "--          Network Setup           --"
echo "--------------------------------------"
pacman -S networkmanager --noconfirm --needed
systemctl enable --now NetworkManager

echo "--------------------------------------"
echo "--      Set Password for Root       --"
echo "--------------------------------------"
echo "Enter password for root user: "
passwd root

echo "--------------------------------------"
echo "--      Set User                    --"
echo "--------------------------------------"
useradd -m -g users -G wheel -s /bin/bash sean 
passwd sean 
# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

echo "--------------------------------------"
echo "--      Boot Setup                  --"
echo "--------------------------------------"
pacman -S grub efibootmgr os-prober ntfs-3g --noconfirm --needed

echo "" >> /etc/default/grub
# enable prober for Winblowz and adding other distros to grub
echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
# if the OS doesn't show up in boot menu you have to add --removable for some lame reason
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg

exit
umount -R /mnt
