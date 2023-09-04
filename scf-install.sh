
logfile=.scf-install-log.txt
errfile=.scf-install-err.txt
touch $logfile $errfile

# execute argument command, 
# log output to $logfile, 
# and terminate on exit code non-0
check() {
    cmd=$@
    if [ -z "$cmd" ]; then 
        echo "usage: check <cmd> [args...]" && exit 1
    fi
    $cmd 1>> $logfile 2>> $errfile
    if [ $? -ne 0 ];
        then echo&&echo "EXIT-CODE=$?, COMMAND='$cmd'" && cat "$errfile" && exit 1
    fi
}

scfdependencies=(
    python3.8
    python3-setuptools
    python3.8-distutils
    python3-pip
    gcc-avr
    binutils-avr
    avr-libc
    avrdude
    make
)
echo "
##### INSTALLING DEPENDENCIES #####
"
check sudo apt-get install -y ${scfdependencies[@]}

scfsrc=scf17
scfzip=http://www.mais.informatik.tu-darmstadt.de/assets/tools/$scfsrc.zip
# if neither src-folder or src zip exist...
if [ ! -d $scfsrc -a ! -f $scfsrc.zip ]; then
    echo "
    ##### FETCHING STATIC ANALYSIS SOURCE CODE #####
    "
    check wget --no-check-certificate -O $scfsrc.zip $scfzip
    check sudo rm -rf scf17
    check sudo apt-get install -y unzip
    check unzip scf17.zip
fi

echo "
##### INSTALLING SCF #####
"
cd scf17/scfavr
check python3.8 -m pip install -U pip
# check python3.8 -m pip install 
check sudo python3.8 setup.py install
cd - > /dev/null

rm $logfile $errfile

