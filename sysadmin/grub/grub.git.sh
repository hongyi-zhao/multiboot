sudo apt-get build-dep grub2

直接使用系统的包库的方法：
sudo apt install grub-pc-bin grub-efi-ia32-bin grub-efi-amd64-bin


i386-pc 平台：

werner@debian-01:/media/werner/a0e7dcd3-e295-4c51-bdd4-5119475d3898$ sudo grub-install --recheck --boot-directory=/media/werner/a0e7dcd3-e295-4c51-bdd4-5119475d3898/grubconfig.git/boot/ /dev/sda 

efi相关，ref：

/media/werner/e3e084db-7f7f-47cb-866b-743b7c5758ec1/grubconfig.git/doc/Hybrid-UEFI-GPT+BIOS-GPT-MBR-boot/[steps-used-by-me]grub2-gpt-bios-efi



编译安装：
ref:
INSTALL

# git 版本需要下面这步：
./bootstrap 

分别编译安装下面的平台版本：
./configure --target=x86_64 --with-platform=efi
./configure --target=i386 --with-platform=pc


但是make遇到错误：
symlist.h:26:10: fatal error: ../include/grub/machine/pxe.h: No such file or directory
 #include <../include/grub/machine/pxe.h>
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          
          
$ git tag | grep -E '^grub-[0-9.]+$' | tail -1
grub-2.04

后来发现，checkout 最新稳定版没有问题。


make -j24

安装完成后，如果后续不直接使用 grub-install ，而是使用 grub-mkimage/grub-mkstandalone 来进行工作，那么需要下面的操作：

cd grubconfig.git/boot/grub
cp -r /usr/local/lib/grub/* 
























