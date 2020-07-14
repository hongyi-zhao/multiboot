# multiboot


1. Do the settings according the notes here: doc/README. 

2. Use the first partition formatted with ext4 to populate this repo locally. 


```
git init .
git remote add origin https://github.com/hongyi-zhao/multiboot.git 
git pull origin master
git branch --set-upstream-to=origin/master master

```

3. Then use this repo combined with my revised version of [multibootusb](https://github.com/hongyi-zhao/multibootusb.git) on the same partition locally:

```
git clone https://github.com/hongyi-zhao/multibootusb.git multibootusb.git
```

Some more advanced usages:

```
http://www.dolda2000.com/~fredrik/doc/grub2
https://unix.stackexchange.com/questions/253657/actual-usage-of-grub-mkimage-config
http://lukeluo.blogspot.com/2013/06/grub-how-to-4-memdisk-and-loopback.html
```
