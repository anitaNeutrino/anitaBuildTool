#!/bin/bash

if [ -z "$ANITA_UTIL_INSTALL_DIR" ]; then
    echo "Need to set ANITA_UTIL_INSTALL_DIR"
    echo "This is where the ANITA sofwtare will be installed"
    exit 1
fi  

hash root-config 2>/dev/null || { echo >&2 "I require root-config but it's not installed.  Aborting."; exit 1; }

hash cmake 2>/dev/null || { echo >&2 "I require cmake but it's not installed.  Aborting."; exit 1; }


#Step 1: To create the components directory and try and download the repositories
mkdir -p components
cd components

for repName in https://github.com/nichol77/libRootFftwWrapper.git https://github.com/anitaNeutrino/eventReaderRoot.git https://github.com/anitaNeutrino/anitaEventCorrelator.git https://github.com/anitaNeutrino/anitaAnalysisTools.git https://github.com/anitaNeutrino/anitaMagicDisplay.git; do
    thisDirWithGit=${repName##*/}
    thisDir=${thisDirWithGit%.*}
    if [ -d "$thisDir" ]; then
	echo "$thisDir already exists, will update"
	cd $thisDir
	git pull
	cd ..
    else
	echo "Fetching $thisDir"
	git clone $repName
    fi
done
cd ..

#Step 2: Now try and make a build dir and actually compile stuff

#For now a little hack for the cmake FFTW
ln -sf components/libRootFftwWrapper/cmake
rm -rf build
mkdir -p build
cd build
cmake .. && make  && make install


