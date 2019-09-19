#!/bin/bash

useradd --groups sudo -m gerald
cp -Rf common/.ssh /home/gerald/
cp -Rf common/.vnc /home/gerald/
cp common/.bashrc /home/gerald

chown -R gerald:gerald /home/gerald

