# odroid-c2-rtc

![RTC Shield](https://cdn.shopify.com/s/files/1/1884/2123/products/RTC_Shield_for_C2_2_600x313.jpg)

Use and automate kernel updates for the PCF8563 [RTC Shield](https://ameridroid.com/products/rtc-shield-for-c2) on the ODROID-C2 running Arch ARM.

## Installation

* Physically install the RTC Shield on the ODROID-C2 as depicted [here](https://wiki.odroid.com/accessory/add-on_boards/rtc_shield).
* Download and install [odroid-c2-rtc](https://aur.archlinux.org/packages/odroid-c2-rtc) from the AUR.

## Setup post installation
1. Edit `/etc/mkinitcpio.conf` and add the following two modules to the MODULES array:
```
MODULES=( aml_i2c rtc_pcf8563 ... )
```

2. Regenerate the kernel image:
```
# mkinitcpio -p linux-odroid-c2
==> Building image from preset: /etc/mkinitcpio.d/linux-odroid-c2.preset: 'default'
  -> -k 3.16.61-1-ARCH -c /etc/mkinitcpio.conf -g /boot/initramfs-linux.img
==> Starting build: 3.16.61-1-ARCH
  -> Running build hook: [base]
  -> Running build hook: [udev]
  -> Running build hook: [autodetect]
  -> Running build hook: [modconf]
  -> Running build hook: [block]
  -> Running build hook: [filesystems]
  -> Running build hook: [keyboard]
  -> Running build hook: [fsck]
==> Generating module dependencies
==> Creating gzip-compressed initcpio image: /boot/initramfs-linux.img
==> Image generation successful
```

## Notes

Currently (3.16.61), the sx865x module (touch screen driver) breaks the needed module to communicate with RTC shield. This package will blacklist it for us. The consequence of this is that anyone with the 3.5 inch LCD is SOL. If you have a fix for this, please send let me know.
