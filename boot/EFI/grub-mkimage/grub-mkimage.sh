首先准备如下文件：
grub-mkimage.cfg 

#/dev/sda2                          vfat                       /mnt/sda2                              EF4B-3153
search.fs_uuid EF4B-3153 root
# 根据情况修改：
set prefix=($root)'/EFI/uefi-hd'
configfile $prefix/grub.cfg

sudo grub-mkimage -c grub-mkimage.cfg -o grub-mkimage-x86_64.efi  -O x86_64-efi -p ''  $( ls -1 /usr/local/lib/grub/x86_64-efi/*.mod | sed 's/\.mod//;s/.*\///' | xargs )

加载那些模块就足够了呢？
sudo grub-mkimage -c grub-mkimage/grub-mkimage.cfg -o grub-mkimage-x86_64.efi  -O x86_64-efi -p '' fat part_msdos part_gpt ext2 regexp search_fs_uuid search configfile
