#!/bin/bash
# 1. Copy this directory to the kernel source file named linux-xxx that you downloaded;
# 2. three points to focus on in this script depend on your environment.

kernel_path=$(dirname $(pwd))
kernel_list=(${kernel_path//// }) # Points ONE. four slashes. 
kernel_name=${kernel_list[-1]}
kernel_num=${kernel_name#*-}
echo -e "linux_kernel_source_code_path:\t" $kernel_path
echo -e "linux_kernel_source_code_name:\t" $kernel_name
echo -e "linux_kernel_source_code_num:\t" $kernel_num

sudo mv $kernel_path /usr/src

#sudo make clean

function install_package {
	sudo apt-get install -y vim
	sudo apt-get install -y gcc make libncurses5-dev openssl libssl-dev
	sudo apt-get install -y build-essential
	sudo apt-get install -y pkg-config
	sudo apt-get install -y libc6-dev
	sudo apt-get install -y bison
	sudo apt-get install -y flex
	sudo apt-get install -y libelf-dev
}

echo
echo "install_package."
echo
install_package

echo
echo "make menuconfig."
echo
sudo make menuconfig

echo
echo "make."
echo
sudo make -j$(nproc)
# Pointe TWO. Since you need to check whether the bzImage file is successfully generated, the path may be different for different machines. Here I take the x86 platform as an example: `/usr/src/$kernel_name/arch/x86/boot/bzImage`;
if [ ! -f "/usr/src/$kernel_name/arch/x86/boot/bzImage" ]; then
	echo "Not exits bzImage. Failed."
	exit 1
fi

echo
echo "make modules."
echo
sudo make modules

echo
echo "make modules_install."
echo
sudo make modules_install

# Points THREE. Because you need to check whether the module is compiled and installed successfully, you need to check whether there is a new kernel module file under `lib/modules`. Here I take linux-5.4.9 as an example (`/lib/modules/5.4.9`) , Usually create a folder under the name of the source code version number, here you need to pay attention to modification;

num=`echo -n ${kernel_num} | tr -cd "." | wc -c`
kernel_num_tmp=""
if [ $num -eq 1 ]; then
	kernel_num_tmp="${kernel_num}.0"
else
	kernel_num_tmp=${kernel_num}
fi

echo
echo "/lib/modules/${kernel_num_tmp}"
echo

if [ ! -d "/lib/modules/${kernel_num_tmp}" ];then
	echo "Modules make failed."
	exit 2
fi

echo
echo "make install."
echo
sudo make install

echo
echo "grub."
echo
sudo sed -i "s/GRUB_TIMEOUT_STYLE=hidden/#GRUB_TIMEOUT_STYLE=hidden/" /etc/default/grub
sudo sed -i "s/GRUB_TIMEOUT=0/GRUB_TIMEOUT=30/" /etc/default/grub
sudo sed -i "s/GRUB_HIDDEN_TIMEOUT=0/#GRUB_HIDDEN_TIMEOUT=0/" /etc/default/grub
sudo sed -i "s/GRUB_HIDDEN_TIMEOUT_QUIET=true/#GRUB_HIDDEN_TIMEOUT_QUIET=true/" /etc/default/grub
sudo update-grub

echo
echo "please reboot."
echo

