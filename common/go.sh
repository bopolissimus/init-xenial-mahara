#!/bin/bash

if [ -z $1 ]
then
  echo 'Please specify feature file (.../features/(.*\.feature))'
  exit -1
fi

if [ ! -z $2 ]
then
  /var/lib/maharadata/master_behat/behat/html_results/
fi

cd /var/www/html/mahara
./test/behat/mahara_behat.sh runheadless $1 html
