#!/bin/bash

sudo -u postgres psql -c 'drop database "mahara-master"';
sudo -u postgres psql -c 'create database "mahara-master" owner maharauser'
