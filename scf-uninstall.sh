
dependencies=(
    gcc-avr
    binutils-avr
    avr-libc
    avrdude
)
sudo apt-get remove -y ${dependencies[@]}

rm -f scf17.zip 
sudo rm -f $(which scfavr)

