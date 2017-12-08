## This is an example ci environment file. 
## This is the default build environment 


#this is the name of the environment
export ANITA_CI_ENVIRONMENT_NAME="root534_gcc48"

## build args here 
export ANITA_CI_CMAKE_ARGS=""


### this is all midway specific stuff for UChicago
module unload gcc
module load cmake
module load doxygen 
module load gcc/4.8
module load graphviz 
module load texlive 
export CC=`which gcc` 
export CXX=`which g++` 
module unload ROOT 
module load ROOT/5.34  

 

