#!/usr/bin/env bash
# Obtain the canonicalized absolute dirname where the script resides.
# Both readlink and realpath can do the trick.
topdir=$(
cd -P -- "$(dirname -- "$(realpath -e -- "${BASH_SOURCE[0]}")" )" &&
pwd -P
) 

# In the following method, the $script_dirname is equivalent to $topdir otained above in this script:
script_realpath="$(realpath -e -- "${BASH_SOURCE[0]}")"

if [[ "$(realpath -e -- "${BASH_SOURCE[0]}")" =~ ^(.*)/(.*)$ ]]; then
  script_dirname="${BASH_REMATCH[1]}"
  script_name="${BASH_REMATCH[2]}"
  #echo script_dirname="$script_dirname"
  #echo script_name="$script_name"
  # . not appeared in script_name at all.
  if [[ "$script_name"  =~ ^([^.]*)$ ]]; then
    script_basename="$script_name"
    #echo script_basename="$script_basename"
  else
    # . appeared in script_name. 
    # As far as filename is concerned, when . is used as the last character, it doesn't have any spefical meaning.
    # Including . as the beginning character.
    if [[ "$script_name"  =~ ^([.].*)$ ]]; then
      script_extname="$script_name"
      #echo script_extname="$script_extname"
    # Including . but not as the beginning/trailing character.
    elif [[ "$script_name"  =~ ^([^.].*)[.]([^.]+)$  ]]; then
      script_basename="${BASH_REMATCH[1]}"
      script_extname="${BASH_REMATCH[2]}"
      #echo script_basename="$script_basename"
      #echo script_extname="$script_extname"
    fi
  fi
fi

#https://unix.stackexchange.com/questions/18886/why-is-while-ifs-read-used-so-often-instead-of-ifs-while-read

# software/anti-gfw/not-used/vpngate-relative/ecmp-vpngate/script/ovpn-traverse.sh
# man find:
# -printf format
# %f     File's name with any leading directories removed (only the last element).
# %h     Leading directories of file's name (all but the last element).  
# If the file name contains  no  slashes
#             (since it is in the current directory) the %h specifier expands to `.'.       
# %H     Starting-point under which file was found.  
# %p     File's name.
# %P     File's name with the name of the starting-point under which it was found removed.

if [[ $script_extname == "sh" ]]; then
  if [ -d "$topdir/$script_basename" ]; then  
    cd $topdir/$script_basename
    ncore=$(sudo dmidecode -t 4 | grep 'Core Enabled:' | awk '{a+=$NF}END{ print a }')
  fi
  cd $topdir
fi



#接受相对路径，制作完成后，用下面的命令检查：
#$ strings grub-mkstandalone-x86_64.efi | grep -E '^(insmod|configfile)'
# 需要使用下面的选项，否则device，partition 名解析不出来：
#  --modules=MODULES      pre-load specified modules MODULES
# --modules='fat part_msdos part_gpt ext2 search_fs_uuid configfile'


#又加入以下预加载的模块：
#这些模块够用就行，后续需要再加载即可。
#另外，当使用grub-mkstandalone的时候，还会自动预加载 memdisk 、tar 两个模块。

if ! dpkg -s grub-efi >/dev/null 2>&1; then
  sudo apt-get install grub-efi
fi

grub-mkstandalone -O x86_64-efi -o grubx64.efi --modules='fat ntfs part_msdos part_gpt ext2 btrfs probe regexp search configfile' boot/grub/grub.cfg=./boot/grub/grub.cfg





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




