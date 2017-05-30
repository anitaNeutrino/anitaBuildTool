#! /bin/bash

### Continuous integration script for ANITA Build Tool ###
### When run, updates, checks build, and rebuilds doc
### Different environments are supported using files within in the ci_envs dir
###  
### Cosmin Deaconu <cozzyd@kicp.uchicago.edu> 



#Slurm stuff  (ignore if not using slurm) 

#SBATCH --job-name=anita_ci 
#SBATCH --output=ci.out 
#SBATCH --error=ci.err
#SBATCH --time=1:00:00
#SBATCH --partition=kicp
#SBATCH --account=kicp
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4


## Check ANITA_CI_BUILD_DIR and switch to that that if it's defined
if [ -n "$ANITA_CI_BUILD_DIR"]; then
  cd "$ANITA_CI_BUILD_DIR"; 
fi;

ROOTDIR=`pwd`; 
NJOBS=4


export ANITA_UTIL_INSTALL_DIR=`pwd`/util 


## Get ready for a build! 
./checkForAnitaBuildToolUpdate.sh
./updateComponents.sh
./buildHacks.sh

HTML_OUT_DIR=`pwd`/html 

if [ -n "$ANITA_CI_OUT_DIR" ]; then
   HTML_OUT_DIR=$ANITA_CI_OUT_DIR 
   echo "Using $HTML_OUT_DIR" 
fi

mkdir -p "$HTML_OUT_DIR" 


# build under all the environments!
for env in ci_envs/*.sh; do 
    source "$env"
    NM="$ANITA_CI_ENVIRONMENT_NAME"  
    echo "Processing ${NM}" 
    rm -rf "$NM"
    mkdir -p $NM
    cd "$NM" 
    cmake   ${ANITA_CI_CMAKE_ARGS} ..  &> "$HTML_OUT_DIR"/"$NM".logtmp
    make -j $NJOBS &>>"$HTML_OUT_DIR"/"$NM".logtmp
    mv "$HTML_OUT_DIR"/"$NM".logtmp "$HTML_OUT_DIR"/"$NM".log
    succeeded=$?
    cd "$ROOTDIR"
    if [ $succeeded -eq 0 ]; then 
        echo "<p> BUILD STATUS FOR $NM IS <b><span style='color:green'>SUCCESS</span></b>. <a href='${NM}.log' target='_log'>Click here for log</a> </p>" > "${HTML_OUT_DIR}"/${NM}.htmlpart.new 
    else
        echo "<p> BUILD STATUS FOR $NM IS <b><span style='color:red'>FAIL</span></b>. <a href='${NM}.log' target='_log'>Click here for log</a> </p>" > "${HTML_OUT_DIR}"/${NM}.htmlpart.new
    fi 
    mv "${HTML_OUT_DIR}"/${NM}.htmlpart.new "${HTML_OUT_DIR}"/${NM}.htmlpart
done; 


#now let's build all the documentation 

date > "${HTML_OUT_DIR}"/doxy.log

for i in libRootFftwWrapper eventReaderRoot anitaMagicDisplay anitaEventCorrelator AnitaAnalysisFramework anitaAnalysisTools UCorrelator; do 
  cd components/$i
  doxygen doc/Doxyfile >> "${HTML_OUT_DIR}"/doxy.log
  rsync -avh doc/html/ ${HTML_OUT_DIR}/$i &> /dev/null 
  cd doc/latex && make && cp refman.pdf ${HTML_OUT_DIR}/$i/$i.pdf 
  cd ${ROOTDIR} 
done



#make html files 
cat ci.html_start > ${HTML_OUT_DIR}/index.html 
echo "<p><b>Last updated</b> `date` on `hostname`(`uname -r`)</p>" >> ${HTML_OUT_DIR}/index.html 
cat ${HTML_OUT_DIR}/*.htmlpart ci.html_end >> ${HTML_OUT_DIR}/index.html 





        
        



    
















