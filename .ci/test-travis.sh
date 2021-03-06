#!/bin/bash
AUTHOR=$1
PROJECT=$2

# https://stackoverflow.com/a/41935867
# Install travis-build to generate a .sh out of .travis.yml
cd $HOME/builds
git clone https://github.com/travis-ci/travis-build.git
cd travis-build
gem install travis
# to create ~/.travis
travis version
ln -s `pwd` ~/.travis/travis-build
bundle install

echo "Create project dir, assuming your project is $AUTHOR/$PROJECT on GitHub"
cd ~/builds
mkdir $AUTHOR
cd $AUTHOR
git clone https://github.com/$AUTHOR/$PROJECT.git
cd $PROJECT
echo  "change to the branch or commit you want to investigate"
travis compile > ci.sh
echo "You most likely will need to edit ci.sh as it ignores matrix and env"
bash ci.sh