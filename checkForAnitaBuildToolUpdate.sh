#!/bin/bash

# First check if we have a .git subdirectory
if [ ! -d ".git" ]; then
    echo "Error! Could not find .git subdirectory!"
    echo "anitaBuildTool must be cloned from the anitaBuildTool repository. Aborting build."
    echo "If you did not get the anitaBuildTool by running this command:"
    echo ""
    echo "    git clone https://github.com/anitaNeutrino/anitaBuildTool"
    echo ""
    echo "then please redownload this repository using the above command"
    echo "(this will create a directory called anitaBuildTool initialised with git)" 
    exit 1;
fi;


# Update the repository
git fetch
fetchSuccess=$?

if [ ${fetchSuccess} -gt 0 ]; then
    echo "Error! anitaBuildTool could not connect to remote repository. Aborting build."
    exit 2;
fi;


LOCAL=$(git rev-parse @{0})
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @{0} @{u})
if [ $LOCAL = $REMOTE ]; then
    echo "anitaBuildTool is up to date."
elif [ $LOCAL = $BASE ]; then
    echo "Local anitaBuildTool is behind upstream. Attempting merge."
    git merge origin/master
    exit 1
elif [ $REMOTE = $BASE ]; then
    echo "Local anitaBuildTool is ahead of upstream. Consider pushing your changes."
else
    echo "Local anitaBuildTool has diverged from upstream. Aborting update."
    exit 3;
fi;

echo "Continuing build."
exit 0;
