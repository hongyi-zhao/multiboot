#接受相对路径，测试如下：
#$ strings grub-mkstandalone-x86_64.efi | grep -E  '^configfile '
#configfile ${cmdpath}/grub.cfg
werner@kubuntu:/mnt/sda2$ sudo grub-mkstandalone -O x86_64-efi -o grub-mkstandalone-x86_64.efi boot/grub/grub.cfg=./grub-mkstandalone/grub-mkstandalone.cfg

# grub-mkstandalone-x86_64.efi 这个文件必须和它调用的 grub.cfg 在同一个目录：
sudo efibootmgr --create --disk /dev/sda --part 2 --loader /mnt/sda2/grub-mkstandalone-x86_64.efi --label "grub-mkstandalone-x86_64 hd"
sudo efibootmgr --create --disk /dev/sda --part 2 --loader /mnt/sda2/grub-mkimage-x86_64.efi --label "grub-mkimage-x86_64 hd"



