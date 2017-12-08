## This is an example ci environment file. 
## This is the default build environment 


#this is the name of the environment
export ANITA_CI_ENVIRONMENT_NAME="root608_gcc61_eigen3_openmp"

## build args here 
export ANITA_CI_CMAKE_ARGS="-DFFTTOOLS_ENABLE_OPENMP=ON -DENABLE_ROOSTATS=ON -DUSE_EIGEN=ON -DEIGEN3_INCLUDE_DIR=${EIGEN3_INCLUDE_DIR} -DENABLE_OPENMP=ON"

### this is all midway specific stuff for UChicago
module unload gcc
module load cmake
module load doxygen 
module load graphviz 
module load texlive 
module load gcc/6.1
export CC=`which gcc` 
export CXX=`which g++` 
module unload ROOT 

source $HOME/soft/root-git/root_6.08.06-midway1/bin/thisroot.sh 

 

