# anitaBuildTool
A simple script to download and build the ANITA libraries

In theory all one needs to do is make sure the ANITA_UTIL_INSTALL_DIR enviromental vairable is set and then type:
./buildAnita.sh

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




