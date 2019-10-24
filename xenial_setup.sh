#!/bin/bash

# if you're gerald, do tiger.sh first.

# if you're in NZ, this is faster.  uncommented in tiger.sh.  
#cat /etc/apt/sources.list| sed "s/\/\/archive.ubuntu.com/nz.archive.ubuntu.com/" > /tmp/sources.list
#sudo mv /etc/apt/sources.list /etc/apt/sources.list.ori
#sudo mv /tmp/sources.list /etc/apt/sources.list
#sudo apt-get update

# also uncommented in tiger.sh
#sudo apt install -y tightvncserver icewm
#sudo apt-get install -y openssh-server

# install required packages for Ubuntu 16.04 (Wiki: Dev Area/Dev Env)
sudo apt-get install -y apache2 make curl wget xvfb git gitk postgresql php-cli libapache2-mod-php php-curl php-gd php-json php-ldap php-pgsql php-xmlrpc php-zip php-xml php-mbstring nodejs-legacy npm  firefox

echo "Now installing postfix, please select Local only"
sudo apt-get install -y postfix

# is memcached required?  it's not in the docs?  -- still the errors though.  this isn't the reason.
sudo apt-get install -y memcached

# from: https://tecadmin.net/install-latest-nodejs-npm-on-ubuntu/
# install newer versions of node.  the one that comes with xenial is 4.x? (to be confirmed)
curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
VERSION=node_8.x
DISTRO="$(lsb_release -s -c)"
echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list
echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list

sudo apt-get update
sudo apt-get install -y nodejs

# setup mahara under /var/www/html/mahara
# we prefer this to ~/code because we don't (particularly on actual dev machines, not lxc or VMs)
# to have ~ be g+rwx or even g+rx.  files are $USER:www-data so make css' chmods work (EPERM if
# we have www-data:$USER

CODE=/var/www/html/mahara
sudo mkdir $CODE
sudo chown $USER:www-data $CODE
sudo chmod -R g+rwx $CODE
pushd $CODE/../

git clone https://git.mahara.org/mahara/mahara.git

popd

sudo chown -R $USER:www-data $CODE
sudo chmod -R ug=rwx $CODE

# password optional if you're going to use some other auth method.
sudo -u postgres createuser -D -R -S maharauser
sudo -u postgres psql -c "alter user maharauser with password 'maharapassword'"

sudo -u postgres createdb -Omaharauser mahara-master

# edit $CODE/htdocs/config.php to have your actual email address.
cat common/config.php | sed "s/EMAIL_ADDRESS/$USER@example.com/" > $CODE/htdocs/config.php

sudo mkdir /var/lib/maharadata
sudo mkdir /var/lib/maharadata/master
sudo chown www-data:www-data /var/lib/maharadata/master

sudo sh -c "echo '127.0.0.1 mahara' >> /etc/hosts"

# WARNING: do this manually if your current post_max_size is larger than 32M.
for fn in `find /etc -name php.ini`
do
  sudo sh -c "echo 'post_max_size = 32M' >> $fn"
done

sudo cp common/apache-mahara.conf /etc/apache2/sites-available/mahara.conf
sudo a2ensite mahara
sudo apache2ctl configtest
sudo apache2ctl graceful

sudo sh -c "echo '* * * * * www-data /usr/bin/php /home/<your username>/code/mahara/htdocs/lib/cron.php >/dev/null 2>&1' > /etc/cron.d/mahara"

pushd $CODE
npm cache clean --force
npm install
sudo npm install -g gulp
make css
popd

## BEHAT:

sudo apt-get install -y curl openjdk-8-jre-headless chromium-browser

sudo mkdir -p /var/lib/maharadata/master_behat
sudo chown -R $USER:www-data /var/lib/maharadata/master_behat
sudo chmod -R ug=rwx /var/lib/maharadata/master_behat

cp common/gg.feature /var/www/html/mahara/test/behat/features/security
cp common/*.sh /var/www/html/mahara
cp common/g*.sh ~

cd /var/www/html/mahara/

sudo mkdir -p /var/lib/maharadata/master_behat
sudo chmod -R ug+rwx /var/lib/maharadata/master_behat
sudo chown -R $USER:www-data /var/lib/maharadata


# we could do the composer.phar and cli init manually too
# but this is simple.
./test/behat/mahara_behat.sh run security/gg.feature html
./test/behat/mahara_behat.sh run security/gg.feature html




