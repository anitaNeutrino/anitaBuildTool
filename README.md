# anitaBuildTool
A simple script to download and build the ANITA libraries


## Building for the first time

In theory all one needs to do is make sure the ANITA_UTIL_INSTALL_DIR enviromental vairable is set and then type:

   ./buildAnita.sh

This will build and install everything with the defaults. 

The buildAnita.sh script takes two optional arguments

    ./buildAnita.sh [njobs = 1] [configure = 0]

The options do the following:

    njobs:
        The number of threads you wish to compile on, default is 1.
    	Passing njobs > 1 will result in faster compilation.
	However, warnings and errors will appear out of order, making them harder to understand.

    configure: (0 is no, 1 is yes)
        Pass 1 to edit enable compiler flags and other options before building, default is 0 (don't edit them).
	Documentation on what these do is somewhat sparse so proceed with caution.
	(Deleting the build directory and recompiling will return everything to the default setting.)

The build script is not very sophisticated it will attempt to:
1) Checkout the libraries from GitHub
2) Make a build directory and run cmake in that directory to generate Makefiles
3) Build the libraries (make)
4) Install the libraries in to ANITA_UTIL_INSTALL_DIR (make install)

The main prerequisites are:
ROOT https://root.cern.ch
FFTW http://www.fftw.org
cmake https://cmake.org
these should be available using your favourite package manager for your system.


## Building for the (N>1)th time

After buildAnita.sh is run once, more things are possible.
anitaBuildTool includes a high level Makefile, which allows for separately compiling/updating/installing the software, rather than doing all of the above.
The Makefile commands are documented, to see what is available do 

    make help

in the anitaBuildTool directory.


## Known working systems

Mac OS X
---------
Mac Os X 10.11.5
ROOT -- 6.06/04
cmake -- 3.5.2
The ROOT, cmake and FFTW libraries were installed using homebrew.sh for details on how to install these see
https://alexpearce.me/2016/02/root-on-os-x-el-capitan/

macOS Sierra 10.12
------------------
ROOT -- 6.06/08
cmake -- 3.6.2
clang -- 800.0.38 (xcode 8.0)


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

Ubuntu 16.04 (64-bit) 
--------------------------
gcc version 4.8.5 (Ubuntu 4.8.5-4ubuntu2) 
ROOT 6.06/08 (installed explicitly with minuit2)
cmake 3.5.1




