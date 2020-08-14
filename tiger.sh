#!/bin/bash

cat /etc/apt/sources.list| sed "s/\/\/archive.ubuntu.com/nz.archive.ubuntu.com/" > /tmp/sources.list
mv /etc/apt/sources.list /etc/apt/sources.list.ori
mv /tmp/sources.list /etc/apt/sources.list
apt-get update

apt install -y openssh-server vim-nox lsof mate-desktop-environment xrdp xauth

# in case we're testing with a dev jenkins
apt install -y jq

useradd --groups sudo -s /bin/bash -m gerald
sed -i -re "s/(^%sudo.*)ALL$/\1 NOPASSWD:ALL/" /etc/sudoers

cp -Rf common/.ssh /home/gerald/
cp -Rf common/.vnc /home/gerald/
cp common/.bashrc /home/gerald
cp common/*.sh /home/gerald

chown -R gerald:gerald /home/gerald

# workaround chromium-browser not displaying correctly in my lxc setups when X11Forwarding
sudo -l -u gerald  xdg-mime default firefox.desktop text/html

