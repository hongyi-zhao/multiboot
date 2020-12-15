$ sudo apt-get build-dep grub2
$ sudo apt-get install libzfslinux-dev

直接使用系统的包库的方法：
sudo apt install grub-pc-bin grub-efi-ia32-bin grub-efi-amd64-bin

编译安装：
ref:
INSTALL

# git 版本需要下面这步：
./bootstrap 

分别编译安装下面的平台版本：
./configure --target=x86_64 --with-platform=efi
./configure --target=i386 --with-platform=pc

make -j24

# 执行下面的安装操作，以便 grub-mkimage/grub-mkstandalone 使用相应的库：
sudo make install

