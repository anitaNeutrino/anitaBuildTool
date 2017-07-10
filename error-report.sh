#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
CC=$(grep 'CMAKE_CXX_COMPILER:FILEPATH=' build/CMakeCache.txt | sed s,'CMAKE_CXX_COMPILER:FILEPATH=',,)

theOriginalPwd=$(pwd);

echo -e "${RED}*****************************************************************************${NC}"
echo -e "${RED}Error! Could not build the ANITA software suite.${NC}"
echo -e "${RED}Please post the ENTIRE output in the ANITA slack #bugzilla channel.${NC}"
echo -e "${RED}https://anitamission.slack.com/messages/C4DCY5PDG/${NC}"
echo -e "${RED}The root version is $(root-config --version)${NC}"
echo -e "${RED}The compiler is $(${CC} --version | head -1)${NC}"
echo -e "${RED}The system info is $(uname -a)${NC}"
echo -e "${RED}The status of the components is: ${NC}"
for component in ./ components/libRootFftwWrapper components/eventReaderRoot components/anitaEventCorrelator components/AnitaAnalysisFramework components/anitaAnalysisTools components/UCorrelator components/anitaMagicDisplay ; do
    cd $component;
    compName=$(echo ${component} | sed s,"components/",,)
    compName=$(echo ${compName} | sed s,"./","anitaBuildTool",)
    id=$(git log --pretty=format:"%h" -n1)
    branch=$(git rev-parse --abbrev-ref HEAD)
    echo -e "${GREEN}${compName}${RED} is on ${YELLOW}${branch}${RED} at ${BLUE}${id}${NC}"
    git status -s # Short format git status output
    cd $theOriginalPwd
done
echo -e "${RED}*****************************************************************************${NC}"
