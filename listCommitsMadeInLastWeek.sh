# Script to print the commits to the software framework made in the last week.
# To get it in org-mode table format for export, run with -b or --for-ben

nArgs=$((${#}-1))
args=("$@")

benMaxPerPage=8 # the actual value is one less than this
forBen=0
for i in $(seq 0 1 ${nArgs}); do
    if [ "-b" == ${args[i]} ] || [ "--for-ben" == ${args[i]} ]; then
	forBen=1;
    fi
done

theOriginalPwd=$(pwd);

for component in ./ components/libRootFftwWrapper components/eventReaderRoot components/anitaEventCorrelator components/AnitaAnalysisFramework components/anitaAnalysisTools components/UCorrelator components/anitaMagicDisplay ; do
    cd $component;
    component=$(echo ${component} | sed s,"components/",, | sed s,"./","anitaBuildTool",)

    if [ ${forBen} == 0 ]; then
	echo ${component}
    fi
    
    # First get a list of all hashes from all branches from the last 7 days    
    #theHashes=$(git log --branches --all --remotes=* --since=7.days.ago --pretty=format:"%h")
    theHashes=$(git log --no-merges --branches --tags --remotes=master --since=7.days.ago --pretty=format:"%h")    

    count=0
    pages=1
    
    for theHash in ${theHashes}; do
	# List all branches with a tip that is a descendent of that commit (include merges I guess)
	# -r since we only care about remotely tracked branches (and I branch for almost every new feature locally)
	# The two sed commands remove the HEAD branch pointer and the origin prefix from the remote branch
	theBranches=$(git branch -r --contains ${theHash} | sed s,"origin/HEAD -> origin/master",, | sed s,"origin/",,)

	# By default, print all the branches
	if [ ${forBen} == 0 ]; then
	    echo -n ${theBranches} ""
	    git --no-pager show ${theHash} --pretty=format:"%h%x09%an%x09%s" --summary
	else #But not for Ben
	    # Add pipe symbols in for Org-mode table
	    if [ ${count} == 0 ]; then
		echo "* "${component} "=master="
		echo "#+NAME: t${component}${pages}"
		echo "#+ATTR_LATEX: :align |l|p{8cm}|"
	    fi
	    echo -n "| "
	    git --no-pager show ${theHash} --pretty=format:"%an%x09%s |" --summary | sed s,"\t"," | ", | head -1
	    count=$((${count}+1))
	    if [ ${count} == ${benMaxPerPage} ]; then
		echo "";
		echo "";
		count=0
		pages=$((${pages}+1))
	    fi
	fi
    done
    if [ ${count} == 0 ]; then
	if [ ${forBen} == 1 ]; then
	    echo "* "${component} "=master="
	fi
	echo "nothing to see here"
    fi
    
    echo "";
    echo "";
    cd $theOriginalPwd
done;    
