#!/bin/bash

if [ -z $1 ]
then
  echo 'Please specify feature file (.../features/(.*\.feature))'
  exit -1
fi

cd /var/www/html/mahara
./test/behat/mahara_behat.sh runheadless $1
