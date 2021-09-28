#!/bin/sh
if groups $USER | grep -q "sudo"
	then echo ""
	else echo "User is not in sudo group, probably doesn't have perms to set up and load module" ; exit 1
fi

bold=$(tput bold)
normal=$(tput sgr0)

echo "${bold}Creating folder${normal}"
mkdir r8152
cd r8152
echo "${bold}Downloading driver tarball${normal}"
wget https://github.com/Ivy2345/aukeyusbclinux/raw/main/r8152.tar.xz
echo "${bold}Extracting tarball${normal}"
tar -xf ./r8152.tar.xz
rm ./r8152.tar.xz
echo "${bold}Compiling source code${normal}"
make
echo "${bold}Copying udev rule (you may need to enter your password)${normal}"
sudo cp ./50-usb-realtek-net.rules /lib/udev/rules.d/
echo "${bold}Setting up and loading${normal}"
sudo depmod -a
sudo update-initramfs -u
sudo modprobe r8152
echo "${bold}Removing source code folder${normal}"
cd ..
rm -r ./r8152
