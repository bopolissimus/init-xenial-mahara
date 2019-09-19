
export NAME=m1

sudo lxc-create -n $NAME -t download -- -d ubuntu -r xenial -a amd64
sudo lxc-attach -n $NAME
cd /root
apt install -y git
git clone https://github.com/bopolissimus/init-xenial-mahara.git

cd init-xenial-mahara
sudo ./tiger.sh

# so we don't have permissions issues when we do pushd and popd as -i -u gerald
cd /home/gerald
sudo cp -Rf /root/init-xenial-mahara .
chown -R gerald:gerald init-xenial-mahara

# important, run this as gerald.  if you're root, become gerald first.
# although you could run this as root too and then just always do things
# as root
sudo -i -u gerald /bin/bash -c "cd init-xenial-mahara;./xenial_setup.sh"


