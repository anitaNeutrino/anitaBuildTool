# ANITA Software Documentation

## Introduction
This is the Doxygen generated documentation for the entire ANITA software stack.
You should be able to search for any of the ANITA software classes here and find out something about them.
Exactly how much depends on the diligence of the developer.

[The READMEs (and other markdown notes for each of the components) are listed here](pages.html)

[The classes are listed here](annotated.html)

[The namespaces are listed here](namespaces.html)

## This is awesome, I want to add documentation!
That's the spirit.
The best place to add notes for any given bit of code is in the correponding header or source file.
Alternatively, to add detailed notes for any software related thing, add a Markdown file (file with .md suffix) to the doc subdirectory of anitaBuildTool.
[It should appear on the Related Pages](pages.html)


## Travis-CI, GitHub and Doxygen
[Travis-CI](https://travis-ci.org/) is a Continuous Integration (CI) service and is free for open source projects.
It runs a little script on a pop-up virtual machine on a server somewhere in the cloud.
In principle it could do all the ANITA continuous integration testing, although configuring it to install all the pre-requisites (or trigger on any commit of any ANITA library) is somewhat difficult.
At the time of writing it has just been used to clone the ANITA software source code, `doxygen` it, and commit and push the results to the `gh-pages` branch of anitaBuildTool once per day.
[This set up was implemented following this guide here.](https://docs.travis-ci.com/user/deployment/pages/)
All the action happens in the .travis.yml file in anitaBuildTool.





