# Initial setup of Raspberry Pi
## Download the image from kali linux
https://kali.download/arm-images/kali-2023.4/kali-linux-2023.4-raspberry-pi-arm64.img.xz
unxz the image and write to the SD card
dd if=/root/kali-linux-2023.4-raspberry-pi-arm64.img of=/dev/sdb status=progress bs=4M conv=fsync

connect to wifi

run Ansible playbook