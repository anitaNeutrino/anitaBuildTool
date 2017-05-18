#!/bin/bash

if [ -z "$ANITA_UTIL_INSTALL_DIR" ]; then
    echo "Need to set ANITA_UTIL_INSTALL_DIR"
    echo "This is where the ANITA software will be installed"
    exit 1
fi  

hash root-config 2>/dev/null || { echo >&2 "I require root-config but it's not installed.  Aborting."; exit 1; }

# Check for required ROOT features
for feature in minuit2; do
    if [ $(root-config --has-${feature}) == "no" ]; then
	echo >&2 "I require root to be build with ${feature}, but it's not. Aborting"
	exit 1;
    fi;
done;
hash cmake 2>/dev/null || { echo >&2 "I require cmake but it's not installed.  Aborting."; exit 1; }




CONFIGURE=0 #1
if [ ! -z $1 ] 
then  
  CONFIGURE=$1 
fi 

JOBS=3
if [ ! -z $2 ] 
then  
  JOBS=$2 
fi 

BUILDAWARE=0 #1
if [ ! -z $3 ] 
then  
  BUILDAWARE=$3 
fi 




#Step 0: Update myself, since I occasionally get updated.
./checkForAnitaBuildToolUpdate.sh
updated=$?

if [ ${updated} -ne 0 ];then
    echo "Please run ./buildAnita.sh again now the update is complete."
    exit 1;
fi
ln -sf ${PWD}/gitHooks/pre-commit.sh .git/hooks/pre-commit


#Step 1: update all the components 
./updateComponents.sh ${BUILDAWARE}

#Step 2: Now try and make a build dir and actually compile stuff

#For now a little hack for the cmake FFTW
ln -sf components/libRootFftwWrapper/cmake

ln -sf Makefile.hidden_until_you_run_build_script Makefile 

if [ ${CONFIGURE} -ne 0 ]; then 
  make configure; 
fi

make -j $JOBS && make install


