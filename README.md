# custom-debian-installer
Builds an custom Debian Strech installer with serial console enabled by default on /dev/ttyS0, speed 115200. No need to type "H" during boot or to modify Grub loader. Compatible with a vast number of computers, from DECISO to Supermicro computers. Build your own installer or download one. Available for x86, x64 and soon arm. 

custom-debian-installer is a wrapper around build-simple-cdd scrpit and Debian preseed configuration.

Using the Official Debian installer for a serial console installation is still possible:
* Follow Debian guidelines to make a CD or USB key, and press "H" on boot to access help.
* Press F10 or F12 hoping this does not interfere with your running environment.
* Upon reboot, you will need to modify /etc/defaut/grub to enable serial console. 


This installer has been tested on:
* Generic PC X86 system that is serial console.
* DECISO A10
* Supermicro servers 
* Dell serverss
* VM using serial console

# Serial console
By default, serial console is set to:
/dev/ttyS0 115200

Modify /profiles/serial-console.conf to enable an alternative serial port and/or speed.

# Debian architectures
Available in two architectures:
* amd64 (64 bit architecture)
* i386 (32 bit architecture)

Builds an amd64 installer by defaut. Modify /profiles/headless.conf to enable i386.
An unofficial installer for i386 can be build using an amd64 host and the converse is also true.

The i386 installer is slightly different and needs more testing.
Under ALIX 2D13, it is required to use i386 and a CD-ROM, as booting from USB stick is not supported.

# Debian flavors
Built for Debian latest release with security fixes:
Debian 9.8 (Stretch) 

# Firmware
The installer includes free and non-free firmware allowing to detect network cards:
* firmware-linux-nonfree
* firmware-bnx2
* firmware-bnx2x
* firmware-cavium
* firmware-linux
* firmware-misc-nonfree
* firmware-qlogic
* firmware-realtek

# Running the script

Use a Debian Strech host for building. Building under Debian testing or Debian sid may result in an error.

Checkout the project:

	git clone https://github.com/mrth3p1auge/headless-debian.git 

	cd headless-debian 

You may need to customize profiles/serial-console.conf

Then build the CD:

	sh ./custom-debian-installer.sh

The resulting installer CD is in:
	images/debian-9.8-amd64-CD-1.iso

Burn a CD-ROM or transfer to a USB key.

# Screenshots

The installation under serial console is using only ASCII characters, and thus is very slylish and old-fashioned. Here are a few screenshots from the installer. Nothing new under the sun, as this is a plain Debian installer:

Installer has only English locales, choose whatever, this can be changed after first boot:


Choose an installation mirror:

	lqqqqqqqqqqqqqqqqqqu [!] Configure the package manager tqqqqqqqqqqqqqqqqqqk
	x                                                                         x
	x The goal is to find a mirror of the Debian archive that is close to     x
	x you on the network -- be aware that nearby countries, or even your      x
	x own, may not be the best choice.                                        x
	x                                                                         x
	x Debian archive mirror country:                                          x
	x                                                                         x
	x                      Colombia                                           x
	x                      Costa Rica                  a                      x
	x                      Croatia                                            x
	x                      Czechia                     a                      x
	x                      Denmark                     a                      x
	x                      El Salvador                 a                      x
	x                      Estonia                     a                      x
	x                      Finland                     a                      x
	x                      France                                             x
	x                                                                         x
	x     <Go Back>                                                           x
	x                                                                         x
	mqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqj

	<Tab> moves; <Space> selects; <Enter> activates buttons


Install Grub bootloader:

	lqqqqqqqqqqqu [!] Install the GRUB boot loader on a hard disk tqqqqqqqqqqqk
	x                                                                         x
	x You need to make the newly installed system bootable, by installing     x
	x the GRUB boot loader on a bootable device. The usual way to do this     x
	x is to install GRUB on the master boot record of your first hard         x
	x drive. If you prefer, you can install GRUB elsewhere on the drive, or   x
	x to another drive, or even to a floppy.                                  x
	x                                                                         x
	x Device for boot loader installation:                                    x
	x                                                                         x
	x        Enter device manually                                            x
	x        /dev/sda  (nvme-SATA_SSD_128GB)                    x
	x        /dev/sdb  (usb-Multiple_TL001)            x
	x                                                                         x
	x     <Go Back>                                                           x
	x                                                                         x
	mqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqj

	<Tab> moves; <Space> selects; <Enter> activates buttons

Reboot!

	The system is going to reboot.

WARNING: at present, it reboots on the installer. So remove the installation media as quickly as possible.

# Upon first boot

Customize to your needs.

Reconfigure your locales:

	$ dpkg-reconfigure locales


# Default users and password
By default the openssh-server will not allow root to login, so durring the install two accounts are careated:

| User      |  Password  |
| --------- | ---------- |
| root      | toor       |
| tuffguy   | heycoolaid |

