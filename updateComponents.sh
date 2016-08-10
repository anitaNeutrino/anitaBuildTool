#!/bin/bash

mkdir -p components
cd components
GH=https://github.com
RN=$GH/nichol77
AN=$GH/anitaNeutrino

for repName in $RN/libRootFftwWrapper.git $AN/eventReaderRoot.git $AN/anitaEventCorrelator.git $AN/anitaAnalysisTools.git $AN/anitaMagicDisplay.git $AN/AnitaAnalysisFramework $AN/UCorrelator; do
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

### TODO: We should be able to tell if this is necessary or not... 
rm -rf build 



