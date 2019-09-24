
export NAME=m1

sudo lxc-create -n $NAME -t download -- -d ubuntu -r xenial -a amd64
sudo lxc-start -n $NAME
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

# run as gerald (with -i so $HOME is also set correctly) so that
# files are owned by gerald, not root
sudo -i -u gerald /bin/bash -c "cd init-xenial-mahara;./xenial_setup.sh"


