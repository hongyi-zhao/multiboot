#!/usr/bin/env bash
#https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.html#usrlibexec
#https://groups.google.com/g/comp.unix.shell/c/2Wvk1O8ReG0
#pyenv.git grep -Po -ihR  '\${bash_source[^}]+}' . | sort -u
#echo ${BASH_SOURCE} ${BASH_SOURCE[*]} ${BASH_SOURCE[@]} ${#BASH_SOURCE[@]} 
#The command `readlink -e' is equivalent to `realpath -e'. 

#https://unix.stackexchange.com/questions/68484/what-does-1-mean-in-a-shell-script-and-how-does-it-differ-from
#I summarized Stéphane Chazelas' answer:

#    ${1:+"$@"}' test if $1 null or unset
#    ${1+"$@"}' test if $1 unset

#man bash
#  Parameter Expansion
#       When  not  performing  substring expansion, using the forms documented below (e.g., :-), bash
#       tests for a parameter that is unset or null.  Omitting the colon results in a test only for a
#       parameter that is unset.

#       ${parameter:-word}
#              Use  Default  Values.  If parameter is unset or null, the expansion of word is substi‐
#              tuted.  Otherwise, the value of parameter is substituted.
#      ${parameter:+word}
#              Use Alternate Value.  If parameter is null or unset, nothing is substituted, otherwise
#              the expansion of word is substituted.

#echo $# ${1:-${BASH_SOURCE[0]}}
#return 0 2>/dev/null || exit 0

#https://groups.google.com/g/comp.unix.shell/c/tof4eopmdU8
#Pure bash shell implementation for: $(basename "${1:-${BASH_SOURCE[0]}}")
unset scriptdir_realpath
unset script_realdirname script_dirname
unset script_realname script_name
unset script_realpath script_path
unset pkg_realpath
unset script_realbasename script_basename
unset script_realextname script_extname


scriptdir_realpath=$(cd -P -- "$(dirname -- "${1:-${BASH_SOURCE[0]}}")" && pwd -P)

script_realdirname=$(dirname "$(realpath -e "${1:-${BASH_SOURCE[0]}}")")
script_dirname=$(cd -- "$(dirname -- "${1:-${BASH_SOURCE[0]}}")" && pwd)

script_realname=$(basename "$(realpath -e "${1:-${BASH_SOURCE[0]}}")")
script_name=$(basename "${1:-${BASH_SOURCE[0]}}")

#https://groups.google.com/g/comp.unix.shell/c/tof4eopmdU8/m/_p9kLoBgCwAJ
#Unfortunately, the #, ##, %% and % operators can't be used with
#general expressions.  They only can be applied to variable names. 
#But you can achieve the wanted result in two steps: 

#script_name="${1:-${BASH_SOURCE[0]}}" && script_name="${script_name2##*/}" 

script_realpath=$script_realdirname/$script_realname
script_path=$script_dirname/$script_name

pkg_realpath=${script_realpath%.*}

script_realbasename=${script_realname%.*}
script_basename=${script_name%.*}

script_realextname=${script_realname##*.}
script_extname=${script_name##*.}



#接受相对路径，制作完成后，用下面的命令检查：
#$ strings grub-mkstandalone-x86_64.efi | grep -E '^(insmod|configfile)'
# 需要使用下面的选项，否则device，partition 名解析不出来：
#  --modules=MODULES      pre-load specified modules MODULES
# --modules='fat part_msdos part_gpt ext2 search_fs_uuid configfile'


#又加入以下预加载的模块：
#这些模块够用就行，后续需要再加载即可。
#另外，当使用grub-mkstandalone的时候，还会自动预加载 memdisk 、tar 两个模块。

if ! dpkg -s grub-efi >/dev/null 2>&1; then
  sudo apt-get install -y grub-efi
fi

#https://superuser.com/questions/479040/from-grub2-boot-an-iso-in-an-lvm2-logical-volume
grub-mkstandalone -O x86_64-efi -o grubx64.efi --modules='lvm fat ntfs part_msdos part_gpt ext2 btrfs probe regexp search configfile' boot/grub/grub.cfg=./boot/grub/grub.cfg



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




