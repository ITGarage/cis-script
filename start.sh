#!/usr/bin/env bash

# check the bash shell script is being run by root
if [ "$EUID" -ne 0 ]; then
    echo 'this script must be run with sudo'
    exit
fi
# set log file
logfile="report.txt"
echo "__________________________________________________________________________________________________________________" >$logfile

# link functions
ln -s functions.sh $PWD/p5/functions.sh

# view files in p5
find $PWD/p5/ -xdev -type f -name '5.*.sh' | xargs stat | grep 'File'

# set files on p5 executable
find $PWD/p5/ -xdev -type f -name '5.*.sh' | xargs chmod +x

# run all executable sctipts in /p5
run-parts --regex '\.sh$' $PWD/p5
