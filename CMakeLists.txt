cmake_minimum_required(VERSION 2.8.10)

# You can tweak some common (for all subprojects) stuff here. For example:

# In order to get libRootFftwWrapper to download its various dependencies you need to turn these off
#set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)
#set(CMAKE_DISABLE_SOURCE_CHANGES  ON)

set(CMAKE_BUILD_TYPE RelWithDebInfo)

if ("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
  message(SEND_ERROR "In-source builds are not allowed.")
endif ()

set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_COLOR_MAKEFILE   ON)


set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules/")

# You need to tell CMake where to find the ROOT installation. This can be done in a number of ways:
#   - ROOT built with classic configure/make use the provided $ROOTSYS/etc/cmake/FindROOT.cmake
#   - ROOT built with CMake. Add in CMAKE_PREFIX_PATH the installation prefix for ROOT
list(APPEND CMAKE_PREFIX_PATH $ENV{ROOTSYS})

# Remove 'lib' prefix for shared libraries on Windows
if (WIN32)
  set(CMAKE_SHARED_LIBRARY_PREFIX "")
endif ()

include(MacroOptionalAddSubdirectory)



include_directories(${PROJECT_SOURCE_DIR}/components/eventReaderRoot/include ${PROJECT_SOURCE_DIR}/components/libRootFftwWrapper/include ${PROJECT_SOURCE_DIR}/components/anitaEventCorrelator/include ${PROJECT_SOURCE_DIR}/components/anitaAnalysisTools/include ${PROJECT_SOURCE_DIR}/components/anitaMagicDisplay/include ${PROJECT_SOURCE_DIR}/components/AnitaAnalysisFramework/include ${PROJECT_SOURCE_DIR}/components/UCorrelator/include ${PROJECT_SOURCE_DIR}/components/aware/AwareWebLib/include )


## This is defined in some of the submodules already, but this will force it
## to be enabled all of the time. 
option ( FORCE_OLD_GPP_ABI " Force old g++ ABI; this might be necessary if using new g++ with ROOT compiled with older g++ or other similar situations" OFF ) 
if (FORCE_OLD_GPP_ABI) 
  add_definitions( -D_GLIBCXX_USE_CXX11_ABI=0 ) 
endif() 
 
# When done tweaking common stuff, configure the components (subprojects).
# NOTE: The order matters! The most independent ones should go first.
add_subdirectory(components/libRootFftwWrapper) # libRootFftwWrapper is a library (depends on FFT)
add_subdirectory(components/eventReaderRoot) # eventReaderRoot is a shared library (depends on libRootFftwWrapper
add_subdirectory(components/anitaEventCorrelator)
add_subdirectory(components/anitaAnalysisTools)
add_subdirectory(components/AnitaAnalysisFramework)
add_subdirectory(components/UCorrelator)
add_subdirectory(components/anitaMagicDisplay)
macro_optional_add_subdirectory(components/anitaTreeMaker)
macro_optional_add_subdirectory(components/aware/AwareWebLib)
macro_optional_add_subdirectory(components/anitaAwareFileMaker)
macro_optional_add_subdirectory(components/anitaTelem)
