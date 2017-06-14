#!/bin/bash

# specify the time limit for the cron job
#SBATCH --time=00:00:10

# use cron.log and append to it
#SBATCH --output=cron.log
#SBATCH --open-mode=append

# the account, partition, and qos should not be changed
#SBATCH --account=cron-account
#SBATCH --partition=cron
#SBATCH --job-name=anita_ci_cron
#SBATCH --qos=cron

# Specify a valid cron string for the schedule
# this is daily at 5:05 AM
SCHEDULE='5 */2 * * *'
# the following command is for illustration purpose
# a more useful command would be submitting another regular job

export ANITA_CI_BUILD_DIR=/home/cozzyd/anita/continuous/anitaBuildTool 
export ANITA_CI_OUT_DIR=/home/cozzyd/anita/continuous/anitaBuildTool/html 

#cancel any other script if there is one already
scancel --name anita_ci 
sbatch -A kicp -p kicp -c 4 anita_ci.sh 

# resubmit this script with --begin set to the next scheduled cron time
# next-cron-time is a script that parses a cron schedule string and returns
# the next execution time
sbatch --quiet --begin=$(next-cron-time "$SCHEDULE") -A cron-account -p cron anita_ci_cron.sbatch
