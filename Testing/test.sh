#!/bin/bash

readarray tester < test.txt

for i in ${tester[@]}; do
	echo ${i}
done

IFS=$'\n' array2=($(< test.txt))

echo ""

for i in ${tester[@]}; do
	echo ${i}
done
