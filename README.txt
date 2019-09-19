sudo lxc-create -n [name] -t download -- -d ubuntu -r xenial -a amd64
sudo lxc-attach -n [name]
cd /root
apt install git
git clone https://github.com/bopolissimus/init-xenial-mahara.git

cd init-xenial-mahara
./tiger.sh
./xenial_setup.sh


