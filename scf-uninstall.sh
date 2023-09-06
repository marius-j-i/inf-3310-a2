#!/usr/bin/bash

# NOTE: script usage is mainly for debugging and might not be a full uninstallation

dependencies=(
    gcc-avr
    binutils-avr
    avr-libc
    avrdude
)
sudo apt-get remove -y ${dependencies[@]}

rm -f scf17.zip 
sudo rm -f $(which scfavr)

