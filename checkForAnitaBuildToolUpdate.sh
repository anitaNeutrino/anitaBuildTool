#!/bin/bash

git fetch
LOCAL=$(git rev-parse @{0})
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @{0} @{u})
if [ $LOCAL = $REMOTE ]; then
    echo "anitaBuildTool is up to date."
elif [ $LOCAL = $BASE ]; then
    echo "Local anitaBuildTool is behind upstream. Attempting pull."
    git merge
    exit 1
elif [ $REMOTE = $BASE ]; then
    echo "Local anitaBuildTool is ahead of upstream. Consider pushing your changes."
else
    echo "Local anitaBuildTool has diverged from upstream. Aborting update."
fi
echo "Continuing build."
exit 0
