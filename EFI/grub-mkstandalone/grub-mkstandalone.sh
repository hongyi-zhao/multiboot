#接受相对路径，制作完成后，用下面的命令检查：
#$ strings grub-mkstandalone-x86_64.efi | grep -E '^(insmod|configfile)'
# 需要使用下面的选项，否则device，partition 名解析不出来：
#  --modules=MODULES      pre-load specified modules MODULES
# --modules='fat part_msdos part_gpt ext2 search_fs_uuid configfile'


#又加入以下预加载的模块：
#这些模块够用就行，后续需要再加载即可。
#另外，当使用grub-mkstandalone的时候，还会自动预加载 memdisk 、tar 两个模块。

grub-mkstandalone -O x86_64-efi -o grubx64.efi --modules='fat part_msdos part_gpt ext2 probe regexp search configfile' boot/grub/grub.cfg=./boot/grub/grub.cfg


#
# grub-mkstandalone-x86_64.efi 它调用的 grub.cfg 在同一个目录，就可以了。

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




