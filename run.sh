#!/bin/bash -e

# This script pushes a demo-friendly version of your element and its
# dependencies to gh-pages.

# A gh-pages branch needs to exist, so before you run this script for the
# first time ever, make sure you ran
#     git branch -b gh-pages
#     git push --set-upstream origin gh-pages
# You don't ever need to run this again.

# Run in a clean directory passing in a GitHub org and repo name
org="notwaldorf"
repo="test-gh-pages-script"
folder="docs-pages"
#branch="master" # default to master when branch isn't specified

# make folder (same as input, no checking!)
rm -rf $repo
mkdir $repo
git clone https://github.com/$org/$repo.git --single-branch

# switch to gh-pages branch
pushd $repo >/dev/null
git checkout --orphan gh-pages

# this branch is now completely empty.
#echo "test" > index.md

## clone the wiki in here
git clone https://github.com/$org/$repo.wiki.git --single-branch $folder

# copy everything over
echo "copying things over..."
cp -R $folder/* .

# we don't need that git repo anymore
rm -rf $folder

# send it all to github
git add -A .
git commit -am 'deploy to gh-pages'
git push -u origin gh-pages --force

popd >/dev/null
