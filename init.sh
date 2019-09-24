#!/bin/bash

if [ -z $1 ]
then
  echo "Missing lxc instance name.  Usage: $0 [name]"
  exit -1
fi

export NAME=$1

sudo lxc-create -n $NAME -t download -- -d ubuntu -r xenial -a amd64
sudo lxc-start -n $NAME
sudo lxc-attach -n $NAME -- bash -c "cd /root;apt install -y git;git clone https://github.com/bopolissimus/init-xenial-mahara.git"

sudo lxc-attach -n $NAME -- bash -c "cd /root;cd init-xenial-mahara;./tiger.sh"

# so we don't have permissions issues when we do pushd and popd as -i -u gerald
sudo lxc-attach -n $NAME -- bash -c "cd /home/gerald;cp -Rf /root/init-xenial-mahara .;chown -R gerald:gerald init-xenial-mahara"

#cd /home/gerald
#sudo cp -Rf /root/init-xenial-mahara .
#chown -R gerald:gerald init-xenial-mahara

# run as gerald (with -i so $HOME is also set correctly) so that
# files are owned by gerald, not root
# during the postfix dialog, select local only.
sudo lxc-attach -n $NAME -- bash -c "/usr/bin/sudo -i -u gerald /bin/bash -c 'cd init-xenial-mahara;./xenial_setup.sh'"


