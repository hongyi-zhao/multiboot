首先准备如下文件：
grub-mkimage.cfg 


sudo grub-mkimage -c grub-mkimage.cfg -o grub-mkimage-x86_64.efi -O x86_64-efi -p '' fat part_msdos part_gpt ext2 regexp iso9660 loopback chain search configfile

sudo grub-mkstandalone -O x86_64-efi -o grub-mkstandalone-x86_64.efi --modules='fat part_msdos part_gpt ext2 regexp iso9660 loopback chain search configfile'  boot/grub/grub.cfg=./grub-mkstandalone.cfg


sudo efibootmgr --create --disk /dev/sda --part 2 --loader /EFI/grub-mkimage/grub-mkimage-x86_64.efi --label "grub-mkimage-x86_64 hd"


这样就可以了，这个就已经不在需要 其他配置文件了。

