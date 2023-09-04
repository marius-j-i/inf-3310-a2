
cd test

errfile=.scf-test-err.txt
touch $errfile

make executable
N=6 ; secret=0 ; public=$((N/2))

echo "
modulating program secret input with public = $public..."
for ((i = 0; i < N; i++)); do
	./vulnerable $secret $public
	((secret++))
done

secret=0 ; ((public++))

echo "
modulating program secret input with public = $public..."
for ((i = 0; i < N; i++)); do
	./vulnerable $secret $public
	((secret++))
done

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

