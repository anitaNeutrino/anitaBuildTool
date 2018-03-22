# anitaBuildTool

A simple script to download and build the ANITA libraries.

Additional `doxygen` generated documentation is available online here https://anitaneutrino.github.io/anitaBuildTool

The latest documentation status is: [![Documentation Status](https://travis-ci.org/anitaNeutrino/anitaBuildTool.svg?branch=master)](https://travis-ci.org/anitaNeutrino/anitaBuildTool)


## Getting anitaBuildTool

In your terminal do

	git clone https://github.com/anitaNeutrino/anitaBuildTool

to create an anitaBuildTool subdirectory containing the scripts and git repository.
Alternatively, you can clone over ssh with

	git clone git@github.com:anitaNeutrino/anitaBuildTool

## Building for the first time

In theory all one needs to do is make sure the ANITA_UTIL_INSTALL_DIR enviromental vairable is set and then type:

	./buildAnita.sh

The build script is not very sophisticated it will attempt to:

	1) Checkout the libraries from GitHub
	2) Make a build directory and run cmake in that directory to generate Makefiles
	3) Build the libraries (make)
	4) Install the libraries in to ANITA_UTIL_INSTALL_DIR (make install)


This will build and install everything with the defaults. 
However, there are some optional arguments

    ./buildAnita.sh [njobs = 1] [configure = 0] [build aware = 0] [nuke build dir = 1]

| Argument       | Default | What it does                                                                                                                                       |
| -------------  | ---     | -------------                                                                                                                                      |
| njobs          | 1       | The number of threads you wish to compile with. njobs > 1 will result in faster compilation, however, warnings and errors may appear out of order. |
| configure      | 0       | Edit compiler flags and other options before building.                                                                                             |
| build aware    | 0       | Whether or not to download and build AWARE in addition to the default packages.                                                                    |
| nuke build dir | 1       | Whether or not the build directory will be deleted and completely re-compiled.                                                                     |
| convolve tuff responses | 0       | Whether or not you want to convolve together the TUFF models with the A3 and A4 impulse responses                                         |

The main prerequisites are:
ROOT https://root.cern.ch with Minuit2, MathMore, and Fortran. See https://root.cern.ch/build-prerequisites to make sure you have the prerequisites required for those features.
FFTW http://www.fftw.org
cmake https://cmake.org
these should be available using your favourite package manager for your system.


## Building for the Nth time

After buildAnita.sh is run once, more things are possible.
anitaBuildTool includes a high level Makefile, which allows for separately compiling/updating/installing the software, rather than doing all of the above.
The Makefile commands are documented, to see what is available do 

    make help

in the anitaBuildTool directory.

## clone_method

Edit the top line of the clone method file (from https to ssh) to clone over ssh rather than https.
This requires uploading your public ssh-key to GitHub.

## If you want to update all the components, you can run:

	./updateComponents.sh [Nuke build directory?] [update aware?] [update treeMaker?]

If you put a zero for [Nuke build directory?] it will possibly allow you to quicky rebuild only things that have been changed.
It might not work though if there are significant modifications.


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

