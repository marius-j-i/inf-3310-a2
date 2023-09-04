
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
check sudo apt-get update -y
check sudo apt-get upgrade -y
check sudo apt-get install -y ${scfdependencies[@]}

scfsrc=scf17
scfzip=$scfsrc.zip
download=http://www.mais.informatik.tu-darmstadt.de/assets/tools/$scfzip
if [ ! -d $scfsrc ]; then
    # neither source- or zip-files
    if [ ! -f $scfzip ]; then
        echo "
        ##### FETCHING STATIC ANALYSIS SOURCE CODE #####
        "
        check wget --no-check-certificate -O $scfzip $download
    if
    echo "
    ##### UNPACKING SOURCE ZIP #####
    "
    check sudo apt-get install -y unzip
    check unzip scf17.zip
else
    echo "
    ##### FOUND SOURCE CODE - MOVING ON #####
    "
fi

echo "
##### INSTALLING SCF #####
"
cd $scfsrc/scfavr
check python3.8 -m pip install -U pip
check sudo python3.8 setup.py install
cd - > /dev/null

rm $logfile $errfile

