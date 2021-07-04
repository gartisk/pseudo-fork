#!/usr/bin/env bash

####################################################################################
##                                                                                ##
##   Pseudo-Fork                                                                  ##
##                                                                                ##
##   Authors: Guilherme Araujo aka Gartisk                                        ##
##            https://github.com/gartisk                                          ##
##                                                                                ##
##   Version: 0.1                                                                 ##
##   Last Update: July 03, 2021                                                   ##
##                                                                                ##
##   Reference:                                                                   ##
##   https://gist.github.com/0xjac/85097472043b697ab57ba1b1c7530274               ##
##                                                                                ##
##   Github easy alternative:                                                     ##
##   https://github.com/new/import                                                ##
##                                                                                ##
####################################################################################

export PATH=/bin:/usr/bin:/usr/local/bin

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT
ctrl_c() {
    exit 0
}

original_repo=$1
forked_repo=$2

echo 'pseudo-fork started'

# get original and forked folder name
[[ $original_repo =~ ^.*/(.*)$ ]]
original_folder=${BASH_REMATCH[1]}

[[ $forked_repo =~ ^.*/(.*)\.git$ ]]
forked_folder=${BASH_REMATCH[1]}

# clone original repo
git clone --bare $original_repo
cd $original_folder

# push to forked repo
git push --mirror $forked_repo
cd ..

# remove original repo folder
rm -r $original_folder

# create and clone forked repo
git clone $forked_repo

cd $forked_folder
# add original repo without push option
git remote add upstream $original_repo
git remote set-url --push upstream DISABLE

echo 'pseudo-fork finished'