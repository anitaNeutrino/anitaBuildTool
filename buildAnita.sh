#!/bin/bash

if [ -z "$ANITA_UTIL_INSTALL_DIR" ]; then
    echo "Need to set ANITA_UTIL_INSTALL_DIR"
    echo "This is where the ANITA sofwtare will be installed"
    exit 1
fi  

hash root-config 2>/dev/null || { echo >&2 "I require root-config but it's not installed.  Aborting."; exit 1; }

hash cmake 2>/dev/null || { echo >&2 "I require cmake but it's not installed.  Aborting."; exit 1; }



#Step 1: grab the components 
./updateComponents.sh 

#Step 2: Now try and make a build dir and actually compile stuff

#For now a little hack for the cmake FFTW
ln -sf components/libRootFftwWrapper/cmake
ln -sf Makefile.hiding Makefile 
make && make install


