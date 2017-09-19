#!/bin/bash

if [ -z "$ANITA_UTIL_INSTALL_DIR" ]; then
    echo "Need to set ANITA_UTIL_INSTALL_DIR"
    echo "This is where the ANITA software will be installed"
    exit 1
fi  

hash root-config 2>/dev/null || { echo >&2 "I require root-config but it's not installed.  Aborting."; exit 1; }

# Check for required ROOT features
# PLEASE update the README too as more requirements are added!
requiredFeatures="minuit2 mathmore fortran"
missingFeatures=""
for feature in $(echo ${requiredFeatures}); do
    if [ $(root-config --has-${feature}) == "no" ]; then

	if [[ ${feature} == "fortran" && $(root-config --f77) != "NOTFOUND" ]]; then
	    # How the existence of fortran support is registered seems to have changed over ROOT versions.
	    # I think this is due to the transition from make to cmake in how ROOT is built.
	    # The --f77 should work for old root, where-as --has-fortran works for newer.
	    : # This colon means do nothing in bash
	else
	    missingFeatures=${missingFeatures}" "${feature}
	fi
    fi;
done;

if [ "${missingFeatures}" != "" ]; then
    echo >&2 "Error! The ANITA software requires the following root features: ${requiredFeatures}."
    echo >&2 "However, the following feature(s) are missing from your installation:${missingFeatures}." # missingFeatures has leading whitespace
    echo >&2 "Aborting build."
    echo >&2 ""
    echo >&2 "To see the prerequisited needed for the feature(s) you are missing see https://root.cern.ch/build-prerequisites"
    echo >&2 "To see the list of features currently in your version of root, do root-config --features"
    echo >&2 "To check for fortran support in older ROOT versions, do root-config --f77"
    exit 1;
fi;


hash cmake 2>/dev/null || { echo >&2 "I require cmake but it's not installed.  Aborting."; exit 1; }


echo "Usage: ./buildAnita [# of jobs] [configure 0/1] [build aware 0/1]"
echo
echo "selected settings:"

JOBS=1
if [ ! -z $1 ] 
then  
    JOBS=$1
fi 
echo "Using "${JOBS}" jobs for compilation"


CONFIGURE=0 #1
if [ ! -z $2 ] 
then  
    CONFIGURE=$2
fi  
if [ ${CONFIGURE} -eq 0 ]
then
    echo "No user configuration, using default configuration"
else
    echo "Will do user configuration"
fi



BUILDAWARE=0 #1
if [ ! -z $3 ] 
then  
    BUILDAWARE=$3 
fi 
if [ ${BUILDAWARE} -eq 1 ]
then
    echo "Builing aware"
else
    echo "Not building aware"
fi
echo


NUKEBUILD=1
if [ ! -z $4 ]; then
    NUKEBUILD=$4
fi
if [ ${NUKEBUILD} -eq 1 ]; then
    echo "Nuking build directory and re-compiling everything"
else
    echo "Leaving build directory and attempting partial re-compile"
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
./updateComponents.sh ${NUKEBUILD} ${BUILDAWARE}


#Step 2: Now try and make a build dir and actually compile stuff

# This script links the FFTW.cmake and FindROOT.cmake packaged with libRootFftwWrapper to this directory
./buildHacks.sh

if [ ${CONFIGURE} -ne 0 ]; then 
  make configure; 
fi

make -j $JOBS && make install


