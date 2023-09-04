
cd test

errfile=.scf-test-err.txt
touch $errfile

make executable

modulate() {
	N=$1 ; secret=0 ; public=$2
	echo&&echo "modulating program input secret with static public:=$public"
	for ((i = 0; i < N; i++)); do
	./vulnerable $secret $public
	((secret++))
	done
}

N=6
modulate $N 3
modulate $N 4
modulate $N 5

config="vulnerable.json"
echo "
performing static code analysis with configuration in '$config'..."
make clean && make dump
# run scf configuration
# ignore framework comparison warning
# pretty print json output
scfavr $config \
	2> $errfile \
	| python -m json.tool
if [ $? -ne 0 ]; then 
	echo&&echo "ERROR-CODE=$?"
	cat $errfile
else
	rm $errfile
fi

cd - > /dev/null

