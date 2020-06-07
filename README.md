# multiboot


1. Use the first partition's formatted with fat32 filesystem to populate the EFI folder extracted from the 
[refind](https://sourceforge.net/projects/refind/files/)'s CD-R image. The most recently worked version is [0.11.5](https://sourceforge.net/projects/refind/files/0.11.5/refind-cd-0.11.5.zip/download) based on my tests with the methods described here.
See doc/README for more info.

2. Use the second partition formatted with ext4 to populate this repo locally. 


```
git init .
git remote add origin https://github.com/hongyi-zhao/multiboot.git 
git pull origin master
git branch --set-upstream-to=origin/master master

```

3. Then use this repo combined with my revised version of [multibootusb](https://github.com/hongyi-zhao/multibootusb.git) on the same partition locally:

`
git clone https://github.com/hongyi-zhao/multibootusb.git multibootusb.git
`

See here for some more advanced usage:

```
http://www.dolda2000.com/~fredrik/doc/grub2
https://unix.stackexchange.com/questions/253657/actual-usage-of-grub-mkimage-config
http://lukeluo.blogspot.com/2013/06/grub-how-to-4-memdisk-and-loopback.html
```
