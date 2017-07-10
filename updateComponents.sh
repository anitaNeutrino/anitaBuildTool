#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

updateComponent() {
    repName=$1 # Repository URL
    
    thisDirWithGit=${repName##*/}
    thisDir=${thisDirWithGit%.*}

    if [ -d "$thisDir" ]; then
	echo -n "$thisDir already exists, will update: "
	cd $thisDir

	# Could do the fetch and merge separately to give more informative errors.
	git pull
	pullSuccess=${?}

	if [ $pullSuccess -gt 0 ]; then
	    echo >&2 -e ${RED}"There was an error with the fetch or merge of ${thisDir}. Aborting the build."${NC}
	    exit 1;
	fi

	cd ..
    else
	echo "Fetching $thisDir"
	git clone $repName
    fi
}


main() {

    WHICH_COMPONENTS=0 #1
    if [ ! -z $1 ]
    then
	WHICH_COMPONENTS=$1
    fi
    if [ ! -z $2 ]
    then
	WHICH_COMPONENTS=$2
    fi

    # Create and move to components subdirectory
    mkdir -p components
    cd components

    # Get desired libraries
    GH=https://github.com
    RN=$GH/nichol77
    AN=$GH/anitaNeutrino

    if [[ $WHICH_COMPONENTS == 1 ]]; then
	echo "Will download the AWARE libraries as well"
	for repName in $RN/aware.git $AN/anitaTreeMaker.git $AN/anitaTelem.git $AN/anitaAwareFileMaker.git; do
	    updateComponent $repName
	done
    fi

    if [[ $WHICH_COMPONENTS == 2 ]]; then
	echo "Will download the anitaTreeMaker as well"
	for repName in $AN/anitaTreeMaker.git; do
	    updateComponent $repName
	done
    fi

    for repName in $RN/libRootFftwWrapper.git $AN/eventReaderRoot.git $AN/anitaEventCorrelator.git $AN/anitaAnalysisTools.git $AN/anitaMagicDisplay.git $AN/AnitaAnalysisFramework $AN/UCorrelator $AN/icemc; do
	updateComponent $repName
    done

    cd .. # Back to anitaBuildTool directory

    ### TODO: We should be able to tell if this is necessary or not... 
    rm -rf build 

    return 0;
}

main $@
