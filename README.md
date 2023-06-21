# multiboot

1. Set up according to the instructions [here](https://github.com/hongyi-zhao/multiboot/blob/master/refind/README). 
2. Clone this reop onto a separate ext4 partition locally. 
```
git init .
git remote add origin https://github.com/hongyi-zhao/multiboot.git 
git pull origin master
git branch --set-upstream-to=origin/master master
```
3. Then use this repository with my revised version of [multibootusb](https://github.com/hongyi-zhao/multibootusb.git) on the same local partition:
```
git clone https://github.com/hongyi-zhao/multibootusb.git multibootusb.git
```
Some more advanced usages:
```
http://www.dolda2000.com/~fredrik/doc/grub2
https://unix.stackexchange.com/questions/253657/actual-usage-of-grub-mkimage-config
http://lukeluo.blogspot.com/2013/06/grub-how-to-4-memdisk-and-loopback.html
```
