# anitaBuildTool
A simple script to download and build the ANITA libraries


In theory all one needs to do is make sure the ANITA_UTIL_INSTALL_DIR enviromental vairable is set and then type:
./buildAnita.sh

This will build and install everything with the defaults. 


The buildAnita.sh script takes two optional arguments

    ./buildAnita.sh [configure = 0] [njobs = 2] 

The build script is not very sophisticated it will attempt to:
1) Checkout the libraries from GitHub
2) Make a build directory and run cmake .. in that directory
3) Build the libraries (make)
4) Install the libraries in to ANITA_UTIL_INSTALL_DIR (make install)

The main prerequisites are:
ROOT https://root.cern.ch
FFTW http://www.fftw.org
cmake https://cmake.org
these should be available using your favourite package manager for your system.




##############################################################################
More advanced use 
##############################################################################

You can change the branch for anitaEventReader by changing the file which_event_reader_root

After buildAnita.sh is run once, more things are possible

  - build without updating components (use convenience make file, or cd into build and Make). 

  - configure some compile time parameters (you can use make configure to do this, or run ccmake inside the build directory). 
    make and make install after. Note that doing a make update or running the build script will forget everything. 
    If you find yourself doing this often, this tool is probably not for you. 

##############################################################################
Known working systems
##############################################################################

Mac OS X
---------
Mac Os X 10.11.5
ROOT -- 6.06/04
cmake -- 3.5.2
The ROOT, cmake and FFTW libraries were installed using homebrew.sh for details on how to install these see
https://alexpearce.me/2016/02/root-on-os-x-el-capitan/

Scientific Linux 6
------------------
Scientific Linux release 6.7 (Carbon)
gcc version 4.4.7 20120313
ROOT -- 5.34/20
cmake version 2.8.12.2

Fedora 24  ( 64-bit) 
---------------------------
gcc 6.1.1 20160621 (Red Hat 6.1.1-3) 
ROOT 6.06/06 
cmake 3.5.2 
fftw-3.3.4-7
all installed via dnf from normal repositories 

Centos 7 (64-bit) 
--------------------------
gcc 4.8.5 20150623 (Red Hat 4.8.5-4)
ROOT 6.06/04
cmake 2.8.11 
all installed via yum from normal + epel repositories 






