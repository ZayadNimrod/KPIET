

echo "testing..."
for test in "tests"/*/""
do
    echo "*"$test
    for file in $test*".in"
    do
	file="${file%.*}"
        echo $file
        cat $file.in 2>/dev/null | krun $test/program.kpiet --output NONE | diff - $file.out
    done
done
echo "all done!"
