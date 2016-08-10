#!/bin/bash

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
        touch ../updated 
    fi
done
cd ..



