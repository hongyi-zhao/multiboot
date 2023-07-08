#!/usr/bin/env bash

#接受相对路径，制作完成后，用下面的命令检查：
#$ strings grub-mkstandalone-x86_64.efi | grep -E '^(insmod|configfile)'
# 需要使用下面的选项，否则device，partition 名解析不出来：
#  --modules=MODULES      pre-load specified modules MODULES
# --modules='fat part_msdos part_gpt ext2 search_fs_uuid configfile'


#又加入以下预加载的模块：
#这些模块够用就行，后续需要再加载即可。
#另外，当使用grub-mkstandalone的时候，还会自动预加载 memdisk 、tar 两个模块。

#https://superuser.com/questions/479040/from-grub2-boot-an-iso-in-an-lvm2-logical-volume
#$ dpkg -l |grep grub-efi
#ii  grub-efi-amd64                                   2.06-2ubuntu14.1                         amd64        GRand Unified Bootloader, version 2 (EFI-AMD64 version)
#ii  grub-efi-amd64-bin                               2.06-2ubuntu14.1                         amd64        GRand Unified Bootloader, version 2 (EFI-AMD64 modules)
#ii  grub-efi-amd64-signed                            1.187.3+2.06-2ubuntu14.1                 amd64        GRand Unified Bootloader, version 2 (EFI-AMD64 version, signed)


# 在下面的命令中要求 grub.cfg 文件位于和 grubx64.efi 相同的目录下，即可（也可以使用其他的相对路径）：
grub-mkstandalone -O x86_64-efi -o grubx64.efi --modules='lvm fat ntfs part_msdos part_gpt ext2 btrfs probe regexp search configfile' boot/grub/grub.cfg=./grub.cfg


#https://wiki.archlinux.org/title/GRUB/Tips_and_tricks#GRUB_standalone
#GRUB standalone

#This section assumes you are creating a standalone GRUB for x86_64 systems (x86_64-efi). For 32-bit (IA32) EFI systems, replace x86_64-efi with i386-efi where appropriate.

#It is possible to create a grubx64_standalone.efi application which has all the modules embedded in a tar archive within the UEFI application, thus removing the need to have a separate directory populated with all of the GRUB UEFI modules and other related files. This is done using the grub-mkstandalone command (included in grub) as follows:

## echo 'configfile ${cmdpath}/grub.cfg' > /tmp/grub.cfg
## grub-mkstandalone -d /usr/lib/grub/x86_64-efi/ -O x86_64-efi --modules="part_gpt part_msdos" --locales="en@quot" --themes="" -o "esp/EFI/grub/grubx64_standalone.efi" "boot/grub/grub.cfg=/tmp/grub.cfg" -v

#Then copy the GRUB configuration file to esp/EFI/grub/grub.cfg and create a UEFI Boot Manager entry for esp/EFI/grub/grubx64_standalone.efi using efibootmgr.
#Note: The option --modules="part_gpt part_msdos" (with the quotes) is necessary for the ${cmdpath} feature to work properly.
#Warning: You may find that the grub.cfg file is not loaded due to ${cmdpath} missing a slash (i.e. (hd1,msdos2)EFI/Boot instead of (hd1,msdos2)/EFI/Boot) and so you are dropped into a GRUB shell. If this happens determine what ${cmdpath} is set to (echo ${cmdpath} ) and then load the configuration file manually (e.g. configfile (hd1,msdos2)/EFI/Boot/grub.cfg).
#Technical information

#The GRUB EFI file always expects its configuration file to be at ${prefix}/grub.cfg. However in the standalone GRUB EFI file, the ${prefix} is located inside a tar archive and embedded inside the standalone GRUB EFI file itself (inside the GRUB environment, it is denoted by "(memdisk)", without quotes). This tar archive contains all the files that would be stored normally at /boot/grub in case of a normal GRUB EFI install.

#Due to this embedding of /boot/grub contents inside the standalone image itself, it does not rely on actual (external) /boot/grub for anything. Thus in case of standalone GRUB EFI file ${prefix}==(memdisk)/boot/grub and the standalone GRUB EFI file reads expects the configuration file to be at ${prefix}/grub.cfg==(memdisk)/boot/grub/grub.cfg.

#Hence to make sure the standalone GRUB EFI file reads the external grub.cfg located in the same directory as the EFI file (inside the GRUB environment, it is denoted by ${cmdpath} ), we create a simple /tmp/grub.cfg which instructs GRUB to use ${cmdpath}/grub.cfg as its configuration (configfile ${cmdpath}/grub.cfg command in (memdisk)/boot/grub/grub.cfg). We then instruct grub-mkstandalone to copy this /tmp/grub.cfg file to ${prefix}/grub.cfg (which is actually (memdisk)/boot/grub/grub.cfg) using the option "boot/grub/grub.cfg=/tmp/grub.cfg".

#This way, the standalone GRUB EFI file and actual grub.cfg can be stored in any directory inside the EFI System Partition (as long as they are in the same directory), thus making them portable. 



# --loader 路径写法 ref：

# grubconfig.git/doc/Hybrid-UEFI-GPT+BIOS-GPT-MBR-boot/[steps-used-by-me]grub2-gpt-bios-efi

# 无论采用何种写法，最后以 efibootmgr 查看的结果为准：必须能够被efibootmgr
# 正确识别相应的路径。否则，就是错误的写法。

#参考后来gmail，arch maillist的讨论，似乎应该用下面的形式：

#--loader \\EFI\\grub-mkstandalone\\grub-mkstandalone-x86_64.efi


#sudo efibootmgr --create --disk /dev/sda --part 1 --loader \\EFI\\grub-mkstandalone\\grubx64.efi -w --label "grub-mkstandalone-grubx64 hd"

#sudo efibootmgr --create --disk /dev/sdc --part 1 --loader \\EFI\\grub-mkstandalone\\grubx64.efi -w --label "grub-mkstandalone-grubx64 usb p1"

#sudo efibootmgr --create --disk /dev/sdc --part 2 --loader \\EFI\\grub-mkstandalone\\grubx64.efi -w --label "grub-mkstandalone-grubx64 usb p2"

#实际测试，下面的形式也可以：

#sudo efibootmgr -c -d /dev/sda -p 1 -w -L 'grub-mkstandalone-grubx64 hd' -l /EFI/grub-mkstandalone/grubx64.efi




