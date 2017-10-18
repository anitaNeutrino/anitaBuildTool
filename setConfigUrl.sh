

AN=git@github.com:anitaNeutrino
RJN=git@github.com:nichol77

# anitaBuildTool
git remote set-url origin ${AN}/anitaBuildTool.git
git remote -v


# libRootFftwWrapper
cd components/libRootFftwWrapper;
git remote set-url origin ${RJN}/libRootFftwWrapper.git
git remote -v
cd -


# The others
for comp in AnitaAnalysisFramework  anitaEventCorrelator  eventReaderRoot  anitaAnalysisTools anitaMagicDisplay icemc UCorrelator; do
    echo $comp;
    cd components/${comp}
    git remote set-url origin ${AN}/${comp}.git
    git remote -v
    cd -
done
	    
