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

	currentUrl=$(git remote get-url origin)
	#echo "${currentUrl}"
	#echo "${repName}"
	if [ "${currentUrl}" = "${repName}" ]; then
	    echo -n ""
	else
	    echo "Updating ${thisDir} clone_method"
	    git remote set-url origin ${repName}
	    git remote -v
	fi


	#echo "in ${thisDir}"
	#currentUrl=$(git remote get-url origin)
	#echo "currentUrl = "$currentUrl
	#echo "setting to "$repName
	#git remote set-url origin ${repName}

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
	#git clone $repName
	git clone --depth 1 --recursive $repName
    fi
}


main() {

    #Do you want to nuke the build directory? default is yes, otherwise do `./updateComponents 0`
    NUKE=1
    if [ ! -z $1 ]; then
	NUKE=$1
    fi

    WHICH_COMPONENTS=0 #1
    if [ ! -z $2 ]
    then
	WHICH_COMPONENTS=$2
    fi
    if [ ! -z $3 ]
    then
	WHICH_COMPONENTS=$3
    fi


    # Get desired libraries
    method=$(head -1 clone_method)
    #echo $method

    # Create and move to components subdirectory
    mkdir -p components
    cd components

    GH="https://github.com/"
    if [ "${method}" = "ssh" ]; then
	GH="git@github.com:"
    fi

    RN=${GH}nichol77
    AN=${GH}anitaNeutrino

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

    docInput=doc/doxygenComponentInput.txt
    echo "" > ${docInput}
    for comp in $(ls -d components/*); do
	echo INPUT += ${comp} >> ${docInput}
	echo INPUT += ${comp}/include >> ${docInput}
	echo INPUT += ${comp}/src >> ${docInput}
    done

    ### TODO: We should be able to tell if this is necessary or not... 
    if [ $NUKE -eq 1 ]; then
	rm -rf build 
    fi
    
    return 0;
}

main $@
