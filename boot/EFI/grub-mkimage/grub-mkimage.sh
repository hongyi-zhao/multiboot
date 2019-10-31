首先准备如下文件：
grub-mkimage.cfg 


sudo grub-mkimage -c grub-mkimage.cfg -o grub-mkimage-x86_64.efi -O x86_64-efi -p ''  fat part_msdos part_gpt ext2 search_fs_uuid configfile


grubconfig.git/boot/EFI$ sudo cp -r * /mnt/sda2/EFI/

sudo efibootmgr --create --disk /dev/sda --part 2 --loader /EFI/grub-mkimage/grub-mkimage-x86_64.efi --label "grub-mkimage-x86_64 hd"


这样就可以了，这个就已经不在需要 其他配置文件了。

