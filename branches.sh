### Show the current branches of each component
for dir in $(ls -d components/*); do
    subDir=$(echo $dir | sed s,components/,, )
    cd $dir;    
    currentBranch=$(git branch | grep \* | cut -d ' ' -f2)
    echo $subDir is on $currentBranch
    cd - > /dev/null    
done;
