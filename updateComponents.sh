#!/bin/bash


BUILDAWARE=0 #1
if [ ! -z $1 ] 
then  
  BUILDAWARE=$1 
fi 
if [ ! -z $2 ] 
then  
  BUILDAWARE=$2 
fi 

EVENT_READER_BRANCH=`cat which_event_reader` 

if [ "$EVENT_READER_BRANCH" == "anita3" ] ; then
  echo "Using ANITA-3 branch" 
elif [ "$EVENT_READER_BRANCH" == "master" ] ; then
  echo "Using master branch" 
else 
  echo "Using deprecated or unknown branch. Switched to master." 
  EVENT_READER_BRANCH="master" 
fi


mkdir -p components
cd components
GH=https://github.com
RN=$GH/nichol77
AN=$GH/anitaNeutrino

if [[ $BUILDAWARE == 1 ]]; then
    echo "Will download the AWARE libraries as well"
    for repName in $RN/aware.git $AN/anitaTreeMaker.git $AN/anitaTelem.git $AN/anitaAwareFileMaker.git; do
    thisDirWithGit=${repName##*/}
    thisDir=${thisDirWithGit%.*}
    if [ -d "$thisDir" ]; then
	echo "$thisDir already exists, will update"
	cd $thisDir
        if [[ $repName == *"eventReaderRoot"* ]] ; then
          git checkout $EVENT_READER_BRANCH 
        fi

        git pull

	cd ..
    else
	echo "Fetching $thisDir"
        if [[ $repName == *"eventReaderRoot"* ]] ; then
          git clone -b $EVENT_READER_BRANCH $repName
        else
          git clone $repName
        fi
    fi
done	
    
fi

if [[ $BUILDAWARE == 2 ]]; then
    echo "Will download the anitaTreeMaker as well"
    for repName in $AN/anitaTreeMaker.git; do
    thisDirWithGit=${repName##*/}
    thisDir=${thisDirWithGit%.*}
    if [ -d "$thisDir" ]; then
	echo "$thisDir already exists, will update"
	cd $thisDir
        if [[ $repName == *"eventReaderRoot"* ]] ; then
          git checkout $EVENT_READER_BRANCH 
        fi

        git pull

	cd ..
    else
	echo "Fetching $thisDir"
        if [[ $repName == *"eventReaderRoot"* ]] ; then
          git clone -b $EVENT_READER_BRANCH $repName
        else
          git clone $repName
        fi
    fi
done	
    
fi


#echo $EVENT_READER_BRANCH

for repName in $RN/libRootFftwWrapper.git $AN/eventReaderRoot.git $AN/anitaEventCorrelator.git $AN/anitaAnalysisTools.git $AN/anitaMagicDisplay.git $AN/AnitaAnalysisFramework $AN/UCorrelator $AN/icemc; do
    thisDirWithGit=${repName##*/}
    thisDir=${thisDirWithGit%.*}
    if [ -d "$thisDir" ]; then
	echo "$thisDir already exists, will update"
	cd $thisDir
        if [[ $repName == *"eventReaderRoot"* ]] ; then
          git checkout $EVENT_READER_BRANCH 
        fi

        git pull

	cd ..
    else
	echo "Fetching $thisDir"
        if [[ $repName == *"eventReaderRoot"* ]] ; then
          git clone -b $EVENT_READER_BRANCH $repName
        else
          git clone $repName
        fi
    fi
done
cd ..





### TODO: We should be able to tell if this is necessary or not... 
rm -rf build 



