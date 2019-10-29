#!/bin/bash

if [ -z $1 ]
then
  echo "Provide a feature file as the script parameters"
  exit -1
fi

if [ ! -r $1 ]
then
  echo $1 not readable or does not exist.
  exit -2
fi

egrep -o '/.*/.*\.feature' $1 | cut -f 9- -d '/' | sed "s/^features\///" | sort | uniq

