#!/bin/sh

# Check cached git files for components subdirectory
files=`git diff --cached --name-only`
conflicts=0
for file in ${files}; do

    if [[ $file == "components/"* ]]
    then
       # echo ${conflicts}       
       conflicts=$((${confilts}+1))
       # echo ${conflicts}	
    fi
done


# Gratuitous error message
if [ ${conflicts} -ge 1 ]
then
    echo "Commiting files in components subdirectory is not allowed. Aborting commit."
    echo "The following files must be unstaged to commit to anitaBuildTool:"
    for file in ${files}; do
	if [[ $file == "components/"* ]]
	then
	   echo $'\t'${file};
	fi;
    done;
    exit 1
fi;

exit 0
