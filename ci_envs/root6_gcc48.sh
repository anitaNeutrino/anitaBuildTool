## This is an example ci environment file. 
## This is the default build environment 


#this is the name of the environment
export ANITA_CI_ENVIRONMENT_NAME="root606_gcc48"


## build args here 
export ANITA_CI_CMAKE_ARGS=""


### this is all midway specific stuff for UChicago
module unload gcc
module load cmake
module load doxygen 
module load gcc/4.8
export CC=`which gcc` 
export CXX=`which g++` 
module unload ROOT 
module load ROOT/6.06 

 

