#接受相对路径，测试如下：
#$ strings grub-mkstandalone-x86_64.efi | grep -E  '^configfile '
#configfile ${cmdpath}/grub.cfg
werner@kubuntu:/mnt/sda2$ sudo grub-mkstandalone -O x86_64-efi -o grub-mkstandalone-x86_64.efi boot/grub/grub.cfg=./grub-mkstandalone.cfg


grubconfig.git/boot/EFI$ sudo cp -r * /mnt/sda2/EFI/


# grub-mkstandalone-x86_64.efi 这个文件必须和它调用的 grub.cfg 在同一个目录：

# --loader 路径写法 ref：

# grubconfig.git/doc/Hybrid-UEFI-GPT+BIOS-GPT-MBR-boot/[steps-used-by-me]grub2-gpt-bios-efi

sudo efibootmgr --create --disk /dev/sda --part 2 --loader /EFI/grub-mkstandalone/grub-mkstandalone-x86_64.efi --label "grub-mkstandalone-x86_64 hd"




